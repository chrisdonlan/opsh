#!/bin/bash
usage(){
cat << USAGE
`basename $0` FILE [DECRYPTED_OUTPUT_FILE]

	If the file ends in '.enc', it will be decrypted onto standard out. Otherwise,
 	the file will be encrypted to FILE.enc.

	NOTE: the original file is not destroyed.

	Cookbook:

		# recover secrets without touching the hard drive
		source <(echo "your-password" | ./enc.sh encrypted-file.enc)

USAGE
exit 0
}
[ -z "$1" ] && usage
DECRYPTED="$2"

read -r -s -p "password: " PASSWORD
if ! [[ "$1" =~ [.]enc$ ]]; then
	echo
	openssl enc -aes-256-cbc -iter 10 -in "$1" -out "$1.enc" -k ${PASSWORD}
else
	[ -n "${DECRYPTED}" ] && echo
	openssl enc -d -aes-256-cbc -iter 10 -in "$1" -out "${DECRYPTED:=/dev/stdout}" -k ${PASSWORD}

fi
