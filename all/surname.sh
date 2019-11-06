#!/bin/sh

# LC_ALL=C to prevent sed: RE error: illegal byte sequence
# as per https://stackoverflow.com/questions/11287564/getting-sed-error-illegal-byte-sequence-in-bash
LC_ALL=C sed -e 's/\n/fuckme/g'./surnames.csv > ./surnames-cleaned.csv
# gsed is gnu sed, different from mac sed
# idea from http://www.benjiegillam.com/2011/09/using-sed-to-replace-newlines/
# LC_ALL=C sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/fuckme/g' ./surnames.csv > ./surnames-cleaned.csv
echo "sed has search and replaced smith with cuntface"
