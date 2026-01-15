CURR_AUDIO=$(SwitchAudioSource -c)
DEVICE="MacBook Pro Speakers"
if [[ "$CURR_AUDIO" = "MacBook Pro Speakers" ]]; then
	DEVICE="beyerdynamic AVENTHO 300"
fi

SwitchAudioSource -s "$DEVICE"
/usr/bin/env osascript <<< "display notification \"$DEVICE\" with title \"Audio Device Change\"";
