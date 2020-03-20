# RAK2245_for_helium
RAK2245 for helium

##  Installation procedure

step1 : Download and install [Raspbian Stretch or Buster LITE](https://www.raspberrypi.org/downloads/raspbian/) 

step2 : Use "sudo raspi-config" command, enable spi and i2c interface.

step3 : Clone the installer and start the installation.

      $ sudo apt update; sudo apt install git -y
      $ git clone https://github.com/RAKWireless/RAK2245_for_helium.git ~/RAK2245_for_helium
      $ cd ~/RAK2245_for_helium
      $ sudo ./install.sh


More things can be found here: https://forum.rakwireless.com/t/helium-hotspot-version-firmware-for-rpi-3-4-rak2245-pi-hat/1697
