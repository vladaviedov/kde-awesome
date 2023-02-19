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

# Check for executables
if ! command -v awesome &> /dev/null
then
	echo "warning: awesome not installed"
fi
if ! command -v startplasma-x11 &> /dev/null
then
	echo "warning: plasma is not installed"
fi

# Install service
if [ ! -d $SYSTEMD_USER ]
then
	mkdir -p $SYSTEMD_USER
fi
cp files/plasma-awesome.service $SYSTEMD_USER
sed -i "/ExecStart/ s/HOME/$ESC_HOME/" $SYSTEMD_USER/plasma-awesome.service

# Install enabler script
$ASROOT cp files/startplasma-awesome $BIN_LOCAL
$ASROOT chmod 755 $BIN_LOCAL/startplasma-awesome

# Make xsession
$ASROOT cp files/plasma-awesome.desktop $XSESSIONS

echo "Installation Successful"
