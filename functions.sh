# Function to print dots with optional message and delay

dots() {
    msg=${1:-}
    count=${DOTS_COUNT:-3}
    delay=${DOTS_DELAY:-1}

    [ -n "$msg" ] && printf '%s' "$msg"

    i=0
    if [ ! -t 1 ]; then
        # No TTY (CI/logs), print without delays
        while [ "$i" -lt "$count" ]; do
            printf '.'
            i=$((i+1))
        done
        printf '\n'
        return 0
    fi

    while [ "$i" -lt "$count" ]; do
        printf '.'
        sleep "$delay"     # Integers for POSIX portability
        i=$((i+1))
    done
    printf '\n'
}