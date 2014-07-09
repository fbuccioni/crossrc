# platform.sh - os/vendor detection

kernel() {
    if [ "$( uname -a | grep -ci 'linux' )" -gt "0" ]; then
        echo "linux"
        return 0
    fi

    if [ "$( uname -a | grep -ci 'bsd' )" -gt "0" ]; then
        echo "bsd" 
        return 0
    fi

    echo "unknown"
    return 1
}

vendor() {

    if [ -f /etc/gentoo-release ]; then
        echo "gentoo"
        return 0
    fi

    for version_file in /proc/version /etc/lsb-release /etc/os-release /usr/lib/os-release; do
        if [ -f "${version_file}" ]; then
            for vendor in "ubuntu" "debian"; do
                if [ "$( grep -ci "${vendor}" "${version_file}")" -gt "0" ]; then
                    echo "${vendor}"
                    return 0
                fi
            done
        fi
    done

    echo "generic"
    return 1
}

os() {
    echo "$(kernel).$(vendor)"
}

kernel="$(kernel)"
vendor="$(vendor)"
os="$(os)"
