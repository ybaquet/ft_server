#
#	Remove all runs and/or all images
#
if [ $# = 0 ] || ( [ $1 != "a" ] && [ $1 != "i" ] && [ $1 != "r" ] )
then
	echo "usage is ./all_remove.sh a[ll] | r[un] | i[mage]"
else
	if [ $1 = "a" ] || [ $1 =  "r" ] ]
	then
		docker stop $(docker ps -a -q)
		docker rm $(docker ps -a -q)
	fi
	if [ $1 = "a" ] || [ $1 =  "i" ]
	then
		docker rmi -f $(docker images -a -q)
	fi
fi