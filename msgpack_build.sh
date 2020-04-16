#!/bin/bash
#Directory at the same level as msgpack-c
if test ! -d ./boost
then
    sudo mkdir boost
fi

cd ./boost
booturl=''
filename=''
foldername=''
testresult=0
msgtips="$(date)  START\n\n"

for ver in '1.63.0' '1.64.0' '1.65.0' '1.66.0' '1.67.0' '1.68.0' '1.69.0' '1.70.0' '1.71.0' '1.72.0'
do
    filename="boost_${ver//\./_}.tar.gz"
	foldername="boost_${ver//\./_}"
	if test ! -e ./${filename}
	then
		booturl="https://dl.bintray.com/boostorg/release/${ver}/source/${filename}"
		wget ${booturl}
	fi

	if test -e ./${filename}
	then
	    if test -d ./${foldername}
		then
			sudo rm -rf ./${foldername}
		fi
		tar -zxf ./${filename}
		if test $? -ne 0
		then
		    msgtips="${msgtips}Unzip ${filename} failed.\n"
		    continue
		fi

		cd  ./${foldername}

		./bootstrap.sh
		./b2
	
		#delete boost installed  files
		for x in `find /usr/local/lib/cmake/ -maxdepth 1 |grep -i boost`
		do
			sudo rm -rf $x
		done

		for x in `find /usr/local/ |grep -i boost`
		do
		    sudo rm -rf $x
		done

		if test -d /usr/local/include/boost
		then
		    sudo rm -rf /usr/local/include/boost
		fi
		#delete boost installed files end

		#install boost
		./b2 install

		cd ../
		sudo rm -rf ./${foldername}

		cd ../msgpack-c/
		git checkout cpp_master

		if test -d ./builds
		then
		   sudo rm -rf ./builds
		fi

		mkdir builds
		cd ./builds

		cmake -DMSGPACK_BOOST=1 ..
		make
		make test
		testresult=$?
		if test $[testresult] -eq 0
		then
		    msgtips="${msgtips}${foldername} test sueecss.\n"
		else
		    msgtips="${msgtips}${foldername} test failed.\n"
		fi

		cd ../
		sudo rm -rf ./builds
		cd ../boost/
	else
		msgtips="${msgtips}Download ${filename} failed.\n"
	fi

done

cd ../
result=''
result="${msgtips}\n$(date)  END"
echo -e ${result}
echo -e ${result} >> Result.txt
