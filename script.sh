#!/bin/bash

#System updates
sudo dnf update -y
sudo dnf install -y \
 https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#Flatpaks (Apps)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.prismlauncher.PrismLauncher
flatpak install flathub com.google.Chrome
flatpak install flathub com.discordapp.Discord  
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub sh.ppy.osu
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub org.kde.krita

#Complementary apps
sudo dnf install -y unzip
sudo dnf install -y gnome-tweaks 
curl https://getmic.ro | bash
sudo mv micro /usr/bin

for arg in "$@"
do
	#Tablet driver xp pen
	if [ $arg == "--xppen" ]; then
		echo "Downloading xp pen driver..."
		wget -P ~/Documents/ https://www.xp-pen.com/la-pt/download/file.html?id=2106&pid=718&ext=gz
		wait
		cd ~/Documents
		mv "file.html?id=2106" file.tar.gz
		tar -xvzf file.tar.gz
		directory=$(find . -name "XPPenLinux*")
		cd "$directory"
		sudo ./install.sh
		cd ..
		rm file.tar.gz
		echo "Installation Finished!"
	elif [ $arg == "--opentablet" ]; then
		echo "Downloading open tablet driver..."
		wget -P ~/Documents/ https://github.com/OpenTabletDriver/OpenTabletDriver/releases/latest/download/OpenTabletDriver.rpm
		wait
		cd ~/Documents
		sudo dnf install ./OpenTabletDriver.rpm
		sudo dracut --regenerate-all --force
		echo "Installation Finished!"
		echo "Just type 'otd-daemon' to start the driver process"
	fi
done
