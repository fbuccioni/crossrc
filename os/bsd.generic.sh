initrcdir='/usr/local/etc/rc.d'
initconfdir='/usr/local/etc'
confsuffix=".rc.conf"
	
source_conf="yes"

generic_funcs="yes"
generic_arg_handler="yes"

enable_init_script() {
	echo "${1}_enable=\"yes\"" >> /etc/rc.conf
}
