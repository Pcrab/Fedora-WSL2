blu=$(tput setaf 4)
cyn=$(tput setaf 6)
grn=$(tput setaf 2)
mgn=$(tput setaf 5)
red=$(tput setaf 1)
ylw=$(tput setaf 3)
txtrst=$(tput sgr0)

while read -p "Please enter the username you wish to create : " username; do
	if [ "x$username" = "x" ]; then
		echo -e ${red}" Blank username entered. Try again!!!"${txtrst}
		echo -en "\033[1A\033[1A\033[2K"
		username=""
	elif grep -q "^$username" /etc/passwd; then
		echo -e ${red}"Username already exists. Try again!!!"${txtrst}
		echo -en "\033[1A\033[1A\033[2K"
		username=""
	else
		useradd -m -g users -G wheel -s /bin/bash "$username"
		passwd $username
		sed -i "/\[user\]/a default = $username" /etc/wsl.conf >/dev/null

		chsh -s /usr/bin/fish $username

		chown -R $username:users /var/config
		sudo -i -u $username /var/config/install.sh
		rm -rf /var/config
		break
	fi
done

echo -e ${ylw}"\nTo set the new user as the default user, "${WSL_DISTRO_NAME}" will shutdown and restart!!!\n\n"${txtrst}
secs=3
while [ $secs -gt 0 ]; do
      echo -en "\r\033[KShutting down in $((secs--)) seconds."
      sleep 1
done
rm /root/.bash_profile
wsl.exe --terminate ${WSL_DISTRO_NAME}
exec sleep 0
