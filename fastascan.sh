directory=$1
num=$2
filenum=0
uniqueIDs=0
seqnum=0
totallen=0
if [[ -z $directory ]] 
then
fastafa=$(find . -type f -or -type l -name "*.fasta" -or -name "*.fa")
else 
directory=$(find $1 -type d)
fastafa=$(find $directory -type f -name "*.fasta" -or -name "*.fa") 

fi
	for file in $fastafa 
		do 
			echo " "
			ID=$(grep '>' $file | sed 's/>//' | awk '{print $1}' | uniq -c | wc -l)
			uniqueIDs=$(( $uniqueIDs+$ID ))
	
			filenum=$(( $filenum + 1))
			
			if grep -v ">" $file | grep -iq '[MNDFLIBQZWVPYESR]'
			then 
			echo ==== FILE $file REPORT [amino acid sequence] ====
			else 
			echo ==== FILE $file REPORT [nucleotidic sequence] ====
			fi 
			echo " "
			seqnum=$(grep ">" $file | wc -l)
			echo "(+) Number of sequences is $seqnum"
			
		if [[ -h $file ]] 
		then 
			echo "(+) Symbolic link"
		else 
			echo "(+) Not a symbolic link"
		fi
		
		totallen=$(grep -v ">" $file | sed 's/-//g' | sed 's/ //g' | awk -v totallen=0 '{totallen=totallen + length($0)} END {print totallen}')
			
		echo "(+) Sequence length is $totallen"
		echo " "
		numlines=$(wc -l < $file)
		if [[ -n $num ]]
		then
		   if [[ $numlines -le $((2*$2)) ]]
          	   then 
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
	done

echo " "
echo SUMMARY
echo "(+) Number of fasta/fa files: $filenum"
echo "(+) Number of unique IDs in total: $uniqueIDs"
echo " "


