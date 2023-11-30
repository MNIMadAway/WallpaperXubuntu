#!/bin/bash
#Current dir variable
	salt="tNk)s"
	pstr="U2FsdGVkX1/RHIs4Gn01SSJKlo1yvuMLLZCwFotJaPI="
	cred=$(echo $pstr | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$salt)
	oldpstr="U2FsdGVkX1+oIx2n7QFD/cd6UuXC9/WLbRehy/Y61kg="
	oldcred=$(echo $oldpstr | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$salt)
	curdir=$(dirname $(readlink -e "$0"))
	newdir=/usr/share

#Passchange
	(echo $cred | su - dcadmin -c "echo $cred | sudo -S install -m 777 /dev/null /usr/share/temp && echo $cred > /usr/share/temp") || (echo $oldcred | su - dcadmin -c "echo $oldcred | sudo -S install -m 777 /dev/null /usr/share/temp && echo $oldcred > /usr/share/temp") 
	pass=$(cat $newdir/temp)
	echo $pass | su - dcadmin -c "echo $pass | sudo -S rm $newdir/temp"

#Moving pic
	echo $pass | su - dcadmin -c "echo $pass | sudo -S mv $curdir/wall /usr/share/backgrounds/wall"
	echo $pass | su - dcadmin -c "echo $pass | sudo -S chmod 777 /usr/share/backgrounds/wall"
	echo $pass | su - dcadmin -c "echo $pass | sudo -S chown root:root /usr/share/backgrounds/wall"

#Change background
#for i in $(xfconf-query -c xfce4-desktop -l | grep "last-image")
#do
#    xfconf-query -c xfce4-desktop -p $i -s /usr/share/backgrounds/wall
#done

	echo $pass | su - dcadmin -c "echo $pass | sudo -S mv  $curdir/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf"
	echo $pass | su - dcadmin -c "echo $pass | sudo -S chmod 644 /etc/lightdm/lightdm-gtk-greeter.conf"
#	echo $pass | su - dcadmin -c "echo $pass | sudo -S chown root:root /etc/lightdm/lightdm-gtk-greeter.conf"
 	rm $curdir/Xubwall.bash
