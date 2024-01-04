#!/usr/bin/env python3

import os, subprocess, re, datetime

class Event:
    def __init__(self, title, diff, ongoing, time, url):
        self.title = title
        self.title_cut = self.title[:100].strip()
        self.diff = diff
        self.human_diff = ':'.join(str(self.diff).split(':')[:-1])
        self.ongoing = ongoing
        self.time = time
        self.url = url
        if self.ongoing:
            self.human_str = f"{self.title_cut} {self.human_diff} left"
        else:
            self.human_str = f"{self.title_cut} in {self.human_diff}"

    def __repr__(self):
        return f"Event(title: {self.title}, diff: {self.diff}, ongoing: {self.ongoing}, time: {self.time}, url: {self.url})"

def remove_ansi(sometext):
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    result = ansi_escape.sub('', sometext)
    return result

def get_events():
    datetime_format = "%b %d, %Y %I:%M %p"
    datetime_format_v2 = "%b %d, %I:%M %p"
    now = datetime.datetime.now()
    # url_pattern = r'\b((?:https?://)?(?:(?:www\.)?(?:[\da-z\.-]+)\.(?:[a-z]{2,6})|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])))(?::[0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])?(?:/[\w\.-]*)*/?)\b'
    meet_pattern = r'\b((?:https?://)?meet.google.com/[a-zA-Z-]+)O'

    cmd = "icalBuddy -n -nc -nrd -npn -ea -ps '/|/' -nnr '' -b '' -ab '' -iep 'title,notes,datetime' eventsToday+1"
    output = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
    lines = output.decode('utf-8').strip().split('\n')

    events = []
    if lines == ['']: return events

    for line in lines:
        line=remove_ansi(line)
        splat = line.split('|')
        title = splat[0]

        urls = re.findall(meet_pattern, splat[1])
        url = (urls + [None])[0]
        if url is not None and 'meet' in url: url += '?authuser=0'

        timerange = splat[-1].replace('at ', '')
        startEndTime = timerange.split(' - ')
        starttime = startEndTime[0]
        endtime = startEndTime[1] if len(startEndTime) > 1 else startEndTime[0].split(" ")[-1]
        not_parsed_endtime=str(' '.join(starttime.split(" ")[:-2]) + ' ' + endtime).replace("\x1b[39m", "").replace("\x1b[33m", "")
        endtime = datetime.datetime.strptime(not_parsed_endtime, datetime_format_v2)
        starttime = datetime.datetime.strptime(starttime, datetime_format)

        ongoing = starttime <= now <= endtime
        if ongoing:
            diff = endtime-now
        else:
            diff = starttime-now

        time = ' '.join(timerange.split()[3:])

        events.append(Event(title, diff, ongoing, time, url))
    return events

def generate_main_text(events):
    next_event_text = ' > ' + events[1].human_str if (len(events) > 1 and events[0].ongoing) else ''
    return events[0].human_str + next_event_text

def plugin_undraw():
    args = [
        '--set upcoming label="No Upcoming Events"',
    ]
    os.system('sketchybar ' + ' '.join(args))

def plugin_draw(main_text, popup_items):
    args = [
        f'--set upcoming label="{main_text}"',
        '--set upcoming drawing=on',
    ]

    for i,item in enumerate(popup_items):
        args += [
            f'--add item upcoming.{i} popup.upcoming',
            f'--set upcoming.{i} background.padding_left=10',
            f'--set upcoming.{i} background.padding_right=10',
            f'--set upcoming.{i} label="{item["text"]}"',
            f'--set upcoming.{i} click_script="open {item["url"]} ; sketchybar --set upcoming popup.drawing=off"'
        ]

    os.system('sketchybar ' + ' '.join(args))

def remove_existing_entries():
    output, err = subprocess.Popen("sketchybar --query upcoming | jq '.popup.items[]'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
    if (err):
        return
    lines=output.decode('utf-8').strip().split('\n')
    for line in lines:
        os.system(f'sketchybar --remove {line}')

if __name__ == '__main__':
    remove_existing_entries()
    events = get_events()
    if len(events) == 0:
        plugin_undraw()
    else:
        main_text = generate_main_text(events)
        plugin_draw(main_text, ({'text': e.human_str, 'url': e.url} for e in events))
