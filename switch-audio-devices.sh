CURR_AUDIO=$(SwitchAudioSource -c)
if [[ "$CURR_AUDIO" = "MacBook Pro Speakers" ]]; then
	DEVICE="Corsair VOID Wireless Gaming Dongle"
else
	DEVICE="MacBook Pro Speakers"
fi

SwitchAudioSource -s $DEVICE
/usr/bin/env osascript <<< "display notification \"$DEVICE\" with title \"Audio Device Change\"";
