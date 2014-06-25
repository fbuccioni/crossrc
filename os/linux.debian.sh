initrcdir='/etc/init.d'
initconfdir='/etc/default'

source_conf="yes"

generic_funcs="yes"
generic_arg_handler="yes"

enable_init_script() {
    [ "$2" = "" ] && t="defaults" || t="$2"
	update-rc.d $1 $t
}