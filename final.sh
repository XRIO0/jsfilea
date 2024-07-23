#!/bin/bash

# Default output file
output_file_path="secrets.txt"

# Function to display help message
display_help() {
    echo "Usage: $0 [-i inputfile] [-o outputfile]"
    echo
    echo "   -i, --input     Specify the input file containing URLs"
    echo "   -o, --output    Specify the output file to store results"
    echo "   -h, --help      Display this help message"
    exit 1
}

# Parse command line options
while getopts ":i:o:h" opt; do
  case ${opt} in
    i)
      file_path=$OPTARG
      ;;
    o)
      output_file_path=$OPTARG
      ;;
    h)
      display_help
      ;;
    \?)
      echo "Invalid option: $OPTARG" 1>&2
      display_help
      ;;
    :)
      echo "Option $OPTARG requires an argument" 1>&2
      display_help
      ;;
  esac
done
shift $((OPTIND -1))

# Check if SecretFinder.py exists in the current directory
if [ ! -f ./SecretFinder.py ]; then
    echo "SecretFinder.py not found in the current directory. Please make sure it's present."
    exit 1
fi

# Check if the provided file exists
if [ ! -f $file_path ]; then
    echo "File not found at the provided location. Please check the file path."
    exit 1
fi

echo "################################"
echo "#                              #"
echo "#           jsfilea            #"
echo "#            v=1               #"
echo "################################"

# Read URLs from the file and run SecretFinder.py on each
while read url; do
    # Check if the URL ends with .js
    if [[ $url == *.js ]]; then
        echo "Processing $url"
        python3 SecretFinder.py -i $url -o cli >> $output_file_path
    fi
done < $file_path

echo "All URLs ending with .js have been processed. The results are stored in $output_file_path"

