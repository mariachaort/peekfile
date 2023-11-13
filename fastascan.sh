direcpath=$1

num=$2
uniqueIDs=0
seqnum=0
if [[ -z $direcpath ]] 
then 
fasta=$(find . -type f -name "*fasta")
fa=$(find . -type f -name "*fa")
	
	for x in $fasta 
		do 
		echo ==== FILE $x REPORT ====
		ID=$(grep '>' $x | sed 's/>//' | awk '{print $1}' | uniq -c | wc -l)
		uniqueIDs=$(( $uniqueIDs+$ID ))
		seqnum=$(grep ">" $x | wc -l)
		echo "The number of sequences in file  [ $x ] is $seqnum"
		if [[ -h $x ]] 
		then 
		echo "The file [ $x ] is a symbolic link"
		else 
		echo "The file [ $x ] in not a symbolic link"
		fi
		done

		
else 
fasta=$(find ./"$direcpath"/* -type f -name "*.fasta*") 
fa=$(find ./"$direcpath"/* -type f -name "*.fa*")
fi

echo -Number of fasta files: $(find . -type f -name "*fasta" | wc -l)
echo -Number of fa files: $(find . -type f -name "*fa" | wc -l)
echo -Number of unique IDs in total: $uniqueIDs
