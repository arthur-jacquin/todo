# todo

A simple task manager.

## Description

todo is a POSIX shell script that helps you manage to-do lists. Lists are plain
.txt files located in a given folder (by default $HOME/lists), with the
assumption that each line is a task.

Having several lists might help in staying organised: a default list,
short/mid/long term lists, specific events, themed bookmarks... Grouping lists
in a given folder helps for making backups, for example with a version control
system.

todo uses $LIST as the default list. If the variable is empty, "main" is used.


## Usage

Generic invocation:

    todo <command> [<args> ...]

Manage lists:

    todo lists                      # display defined lists
    todo create <list>              # create an empty list named <list>
    todo remove <list>              # delete the list named <list>
    echo $LIST                      # display the default list name
    export LIST=<list>              # set the default list to <list>

Manage tasks:

    todo show [<list>]              # display the tasks of the list
    todo add "<task>" [<list>]      # add a new task
    todo del <task_id> [<list>]     # delete a given task
    todo mv <task_id> [<src_list>] <dest_list> # move a task to another list

When a list name is optionnal and none is provided, the default list is used.

When displaying a list, numbers are added to identify each task and be used as
identifiers when deleting or moving tasks.


## Feedback/contact information

Your feedback is greatly appreciated! If you have any comment on todo,
whether it's on the user side or the code, send an email at arthur@jaquin.xyz.
