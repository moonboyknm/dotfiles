#!/bin/bash

# Ensure the acpi_call module is loaded
sudo modprobe acpi_call

# Function to set Intelligent Cooling mode
set_intelligent_cooling() {
    echo "Setting Intelligent Cooling Mode"
    sudo bash -c 'echo "\_SB_.GZFD.WMAA 0 0x2C 2" > /proc/acpi/call'
}

# Function to set Extreme Performance mode
set_extreme_performance() {
    echo "Setting Extreme Performance Mode"
    echo '\_SB_.GZFD.WMAA 0 0x2C 3' | sudo tee /proc/acpi/call
}

# Function to set Battery Saving mode
set_battery_saving() {
    echo "Setting Battery Saving Mode"
    echo '\_SB_.GZFD.WMAA 0 0x2C 1' | sudo tee /proc/acpi/call
}

# Function to turn on Rapid Charge
turn_on_rapid_charge() {
    echo "Turning on Rapid Charge"
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' | sudo tee /proc/acpi/call
}

# Function to turn off Rapid Charge
turn_off_rapid_charge() {
    echo "Turning off Rapid Charge"
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' | sudo tee /proc/acpi/call
}

# Function to turn on Battery Conservation mode
turn_on_battery_conservation() {
    echo "Turning on Battery Conservation Mode"
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' | sudo tee /proc/acpi/call
}

# Function to turn off Battery Conservation mode
turn_off_battery_conservation() {
    echo "Turning off Battery Conservation Mode"
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x05' | sudo tee /proc/acpi/call
}

# Main script logic
case $1 in
    cooling)
        set_intelligent_cooling
        ;;
    extreme)
        set_extreme_performance
        ;;
    battery)
        set_battery_saving
        ;;
    rapid_on)
        turn_on_rapid_charge
        ;;
    rapid_off)
        turn_off_rapid_charge
        ;;
    conserve_on)
        turn_on_battery_conservation
        ;;
    conserve_off)
        turn_off_battery_conservation
        ;;
    *)
        echo "Usage: $0 {cooling|extreme|battery|rapid_on|rapid_off|conserve_on|conserve_off}"
        ;;
esac
