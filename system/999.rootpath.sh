# *** REMOVE '.' FROM PATH FOR ROOT
## Forces you to type ./command to run something in the current directory

if [ "$UID" == "0" ]; then
	export PATH=${PATH%%:.}
	export PATH=${PATH//:.:/:}
fi

