initrcdir='/etc/init.d'
initconfdir='/etc/conf.d'
interpreter="/bin/run"

source_conf="no"

generic_funcs="no"
replace_funcs="yes"
generic_arg_handler="no"

# func_replacement
func_cbegin="ebegin"
func_cinfo="einfo"
func_cwarn="ewarn"
func_cerror="eerror"
func_cend="eend"

enable_init_script() {
    [ "$2" = "" ] && t="default" || t="$2"
	rc-update add $1 $t
}