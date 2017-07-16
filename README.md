# Bashpast
###  Bashpast bookmarks your commands for easier invocation

* * *

## Install

1. git clone git@github.com:ivanmisic/bashpast.git
2. cd bashpast && make
3. append in **~/.bashrc** file the following line `source **~/.local/bin/bashpast.sh`

## Shell Commands

    bp s <bookmark_name> - Saves the last command in history as "bookmark_name"
    bp e <bookmark_name> - Execute the command associated with "bookmark_name"
    bp d <bookmark_name> - Deletes the bookmark with the "bookmark_name"
    bp l                 - Lists all available bookmarks
    
## Example Usage

Save a bookmark
    $ echo "I will bookmark this command"
    $ I will bookmark this command
    $ bp s echo

Execute a bookmarked command
    $ bp e echo
    $ I will bookmark this command

List all bookmarks
    $ bp l

