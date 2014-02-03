if [ "$#" -lt 1 ]; then 	# -n tests to see if the argument is non empty
	echo "Missing laptop name"
    exit 1
fi

DIR=$(cd $(dirname "$0"); pwd)

sudo apt-get install xmonad trayer dmenu xmobar rxvt-unicode-256color -y

mv /usr/share/xsessions/xmonad.start /usr/share/xsessions/xmonad.start.original

ln -s $DIR/.xmonad ~/.xmonad
ln -s $DIR/$1/.xmobarrc ~/.xmobarrc
ln -s $DIR/.Xresources ~/.Xresources
ln -s $DIR/.Xresources ~/.Xdefaults

echo "[Desktop Entry]\nEncoding=UTF-8\nName=XMonad.mpenet\nComment=Lightweight tiling window manager\nExec=$DIR/$1/xmonad.start\nIcon=xmonad.png\nType=XSession" | sudo tee -a /usr/share/xsessions/xmonad-$1.desktop ;
