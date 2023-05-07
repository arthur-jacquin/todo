#!/bin/sh
# todo - A simple task manager.
# https://jacquin.xyz/todo

LISTS_FOLDER="$HOME/lists"
DEFAULT_WORKING_LIST="main"

args_nb_error()
{
    >&2 echo "Bad number of arguments. See the manual for more information."
    exit 1
}

fail_if_not_positive_integer()
{
    if [ $(expr "$1" : "[1-9][0-9]*$") -eq "0" ]
    then
        >&2 echo "$1 is not a positive integer."
        exit 1
    fi
}

if [ $LIST ]
then
    WL=$LIST
else
    WL=$DEFAULT_WORKING_LIST
fi

mkdir -p $LISTS_FOLDER

case "$1" in
"lists")
    # display the existing lists names
    ls $LISTS_FOLDER/*.txt 2> /dev/null | while read path
    do
        echo $(basename $path ".txt")
    done
    ;;

"create")
    # create a new list
    if   [ "$#" -eq "2" ]; then LIST="$2"
    else args_nb_error
    fi
    touch "$LISTS_FOLDER/$LIST.txt"
    ;;

"remove")
    # remove a list
    if   [ "$#" -eq "2" ]; then LIST="$2"
    else args_nb_error
    fi
    rm -f "$LISTS_FOLDER/$LIST.txt"
    ;;

"show")
    # show tasks (of list $WL if no list is specified)
    if   [ "$#" -eq "1" ]; then LIST="$WL"
    elif [ "$#" -eq "2" ]; then LIST="$2"
    else args_nb_error
    fi
    cat -n "$LISTS_FOLDER/$LIST.txt"
    ;;

"add")
    # add a task (to $WL if no list is specified)
    if   [ "$#" -eq "2" ]; then LIST="$WL"
    elif [ "$#" -eq "3" ]; then LIST="$3"
    else args_nb_error
    fi
    echo "$2" >> "$LISTS_FOLDER/$LIST.txt"
    ;;

"del")
    # delete the selected task (from $WL if no list is specified)
    if   [ "$#" -eq "2" ]; then LIST="$WL"
    elif [ "$#" -eq "3" ]; then LIST="$3"
    else args_nb_error
    fi
    fail_if_not_positive_integer "$2"
    sed -i "$2d" "$LISTS_FOLDER/$LIST.txt"
    ;;

"mv")
    # move the selected task to the specified list
    # (from $WL if no source list is specified)
    if   [ "$#" -eq "3" ]; then SRC_LIST="$WL"; DEST_LIST="$3"
    elif [ "$#" -eq "4" ]; then SRC_LIST="$3";  DEST_LIST="$4"
    else args_nb_error
    fi
    fail_if_not_positive_integer "$2"
    sed -n "$2p" "$LISTS_FOLDER/$SRC_LIST.txt" >> "$LISTS_FOLDER/$DEST_LIST.txt"
    sed -i "$2d" "$LISTS_FOLDER/$SRC_LIST.txt"
    ;;

*)
    # print a help message
    echo "todo - a task manager"
    echo
    echo "Available commands:"
    echo "    todo lists"
    echo "    todo create <list>"
    echo "    todo remove <list>"
    echo "    todo show [<list>]"
    echo "    todo add \"<task>\" [<list>]"
    echo "    todo del <task_id> [<list>]"
    echo "    todo mv <task_id> [<src_list>] <dest_list>"
    echo
    echo "See the manual for more information."
    exit 1
    ;;
esac
