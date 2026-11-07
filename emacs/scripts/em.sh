#!/bin/sh

emacsc() {
    if [ -z "$1" ]; then
        emacsclient -c -n
    else
        emacsclient -c -n "$1"
    fi
}


if pgrep -x "emacs" > /dev/null 2>&1; then
    emacsc "$1"
else
    emacs --daemon
    emacsc "$1"
fi

