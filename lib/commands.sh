cmd_build() {	
	info "--> Building project '$1'"

	local srcdir="$1"
	local name="$(basename $1)"

	local src_workdir="${workdir}/${name}"
	local src_distdir="${distdir}/${name}/${os}"

	local work_script="${src_workdir}/initrc"

	local src_inc_dir="${srcdir}/include"
	local src_os_conf="${srcdir}/os/${os}.sh"
	local src_os_inc_dir="${src_inc_dir}/${os}"
	local src_gen_inc_dir="${src_inc_dir}/generic"

	# prepare
	[ ! -d "$src_workdir" ] && mkdir -p "$src_workdir"

	. "${os_conf}"
	[ -f "${src_os_conf}" ] && . "${src_os_conf}" 
	[ -f "${srcdir}/crossrc.conf" ] && . "${srcdir}/crossrc.conf" 

	touch $work_script

	# head
	headfile="$( first_existing \
						"${src_os_inc_dir}/head.sh" \
						"${os_inc_dir}/head.sh" \
						"${gen_inc_dir}/head.sh" 
	)"

	write_script ${work_script} "$(cat ${headfile})"


	# config
	if [ -z "${initconfdir}" ]; then
		warn "The initconfdir is not set for this script/platform. You have to call the conf manually"
	elif can $source_conf; then
		append_script ${work_script} ". ${initconfdir}/${name}${confsuffix}"
	fi

	# Custom/Generic funcs
	if use $generic_funcs; then
		funcfile="${gen_inc_dir}/funcs.sh"
	else
		funcfile="$( first_existing \
							"${src_os_inc_dir}/funcs.sh" \
							"${src_inc_dir}/funcs.sh" \
							"${os_inc_dir}/funcs.sh" 
		)"
	fi

	[ -f "${funcfile}" ] \
		&& append_script ${work_script} "$(cat ${funcfile})"

	# da file	
	append_script ${work_script} "$(cat "${srcdir}/initrc")"

	# Replaced funcs
	if can $replace_funcs ; then 
		> "${src_workdir}/sed_script"
		for func in cbegin cinfo cwarn cerror cend; do
			append_script "${src_workdir}/sed_script" 's/\\([ \\t]*\)'"${func}"'\([ \\t]*\\)/\\1'$(eval "echo \"\${func_${func}}\"")'\\2/g'
		done

		sed -f "${src_workdir}/sed_script" -E "${work_script}" > "${src_workdir}/initrc_replaced" 

		mv "${work_script}" "${src_workdir}/initrc_unseded" 
		mv "${src_workdir}/initrc_replaced" "${work_script}"
	fi


	# foot
	footfile="$( first_existing \
						"${src_os_inc_dir}/foot.sh" \
						"${os_inc_dir}/foot.sh" \
						"${gen_inc_dir}/foot.sh" 
	)"

	append_script ${work_script} "$(cat ${footfile})"

	# argument parser
	if use $generic_arg_handler; then
		arghandlerfile=""

		[ -z "${extra_args}" ] \
			&& arghandlerfile="${gen_inc_dir}/arg_handler.sh" \
			|| arghandlerfile="${gen_inc_dir}/arg_handler_extra.sh"

	else
		arghandlerfile="$( first_existing \
							"${src_os_inc_dir}/arg_handler.sh" \
							"${src_inc_dir}/arg_handler.sh" \
		)"
	fi

	[ ! -z ${arghandlerfile} ] \
		&& append_script ${work_script} "$(cat ${arghandlerfile})"

	mkdir -p "${src_distdir}"
	cp -p "${work_script}" "${src_distdir}"
	info "--> Init RC Script builded in '${src_distdir}/initrc'"

	if [ -f "${srcdir}/config" ]; then
		cp -p "${srcdir}/config" "${src_distdir}"
		info "--> Config file copied in '${src_distdir}/config'"
	fi

	info "--> Build complete\n"
}

cmd_install() {
	local name="$(basename $1)"
	local srcdir="${1}"
	
	local src_workdir="${workdir}/$name"
	local src_distdir="${distdir}/${name}/${os}"

	local src_inc_dir="${srcdir}/include"
	local src_os_inc_dir="${src_inc_dir}/${os}"
	local src_gen_inc_dir="${src_inc_dir}/generic"

	if [ -z "${initrcdir}" -o -z "${initconfdir}" ]; then
		warn "Your actual configuration of platform doesn't support install, install it manually"
		return 1
	fi

	# Install initrc script
	initrcfile="${initrcdir}/${name}"
	info "--> Installing initrc script as ${initrcfile}..."
	install -o 0 -g 0 -v -m 755 "${src_distdir}/initrc" "${initrcfile}"

	# Install conf
	if [ -f "${srcdir}/config" ]; then
		configfile="${initconfdir}/${name}${confsuffix}"

		info "--> Installing config as ${initrcfile}"
		install -o 0 -g 0 -v -m 640 "${src_distdir}/config" "${configfile}"
	fi

	# Init script
	if type enable_init_script > /dev/null ; then 
		info "---> Activating as a service..."
		enable_init_script "${name}" "${init_runlevel}"
	fi

	# Platform specific postinstall
	os_postinstall=$(first_existing \
							"${src_os_inc_dir}/post-install.sh" \
							"${os_inc_dir}/post-install.sh" 
	);

	if [ -z "${os_postinstall}" ]; then 
		info "---> Running platform post-instal script '${os_postinstall}'"
		. $os_postinstall 
	fi

	# Source post-install script
	src_postinstall="${src_inc_dir}/post-install.sh"

	if [ -f "${src_postinstall}" ]; then
		info "---> Running source post-instal script '${src_postinstall}'"
		. $src_postinstall
	fi

	info "--> Install complete\n"
}

cmd_clean() {
	name="$(basename $1)"
	src_workdir="${workdir}/$name"

	info -n "--> Cleaning workdir ${src_workdir}:"
	rm -rfv ${src_workdir}
	info "--> Clean complete\n"
}