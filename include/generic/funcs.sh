# gen_funcs.sh - Generic functions
# Based in gentoo openrc runscripts

alias 	cbegin="echo -n" \
		cminfo="echo" \
		cwarn="echo 'warning:'" \
		cerror="echo 'error:'" \
		cdone="echo '...done'" \
		cfail="echo '...fail'" 

cend() { test  "$1" = "0" && cdone || cfail; return $1  }