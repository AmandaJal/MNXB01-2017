#!/bin/bash

# pokemoninfo.sh
# call with: ./pokemoninfo.sh arg1


# use this function to show an error message with usage information.
errormsg() {
   echo "Usage:"
   echo "$0 <directory>"
   echo "directory must be a path containing a csv dataset."	
}

### Exercise 1
if [[ $# -eq 0 ]]; then
    errormsg
    exit 1
fi
#variable for the folder name
DBDIR=$1

### Exercise 2
if [ ! -d $1 ]; then
    errormsg
    exit 1
fi

### Exercise 3
echo -e "\nSearching for Pokémon Red..."
grep --include="poke.*" -nRHI "Pokémon Red Version" *

### Exercise 4
echo -e "\nRemoving old allplatforms.csv"
echo> allplatforms.csv
if [ -e allplatforms.csv ]; then
    rm allplatforms.csv
fi  
cd $DBDIR
#shouldn't be any here but just doublechecking
if [ -e allplatforms_temp.csv ]; then 
    rm allplatforms_temp.csv
fi

### Exercise 5
echo -e "\nCreating new allplatforms.csv"
echo> allplatforms_temp.csv #create a new empty file
cat header.csv > allplatforms_temp.csv #add the header
for f in poke.* ; do
    tail -n+2 $f >> allplatforms_temp.csv
done


### Exercise 6
echo -e "\nSorting allplatforms.csv..."

### Exercise 6: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'

# YOUR CODE HERE
sort -k 2 allplatforms_temp.csv > allplatforms.ordered_temp.csv


## Remove temp files
mv allplatforms_temp.csv ../My_results/allplatforms.csv
mv allplatforms.ordered_temp.csv ../My_results/allplatforms.ordered.csv

### Exercise 7
echo -e "\nCalculating number of games for each file..."
for f in *.csv ; do
    tail -n+2 $f >> tempfile.csv
    COUNT=$(wc -l < tempfile.csv)
    echo "$f has $COUNT game(s)"
    rm tempfile.csv  
done

exit 0;
