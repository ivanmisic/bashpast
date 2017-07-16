#   Bashpast bookmarks your commands for easier invocation
#   Copyright (C) 2017 Ivan Misic
#
#   This file is part of Bashpast.
#
#   Bashpast is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   Bashpast is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with Bashpast.  If not, see <http://www.gnu.org/licenses/>.

bashpast_aliases="$HOME/.bashpast_aliases"

# print out help
function _bashpast_h {
    echo 'Bashpast bookmarks your commands for easier invocation'
    echo 'Copyright (C) 2017 Ivan Misic'
    echo ''
    echo 'Usage: bp <option> <bookmark_name>'
    echo ''
    echo 'Options:'
    echo 's <bookmark_name> - Saves the last command in history as "bookmark_name"'
    echo 'e <bookmark_name> - Execute the command associated with "bookmark_name"'
    echo 'd <bookmark_name> - Deletes the bookmark with the "bookmark_name"'
    echo 'l                 - Lists all available bookmarks'
}

# saves the last command in history bookmark as argument $1
function _bashpast_s {
    [ -z $1 ] && { echo "You should provide bookmark name with s argument" >&2; return 1; }

    tmpfile=$(mktemp -t bashpast.XXXXXX) || return 1
    HISTFILE=$tmpfile history -w
    numlines=$(wc -l $tmpfile | awk '{print $1}')
    head -n  $((( $numlines - 1 ))) $tmpfile > $tmpfile.new
    mv $tmpfile.new $tmpfile

    echo "function _bashpast_command_$1 { $(tail -n 1 $tmpfile); }" >> $bashpast_aliases

    rm $tmpfile
}

# executes the command associated with argument $1
function _bashpast_e {
    [ -z $1 ] && { echo "You should provide bookmark name with e argument" >&2; return 1; }

    . $bashpast_aliases

    _bashpast_command_$1
}

# deletes bookmark associated with argument $1
function _bashpast_d {
    [ -z $1 ] && { echo "You should provide bookmark name with d argument" >&2; return 1; }

    sed -i "/$1/d" $bashpast_aliases
}

# lists all bookmarks
function _bashpast_l {
    grep --color=never -Po "(?<=function _bashpast_command_).*(?={ ).*(?=; })" $bashpast_aliases | \
    awk '{split($0, array, "{"); printf("\033[0;33m%-20s\033[0m\t\t\t%s\n", array[1], array[2])}'
}

# main function
function bp {
    case $1 in
        s)
            _bashpast_s $2
            ;;
        e)
            _bashpast_e $2
            ;;
        d)
            _bashpast_d $2
            ;;
        l)
            _bashpast_l
            ;;
        h)
            ;&
        *)
            _bashpast_h
    esac
}
