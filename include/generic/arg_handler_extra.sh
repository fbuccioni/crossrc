# arg_handler_extra.sh - Arguments handler with an ugly support of extra functions

case $1 in
    start )
        start
        exit $?
    ;;
    stop )
        stop
        exit $?
    ;;
    restart )
        stop 
    	start
    ;;
    *)
        if [ ! -z "$extra_args" ]; then
            extra_args="|${extra_args}"
            if type $1 > /dev/null; then
                $1
                exit $?
            fi
        fiy

        echo "usage: $0 start|stop|restart$extra_args"
    ;;
esac