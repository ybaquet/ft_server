#
#	Remove 'ft_server_bash' runs and/or 'ft_server' images
#
if [ $# = 0 ] || ( [ $1 != "a" ] && [ $1 != "i" ] && [ $1 != "r" ] )
then
	echo "usage is ./remove.sh a[ll] | r[un] | i[mage]"
else
	if [ $1 = "a" ] || [ $1 =  "r" ]
	then
		docker stop ft_server_bash
		docker rm ft_server_bash
	fi
	if [ $1 = "a" ] || [ $1 =  "i" ]
	then
		docker rmi ft_server
	fi
fi
