#!/bin/bash

case "$1" in
    get)
        powerprofilesctl get
        ;;
    icon)
        current_profile=$(powerprofilesctl get)
        case "$current_profile" in
            power-saver)
                echo ""
                ;;
            balanced)
                echo "⚖"
                ;;
            performance)
                echo ""
                ;;
            *)
                echo ""
                ;;
        esac
        ;;
    cycle)
        current_profile=$(powerprofilesctl get)
        case "$current_profile" in
            power-saver)
                powerprofilesctl set balanced
                ;;
            balanced)
                powerprofilesctl set performance
                ;;
            performance)
                powerprofilesctl set power-saver
                ;;
            *)
                powerprofilesctl set balanced
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 {get|icon|cycle}"
        exit 1
        ;;
esac