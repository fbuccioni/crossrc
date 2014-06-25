# arg_handler.sh - Arguments handler

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
        echo "usage: $0 start|stop|restart"
    ;;
esac