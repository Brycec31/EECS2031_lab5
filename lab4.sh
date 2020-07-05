#!/bin/sh
#Bryce Cooke 217346354
printf "Use: " #asks the user for a path and stores it
read use
if test -z "$use" || test ! -d $use  #checks to see if the path was given
then
	echo "You should enter the path name for class files" #Tells the user that no path was given
	exit
fi
res=$(find $use -type f -name '*.rec' -readable) #variable that contains all readable .rec files in path
index=$(find $use -type f -name '*.rec' -readable | wc -l) #number of found .rec files
indexplus1=`expr $index + 1`
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
				echo "goodbye"
				exit
			elif test $command = "ci" #If the command is "ci" the course name and credits are retrived from found files
			then
				echo "Found courses are:"
				colist=$(find $use -type f -name '*.rec' -readable | grep -n '')
				for((i=2; i<=$indexplus1; i++))
				do
					iminusone=`expr $i - 1`
					filename=$(grep "$iminusone" <<< $colist | cut -d ':' -f $i)
					if test $i -lt $indexplus1
					then
						filename=$(cut -d $i -f 1 <<< $filename)#extra git comment
					fi
					cooutput=$(grep -i 'COURSE' $filename | cut -d ':' -f 2 | sed -e 's/^\s*//g' -e 's/\s*$//g')
					credits=$(grep -i 'credit' $filename | cut -d ':' -f 2 | sed -e 's/^\s*//g')
					echo "$cooutput has $credits credits."
				done
			elif test $command = "sl" #If command is "sl", the student numbers are retrived from the .rec files and listed
			then
				echo "Here is the unique list of student numbers in all courses:"
				find $use -type f -name '*.rec' -readable | xargs grep  '[0-9][0-9][0-9][0-9][0-9][0-9]'| cut -d ":" -f 2 | cut -c 1-6
			elif test $command = "sc" #If command is "sc", the number of student entries in all .rec files are listed
			then
				attendance=$(find $use -type f -name '*.rec' -readable | xargs  grep '[0-9][0-9][0-9][0-9][0-9][0-9]' | wc -l)
				echo "There are $attendance registered students in all courses"
			elif test $command = "cc" #If command is "cc", the number of found .rec files is listed
			then
				echo "There are $index course files"
			elif test $command = "h" || test $command = "help" #If command is "h or help", the following message is printed
			then
				echo "l or list: lists found courses"
				echo "ci: gives the name of all courses plus number of credits"
				echo "sl: gives a unique list of all students registered in all courses"
				echo "sc: gives the total number of unique students registered in all courses"
				echo "cc: gives the total number of found course files"
				echo "h or help: prints the current message"
				echo "q or quit: exits from the script"
			else
				echo "Unrecognized command!" #if command is none of the above, it alerts the user and asks again
			fi
	done
fi



		
