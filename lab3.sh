#!/bin/sh
#Bryce Cooke 217346354
printf "Use: " #asks the user for a path and stores it
read use
if test -z "$use" #checks to see if the path was given
then
	echo "You should enter the path name for class files" #Tells the user that no path was given
	exit
fi
res=$(find $use -type f -name '*.rec' -readable) #variable that contains all readable .rec files in path
	if test -z "$res" #checks to see if res is empty, that is no readable .rec files were found
	then
		echo "No readable *.rec files exist in specified path or its subdirectories" #Alerts the user of the lack of readable .rec files in path
		exit
	else
		while true #this code will run until the user enters "quit"
		do
			printf "command: " #asks the user for a command and stores it
			read command
			if test $command = "list" || test $command = "l"  #if the command is "list", readable .rec files are listed
			then
				echo "Here is the list of found class files"
				echo "$res"
			elif test $command = "quit" || test $command = "q"  #if command is "quit", exits
			then
				exit #git comment
			else
				echo "Unrecognized command!" #if command is neither quit or list, it alerts the user and asks again
			fi
	done
fi



		
