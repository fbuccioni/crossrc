cinfo() { log_daemon_msg $@ "${me}"; }

alias 	cbegin="cinfo" \
		cwarn="cinfo 'warning: '" \
		cerror="cinfo 'error: '"  
		
cend() { log_end_msg $@; }