#
#	build 'ft_server' image and/or run 'ft_server_bash' and/or exec bash inside 
#
if [ $# = 0 ] || ( [ $1 != "a" ] && [ $1 != "b" ] && [ $1 != "r" ] && [ $1 != "e" ] && [ $1 != "re" ] )
then
	echo "usage is ./run.sh a[ll] | b[uild] | r[un] | e[xec] | re"
else
	if [ $1 = "a" ] || [ $1 =  "b" ]
	then
		docker build . -t ft_server
	fi
	if [ $1 = "a" ] || [ $1 =  "re" ] || [ $1 =  "r" ]
	then
		docker run --name ft_server_bash -d -p 80:80 -p 443:443 ft_server
	fi
	if [ $1 = "a" ] || [ $1 =  "re" ] || [ $1 =  "e" ]
	then
		docker exec -it ft_server_bash bash
	fi
fi
