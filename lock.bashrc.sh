# some utilities for handling digital ocean credentials
unlock(){
	[ -z "$1" ] && echo "usage: unlock ENV_FILE_BASENAME (e.g. foo in bar/foo.env.enc)" && exit 1
	read -r -s -p "password: " PASSWORD && echo
	source <(echo "$PASSWORD" | lock.sh  "$1.env.enc")
}
lock(){
	[ -z "$1" ] && echo "usage: lock ENV_FILE_BASENAME (e.g. foo in bar/foo.env)" && exit 1
	lock.sh "$1.env"
	rm "$1.env"
}

alias dlock='lock ~/.digitalocean/$(basename `pwd`)'
alias dunlock='unlock ~/.digitalocean/$(basename `pwd`)'
