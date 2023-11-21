directory=$1
num=$2
filenum=0
uniqueIDs=0
seqnum=0
totallen=0
if [[ -z $directory ]] 
then
fastafa=$(find . -type f -or -type l -name "*.fasta*" -or -name "*.fa*")
else 
directory=$(find $1 -type d)
fastafa=$(find $directory -type f -or -type l -name "*.fasta*" -or -name "*.fa*") 
fi
	for file in $fastafa 
		do 
			seqcon=$(grep -v ">" $file | grep -i [MNDFLIBQZWVPYESR])
			if [[ $? -eq 0 ]]
			then 
			echo ==== FILE $file REPORT [amino acid sequence] ====
			else 
			echo ==== FILE $file REPORT [nucleotidic sequence] ====
			fi 
			echo " "
			ID=$(grep '>' $file | sed 's/>//' | awk '{print $1}' | uniq -c | wc -l)
			uniqueIDs=$(( $uniqueIDs+$ID ))
			seqnum=$(grep ">" $file | wc -l)
			echo The number of sequences in file  [ $file ] is $seqnum
			filenum=$(( $filenum + 1))
			
		if [[ -h $file ]] 
		then 
			echo "The file [ $file ] is a symbolic link"
		else 
			echo "The file [ $file ] in not a symbolic link"
		fi
		seqlength=0
		
		totallen=$(grep -v ">" $file | sed 's/-//g' | sed 's/ //g' | awk -v totallen=0 '{totallen=totallen + length($0)} END {print totallen}')
			
		echo The sequence length of $file is $totallen
		
		numlines=$(wc -l $file)
			if [[ -z $num ]] 
			then break
				if [[ $numlines -le $((2*$2)) ]]
				then 
				echo = Displaing full content of $file =
				cat $file 
			
			else 
				echo " "
				echo = Cannot display full content of $file =
				head -n $num $file 
				echo ...
				tail -n $num $file
				fi
			fi
	        done

echo " "
echo "(+)"Number of fasta/fa files: $filenum
echo "(+)"Number of unique IDs in total: $uniqueIDs
echo " "
echo " "

