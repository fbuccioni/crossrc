first_existing() {
	while [ ! -z "${1}" ]; do
		if [ -f "${1}" ]; then
			echo "${1}"
			break
		fi
		shift
	done
}

write_script() {
	local file="${1}"; shift
	echo "$@" > $file 
	echo "$@";
}

append_script() {
	local file="${1}"; shift
	echo "$@" | grep -v '^#!' >> $file 
}

can() {
	[ "$1" = "yes" ]
	return $?
}

alias use="can"

os_conf_dir="${crossrc}/dist/${os}"