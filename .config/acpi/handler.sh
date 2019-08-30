#!/bin/bash
# Default acpi script that takes an entry for all actions

noti() {
    local uid=$(id -u chan)
    sudo -u chan DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus notify-send -h string:x-canonical-private-synchronous:anything "$@"
}

case "$1" in
	button/volumedown)
		case "$2" in
			VOLDN)
				logger 'volume down'
                result=$(amixer set Master 5%- | tail -n 1 | awk '{print substr($4,2,length($4)-2)}')
                noti "volume down" $result
				;;
		esac
		;;
	button/volumeup)
		case "$2" in
			VOLUP)
				logger 'volume up'
                result=$(amixer set Master 5%+ | tail -n 1 | awk '{print substr($4,2,length($4)-2)}')
                noti "volume up" $result
				;;
		esac
		;;
	button/mute)
		case "$2" in
			MUTE)
				logger 'volume mute'
                result=$(amixer set Master toggle | tail -n 1 | awk '{print $NF'})
                if [ "$result" = "[on]" ]; then
                    noti volume muted
                else
                    noti volume unmuted
                fi;
				;;
		esac
		;;
	video/brightnessdown)
		case "$2" in
			BRTDN)
				logger 'bright down'
				backlight -5
                noti bright down
				;;
		esac
		;;
	video/brightnessup)
		case "$2" in
			BRTUP)
				logger 'bright up'
				backlight +5
                noti bright up
				;;
		esac
		;;
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'PowerButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger 'SleepButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        ;;
                    00000001)
                        logger 'AC pluged'
                        ;;
                esac
                ;;
            ACPI0003:00)
                case "$4" in
                    00000000)
                        logger 'AC pluged'
                        noti AC unpluged
                        ;;
                    00000001)
                        logger 'AC pluged'
                        noti AC pluged
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    video/tabletmode)
        case "$2" in
            TBLT)
                case "$4" in
                    00000000)
                        logger 'Latch attached'
                        noti latch attached
                        ;;
                    00000001)
                        logger 'Latch detached'
                        noti latch detached
                        ;;
                esac
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
                ;;
            open)
                logger 'LID opened'
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
    esac
    ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
