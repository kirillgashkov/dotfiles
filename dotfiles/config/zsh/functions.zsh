# GNU utils

# binutils. Not symlinked by default. Provides GNU `strings`, etc.
strings() { /usr/local/opt/binutils/bin/strings "$@"; }

# coreutils. G-prefixed by default. Provides GNU `cp`, `ls`, `rm`, etc.
ls() { /usr/local/opt/coreutils/libexec/gnubin/ls "$@"; }

# gnu-sed. G-prefixed by default. Provides GNU `sed`.
sed() { /usr/local/opt/gnu-sed/libexec/gnubin/sed "$@"; }

# grep. G-prefixed by default. Provides GNU `egrep`, `fgrep`, `grep`.
egrep() { /usr/local/opt/grep/libexec/gnubin/egrep "$@"; }
fgrep() { /usr/local/opt/grep/libexec/gnubin/fgrep "$@"; }
grep() { /usr/local/opt/grep/libexec/gnubin/grep "$@"; }

# gcc. "-13"-suffixed by default. Provides `g++`, `gcc`, etc.
g++() { /usr/local/opt/gcc/bin/g++-13 "$@" }
gcc() { /usr/local/opt/gcc/bin/gcc-13 "$@" }

dsa() {
    local problem_name subproblem_name main_path repo_root current_dir module_path

    problem_name="$(slugify "$1")"
    subproblem_name="$(slugify "$2")"

    if [[ -z "$problem_name" ]]; then
        echo "error: missing problem name" >&2
        return 1
    fi
    
    if [[ -z "$subproblem_name" ]]; then
        main_path="$problem_name"
    else
        main_path="$problem_name/$subproblem_name"
    fi

    repo_root="$(git rev-parse --show-toplevel)"
    current_dir="$(pwd)"
    if [[ "$current_dir" == "$repo_root" ]]; then
        module_path="github.com/k11v/dsa/$problem_name"
    else
        module_path="github.com/k11v/dsa/${current_dir#$repo_root/}/$problem_name"
    fi

    mkdir -p "$problem_name"
    cat <<EOF > "$problem_name/go.mod"
module $module_path

go 1.23.4
EOF
    cat <<EOF > "$problem_name/README.md"
Time to solve:

- read: 0s
- think: 0s
- implement: 0s
- check and fix: 0s
- run and fix: 0s
- success: 0s
- read: 0s
- solve: 0s
- success: 0s
- _total: 0s_
EOF

    mkdir -p "$main_path"
    cat <<EOF > "$main_path/main.go"
package main

func main() {
}
EOF
}

# awesomestars reads HTML from the standart input, extracts links,
# retrieves stargazer count for each link to a GitHub repository,
# and returns the links enriched with stargazer count.
awesomestars() {
    # Parse Pandoc Link objects from STDIN.
    # cat is actually redundant but it shows intent.
    items="$(cat | pandoc --from html --to json | jq -c '.. | if type == "object" and .t == "Link" then . else empty end' | while read l; do
        # Parse link name and URL into n and u.
        n="$(echo "$l" | jq '.c[1]' | jq '{
          "pandoc-api-version": [1, 23, 1],
          "meta": {},
          "blocks": [
            {
              "t": "Plain",
              "c": .
            }
          ]
        }' | pandoc --from json --to plain)"
        u="$(echo "$l" | jq -r '.c[2][0]')"

        # Parse GitHub repository's owner/name from URL into repo, then fetch star count into s.
        repo="$(echo "$u" | python3 -c '
import sys, urllib.parse
scheme, netloc, path, _, _ = urllib.parse.urlsplit(sys.stdin.readline())
if not (scheme == "http" or scheme == "https"): exit()
if not (netloc == "github.com"): exit()
if not (len(path) > 0): exit()
print(path[1:])
        ')"
        if [[ -n "$repo" ]]; then
            s="$(gh repo view "$repo" --json stargazerCount | jq '.stargazerCount')"
        else
            s="0"
        fi

        # Output name, url, star_count.
        jq -c -n --arg name "$n" --arg url "$u" --arg star_count "$s" '{"name": $name, "url": $url, "star_count": ($star_count | tonumber)}'
        printf '.' >&2 # singal that we processed one URL
    done)"
    printf "\n" >&2

    printf "%s" "$items" | jq -s -c 'sort_by(.star_count) | reverse | .[]'
}

# Competitive programming utils

gentest() {
    if [ -z "$1" ] || [ ! -e "$1" ] || [ -z "$2" ] || [ ! -e "$2" ] || [ -z "$3" ] || [ ! -e "$3" ]; then
        if [ -z "$1" ]; then
            echo "Error: Generator program not provided." >&2
        elif [ ! -e "$1" ]; then
            echo "Error: Generator program not found: $1" >&2
        fi
        if [ -z "$2" ]; then
            echo "Error: Correct program not provided." >&2
        elif [ ! -e "$2" ]; then
            echo "Error: Correct program not found: $2" >&2
        fi
        if [ -z "$3" ]; then
            echo "Error: Examined program not provided." >&2
        elif [ ! -e "$3" ]; then
            echo "Error: Examined program not found: $3" >&2
        fi
        echo "Usage: gentest <generator> <correct> <examined>" >&2
        return 1
    fi

    i=0
    while ((++i)); do
        echo "$i"
        "$1" "$i" > int
        command diff <("$2" < int) <("$3" < int) || break
    done
}

bc++11() {
    if [ -z "$1" ]; then
        echo "Error: The input file must be provided." >&2
        return 1
    fi

    if [ "$1" = "$(basename "$1" ".cpp")" ]; then
        echo "Error: The name of the input file must end with '.cpp'." >&2
        return 1
    fi

    g++ -std=c++11 -Og -Wall -Wextra -o "$(basename "$1" ".cpp")" "$1"
}

bc++11-prod() {
    if [ -z "$1" ]; then
        echo "Error: The input file must be provided." >&2
        return 1
    fi

    if [ "$1" = "$(basename "$1" ".cpp")" ]; then
        echo "Error: The name of the input file must end with '.cpp'." >&2
        return 1
    fi

    g++ -std=c++11 -O2 -Wall -Wextra -o "$(basename "$1" ".cpp")" "$1"
}

rpython3.5() {
    if [ -z "$1" ]; then
        echo "Error: The input file must be provided." >&2
        return 1
    fi

    PYENV_VERSION="3.5" pyenv exec python3.5 "$1"
}


# My utils

# Change working directory to the top-most Finder window location
cdf() {
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Compare files using Git's colored diff
diff() {
    git diff --no-index "$@"
}

# Get local IPs
myip() {
    ifconfig | grep inet | grep -v inet6 | cut -d " " -f 2
}

# Get external IP
myexternalip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

# FIXME: If file doesn't end with a newline, the last variable is not exported.
# Load a .env file (formatted according to the Compose spec)
dotenv() {
    local kv
    cat "${1-.env}" | sed '/^#.*$/d' | sed '/^$/d' | sed -n '/^.*=.*$/p' | while read -r kv; do
        export "$kv"
    done
}

# Generate a v4 UUID
uuid4() {
    python3 -c "import uuid; print(uuid.uuid4())"
}

# venv [<path>] activates a Python venv.
venv() {
    local venv="$1"
    if [[ -z "$venv" ]]; then
        venv=".venv"
    fi
    if [[ ! -e "$venv" ]]; then
        echo >&2 "error: venv doesn't exist: $venv"
        return 1
    fi
    venv="$(CDPATH= cd -- "$(dirname -- "$venv")" && pwd)/$(basename -- "$venv")"
    [[ "$?" -ne 0 ]] && return 1

    source "$venv/bin/activate"
}

# mkvenv <version> [<path>] creates a Python venv.
mkvenv() {
    local version="$1"
    if [[ -z "$version" ]]; then
        echo >&2 "error: version is not specified"
        return 1
    fi

    local venv="$2"
    if [[ -z "$venv" ]]; then
        venv=".venv"
    fi
    if [[ -e "$venv" ]]; then
        echo >&2 "error: venv already exists"
        return 1
    fi
    venv="$(CDPATH= cd -- "$(dirname -- "$venv")" && pwd)/$(basename -- "$venv")"
    [[ "$?" -ne 0 ]] && return 1

    mise x "python@$version" -- python -m venv "$venv"
    [[ "$?" -ne 0 ]] && return 1

    source "$venv/bin/activate"
}

# rmvenv [<path>] deactivates and removes a Python venv.
rmvenv() {
    local venv="$1"
    if [[ -z "$venv" ]]; then
        venv=".venv"
    fi
    if [[ ! -e "$venv" ]]; then
        echo >&2 "error: venv doesn't exist: $venv"
        return 1
    fi
    venv="$(CDPATH= cd -- "$(dirname -- "$venv")" && pwd)/$(basename -- "$venv")"
    [[ "$?" -ne 0 ]] && return 1

    if [[ "$VIRTUAL_ENV" -ef "$venv" ]]; then
        deactivate
        [[ "$?" -ne 0 ]] && return 1
    fi

    rm -rf "$venv"
}

# Quickly jump into a repository
repo() {
    cd "$REPOSITORIES/$1"
}

# Quickly jump into a workspace
space() {
    cd "$WORKSPACES/$1"
}

# Quickly jump into a note
note() {
    cd "$NOTES/$1"
}

git-log-with-dates() {
    # See:
    # - https://devhints.io/git-log-format
    # - https://www.git-scm.com/docs/git-config#Documentation/git-config.txt-color
    # - https://www.git-scm.com/docs/git-log#_pretty_formats
    git log --pretty='format:%aD %C(bold)%C(yellow)%h%Creset %s'
}

# NOTE: This function creates dangling commits.
git-branch-squash-merged() {
    local branches="$(git branch --format="%(refname:short)")"
    local current_branch="$(git branch --show-current --format="%(refname:short)")"
    local default_branch="main"

    if [[ "$current_branch" != "$default_branch" ]]; then
        echo 1>&2 "Error: You must be on the default branch ('$default_branch') to run this command."
        return 1
    fi

    echo "$branches" | while read -r branch; do
        if [[ "$branch" == "$default_branch" ]]; then
            continue
        fi

        local ancestor_commit="$(git merge-base "$branch" "$default_branch")"
        local branch_tree="$(git rev-parse "$branch^{tree}")"
        local recreated_squash_commit="$(git commit-tree "$branch_tree" -p "$ancestor_commit" -m "Recreated squash commit for '$branch'")"

        if [[ -z "$recreated_squash_commit" ]]; then
            echo >&2 "Error: Failed to recreate squash commit for '$branch'. Skipping."
            continue
        fi

        if [[ $(git cherry "$default_branch" "$recreated_squash_commit") != "-"* ]]; then
            continue
        fi

        echo "$branch"
    done
}

# Compile completion cache from scratch
recompinit() {
    rm "$ZCOMPDUMP"
    compinit -d "$ZCOMPDUMP"
}

# Pipe to browser
bcat() {
    local tempdir="$(mktemp -d)"
    cat > "$tempdir/document.html"
    open "$tempdir/document.html"
    sleep 0.2
    rm -rf -- "$tempdir"
}

# Display the current date in UTC and ISO 8601 format
now() {
    date -u "+%Y-%m-%dT%H:%M:%SZ"
}

# Get website's title
titleof() {
    curl -sSL -o - -- "$1" | perl -l -0777 -n -e 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si'
}

# Activate shared Python venv
shvenv() {
    source "${XDG_DATA_HOME:-$HOME/.local/share}/venv/venvs/shared/bin/activate"
}

# https://stackoverflow.com/questions/4438306/how-to-remove-trailing-whitespaces-with-sed
anyfmt() {
    /usr/local/opt/gnu-sed/libexec/gnubin/sed -i 's/[ \t]*$//' "$1"
}

printcolors() {
    printf "%s %s%s%s %s%s%s %s%s%s\n" \
        " " ""                "NORMAL " ""             "$(tput bold)"                "BOLD NORMAL " "$(tput sgr0)" ""                "BACKGROUND NORMAL " ""             \
        "0" "$(tput setaf 0)" "BLACK  " "$(tput sgr0)" "$(tput bold)$(tput setaf 0)" "BOLD BLACK  " "$(tput sgr0)" "$(tput setab 0)" "BACKGROUND BLACK  " "$(tput sgr0)" \
        "1" "$(tput setaf 1)" "RED    " "$(tput sgr0)" "$(tput bold)$(tput setaf 1)" "BOLD RED    " "$(tput sgr0)" "$(tput setab 1)" "BACKGROUND RED    " "$(tput sgr0)" \
        "2" "$(tput setaf 2)" "GREEN  " "$(tput sgr0)" "$(tput bold)$(tput setaf 2)" "BOLD GREEN  " "$(tput sgr0)" "$(tput setab 2)" "BACKGROUND GREEN  " "$(tput sgr0)" \
        "3" "$(tput setaf 3)" "YELLOW " "$(tput sgr0)" "$(tput bold)$(tput setaf 3)" "BOLD YELLOW " "$(tput sgr0)" "$(tput setab 3)" "BACKGROUND YELLOW " "$(tput sgr0)" \
        "4" "$(tput setaf 4)" "BLUE   " "$(tput sgr0)" "$(tput bold)$(tput setaf 4)" "BOLD BLUE   " "$(tput sgr0)" "$(tput setab 4)" "BACKGROUND BLUE   " "$(tput sgr0)" \
        "5" "$(tput setaf 5)" "MAGENTA" "$(tput sgr0)" "$(tput bold)$(tput setaf 5)" "BOLD MAGENTA" "$(tput sgr0)" "$(tput setab 5)" "BACKGROUND MAGENTA" "$(tput sgr0)" \
        "6" "$(tput setaf 6)" "CYAN   " "$(tput sgr0)" "$(tput bold)$(tput setaf 6)" "BOLD CYAN   " "$(tput sgr0)" "$(tput setab 6)" "BACKGROUND CYAN   " "$(tput sgr0)" \
        "7" "$(tput setaf 7)" "WHITE  " "$(tput sgr0)" "$(tput bold)$(tput setaf 7)" "BOLD WHITE  " "$(tput sgr0)" "$(tput setab 7)" "BACKGROUND WHITE  " "$(tput sgr0)"
}

lspypi() {
    curl -fsSL -H "Accept: application/vnd.pypi.simple.v1+json" "https://pypi.org/simple/$1/" | jq --raw-output ".versions[]" | sort --version-sort
}

dataurl() {
    if [ -z "$1" ]; then
        echo "Usage: dataurl <file>" >&2
        exit 2
    fi
    mimetype="$(file -bN --mime-type "$1")"
    content="$(base64 < "$1")"
    echo "data:$mimetype;base64,$content"
}
