num=$2
if [[ -z "$num" ]]; then num=3; fi

numlines=$(wc -l < "$1")

if [[ "$numlines" -le $((2*num)) ]]; 
then cat "$1"
else 
	echo "Warning: not all lines will be displayed";
	head -n "$num" "$1";
	echo "…";
	tail -n "$num" "$1";
fi

