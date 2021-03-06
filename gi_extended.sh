#/bin/sh

gitignore_io_url="https://www.gitignore.io/api/"

default_path="$HOME/.gi_list"
gi_list=`cat $default_path | tr "," "\n"`

update_gi_list() {
    curl -L -s  "${gitignore_io_url}/list" > ~/.gi_list
}

print_in_alphabetical_order() {
    for i in {a..z};
    do
        echo "$gi_list" | grep "^$i" | tr "\n" " "
        echo
    done
}

print_in_table_format() {
    table_width=5
    coulumn_width=25

    counter=0
    for item in $gi_list; do
        printf "%-${coulumn_width}s" $item
        counter=$(($counter+1))
        if [[ $(($counter%$table_width)) -eq 0 ]]; then
            echo
        fi
    done
    echo
}

print_last_modified_time() {
    local gi_list_date=`stat -f "%t%Sm" $default_path`
    echo "Last update time: $gi_list_date"
}

gi() {
    curl -L -s $gitignore_io_url/$1
}

gi_export() {
    gi $1 > .gitignore
}

gi_append() {
    gi $1 >> .gitignore
}

show_usage() {
    echo "usage: gi <types>"
    echo "          [-a| -e] <types>"
    echo "          [-u| -t| -l| -L]"
    echo "          [-h]"
}

print_help_message() {
    echo "-a [types]      apeend new .gitignore content to .gitignore under the current directory"
    echo "-e [types]      export new .gitignore to the current directory (The old one will be replaced.)"
    echo "-L              print ~/.gi_list in alphabetical order"
    echo "-l              print ~/.gi_list in table format"
    echo "-u              update ~/.gi_list"
    echo "-t              show the last modified time of ~/.gi_list"
    echo "-h              show help"
}


update_gi_list &
if [[ $# -eq 0 ]]; then
    show_usage
else
    case $1 in
        -a|-e)
            opt=$1
            shift
            if [[ $# -eq 0 ]]; then
                show_usage
                exit
            fi

            gi_to_curl=`echo $@ | tr " " ","`
            case $opt in
            -a)
                gi_append $gi_to_curl
                ;;
            -e)
                gi_export $gi_to_curl
                ;;
            esac

            exit
            ;;
        -t)
            print_last_modified_time
            ;;
        -u)
            update_gi_list
            ;;
        -L)
            print_in_alphabetical_order
            ;;
        -l)
            print_in_table_format
            ;;
        -h)
            print_help_message
            ;;
        -*)
            echo No Such option
            show_usage
            ;;
        *)
            gi_to_curl=`echo $@ | tr " " ","`
            gi $gi_to_curl
            ;;
    esac
fi
