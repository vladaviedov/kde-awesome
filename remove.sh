#!/bin/bash
AWESOME_CONFIG=$HOME/.config/awesome
SYSTEMD_USER=$HOME/.config/systemd/user
BIN_LOCAL=/usr/local/bin
XSESSIONS=/usr/share/xsessions
ESC_HOME=${HOME//\//\\\/}

# sudo or doas
if command -v doas &> /dev/null
then
	ASROOT=doas
else
	if command -v sudo &> /dev/null
	then
		ASROOT=sudo
	else
		echo "Install failed: neither sudo nor doas are installed"
		exit 1
	fi
fi

# Remove files
rm $SYSTEMD_USER/plasma-awesome.service
$ASROOT rm $BIN_LOCAL/startplasma-awesome
$ASROOT rm $XSESSIONS/plasma-awesome.desktop

echo "Removal Successful"
