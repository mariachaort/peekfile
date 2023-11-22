directory=$1   # Initializing variables 
num=$2
filenum=0
uniqueIDs=0
seqnum=0
totallen=0
if [[ -z $directory ]]; then
fastafa=$(find . -type f -or -type l -name "*.fasta" -or -name "*.fa")
else 
directory=$(find $1 -type d)
fastafa=$(find $directory -type f -or -type l -name "*.fasta" -or -name "*.fa") 
fi
        echo "Calculating unique IDs and number of files..."
        sleep 1
	for file in $fastafa; do 
		if grep -qI '>' $file; then                                                             # Checking if the file contains sequences (">") and skipping binaries to avoid errors
         		echo " "
			ID=$(grep '>' $file | sed 's/>//' | awk '{print $1}' | sort | uniq -c | wc -l)  # Retrieving ID sequences and getting only the count of unique IDs  
			uniqueIDs=$(( $uniqueIDs+$ID ))
			filenum=$(( $filenum + 1))							# Sum +1 every time we have a new file to count the total files
		
			seqnum=$(grep ">" $file | wc -l)						# Number of sequences in the current file
			
		if [[ -h $file ]]; then                                                                 # Checking whether it is a symbolic link or not
			link="Symbolic link"
		else 
			link="Not symbolic link"
		fi
		
		totallen=$(grep -v ">" $file | sed 's/-//g' | sed 's/ //g' | awk -v totallen=0 '{gsub("\n", ""); totallen=totallen + length($0)} END {print totallen}')  # Discarding gaps and spaces, 
		                                                                                                                                    # and summing the length of every line in the file  
	       if grep -v ">" $file | grep -qi [MDFLIBQZWVPYESR]; then                                 # Testing if the content of the sequences has any of the aminoacids except A,T,G,C and N 
	       											       # Printing all the information
			echo ==== FILE $file REPORT [aminoacidic sequence] ====
			echo Number of Sequences = $seqnum - $link - Total Sequence Length = $totallen 
		else 
			echo ==== FILE $file REPORT [nucleotidic sequence] ====
			echo Number of Sequences = $seqnum - $link - Total Sequence Length = $totallen 
		fi 
		
		numlines=$(wc -l < $file)
		if [[ -n $num ]]; then                                                                 # Testing if there is input for number of lines and then displaying full content or not 
		   if [[ $numlines -le $((2*$2)) ]]; then 
			echo = Displaying full content =
			cat $file 
		   else 
			echo " "
			echo = Cannot display full content =
			head -n $num $file 
			echo ...
			tail -n $num $file
			fi
		fi
	   fi 
	done
echo " "
echo SUMMARY
echo "(+) Number of fasta/fa files: $filenum"
echo "(+) Number of unique IDs in total: $uniqueIDs"
echo " "
