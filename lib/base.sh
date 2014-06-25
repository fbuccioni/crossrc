alias info="echo"
alias warn="echo 'warning:'"
alias error="echo 'error:'"

lookup_srcdir() {
    for d in "$PWD/src" "$crossrc/../src" ; do
        info -n "-> Checking for sources directory $d ... "

        if [ -d "$d" ]; then
            cd $d 
            srcdir="${PWD}" 
            info "found!"
            break
        else
            info "not found"
        fi
    done

    if [ "${srcdir}" = "" ]; then
        error "Sources directory not found."
        exit 1
    fi

    cd ${srcdir}/../

    basedir="${PWD}"

    builddir="${basedir}/build"
    distdir="${basedir}/dist"
    workdir="${basedir}/work"
    incdir="${crossrc}/include"

    osdir="${crossrc}/os"
    os_conf="${osdir}/${os}.sh"

    os_inc_dir="${crossrc}/include/${os}"
    gen_inc_dir="${crossrc}/include/generic"

    if [ ! -f "${os_conf}" ]; then
        error "Unsupported platform."
        exit 1
    fi
}

valid_args(){
    while getopts "k:v:" opt; do
        case "${opt}" in
            (k) kernel="$OPTARG";;
            (v) vendor="$OPTARG";;
        esac      
    done

    os="${kernel}.${vendor}"

    while true; do
        if [ "$(echo "${1}"|cut -c1-1)" = "-" ]; then
            shift
        elif ( ! type "cmd_${1}" > /dev/null ); then
            error "command '${1}' not recognized."
            exit 1
        else
            crossrc_commands="${crossrc_commands} ${1}"
        fi
        shift
        [ -z "${1}" ] && break
    done
}

title() {
    echo "CrossRC ${version}         2014 Felipe A. Buccioni \n";
}

usage() {
    cat <<MSG
$0: [options] command [command2]...

Options are:
       -k           Kernel type, 'linux', 'bsb', 'unknown', etc."
       -v           OS vendor or 'generic'"

Commands are:
        build       Build init rc script
        install     Install init rc script and the configuration the 
                    directories may change in diferrent platforms.

MSG
}