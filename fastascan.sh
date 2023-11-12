direcpath=$1

num=$2
if [[ -z $direcpath ]] 
then 
fasta=$(find . -type f -name "*fasta" | wc -l) 
fa=$(find . -type f -name "*fa" | wc -l)
else 
fasta=$(find /$direcpath -type f -name "*fasta" | wc -l) 
fa=$(find /$direcpath -type f -name "*fa" | wc -l)
fi

echo Number of fasta files: $fasta 
echo Number of fa files: $fa


