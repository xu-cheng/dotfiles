# Fetch .gitignore templates from https://github.com/github/gitignore
#
#   gi Global/linux Global/macOS Global/Windows Global/Agents > .gitignore
#   gi -l [pattern]   list the available templates
#
# Everything is read from GitHub through `gh`, nothing is cached locally.
# Template names are matched case-insensitively and the `.gitignore` suffix is
# optional, so `Global/linux`, `Global/Linux` and `Global/Linux.gitignore` all
# refer to the same template. A name without a directory (e.g. `node`) matches
# on the file name alone as long as it is unambiguous.

: ${GI_REPO:=github/gitignore}
: ${GI_REF:=main}

# List every template path in the repository, one per line
function _gi_list()
{
    gh api "repos/$GI_REPO/git/trees/$GI_REF?recursive=1" \
        --jq '.tree[] | select(.type == "blob") | select(.path | endswith(".gitignore")) | .path'
}

# Print the contents of a template
function _gi_get()
{
    gh api "repos/$GI_REPO/contents/$1?ref=$GI_REF" -H 'Accept: application/vnd.github.raw'
}

# Resolve a template name against the given paths
function _gi_resolve()
{
    local want="${${1%.gitignore}:l}.gitignore"
    local -a exact base
    local tpl

    for tpl in "${@:2}"; do
        [[ "${tpl:l}" == "$want" ]] && exact+=( "$tpl" )
        [[ "${tpl:t:l}" == "$want" ]] && base+=( "$tpl" )
    done
    (( $#exact )) && base=( $exact )

    case $#base in
        1) print -r -- "$base[1]" ;;
        0) print -ru2 -- "gi: no template matching '$1'"; return 1 ;;
        *) print -ru2 -- "gi: '$1' is ambiguous: ${(j:, :)base}"; return 1 ;;
    esac
}

function gi()
{
    emulate -L zsh
    setopt local_options pipe_fail

    if (( ! ${+commands[gh]} )); then
        print -ru2 -- 'gi: gh is not available'
        return 1
    fi

    local mode=fetch
    while [[ "$1" == -* ]]; do
        case "$1" in
            -l|--list) mode=list ;;
            -h|--help) mode=help ;;
            --) shift; break ;;
            *) print -ru2 -- "gi: unknown option '$1'"; return 1 ;;
        esac
        shift
    done

    if [[ "$mode" == help ]]; then
        print -r -- 'usage: gi <template>...   print the given templates on stdout'
        print -r -- '       gi -l [pattern]    list the available templates'
        return 0
    fi

    if [[ "$mode" == fetch ]] && (( ! $# )); then
        print -ru2 -- 'gi: no template given, see `gi -h`'
        return 1
    fi

    local -a templates
    templates=( ${(f)"$(_gi_list)"} )
    if (( ! $#templates )); then
        print -ru2 -- "gi: could not list the templates of $GI_REPO"
        return 1
    fi

    if [[ "$mode" == list ]]; then
        local name
        for name in ${templates%.gitignore}; do
            (( $# )) && [[ "${name:l}" != *"${1:l}"* ]] && continue
            print -r -- "$name"
        done
        return 0
    fi

    # resolve every name first so a typo fails before anything is downloaded
    # N.B. `path` is tied to $PATH in zsh, never use it as a local
    local -a wanted
    local name tpl body
    for name in "$@"; do
        tpl="$(_gi_resolve "$name" $templates)" || return 1
        wanted+=( "$tpl" )
    done

    local -a sections
    for tpl in $wanted; do
        if ! body="$(_gi_get "$tpl")" || [[ -z "$body" ]]; then
            print -ru2 -- "gi: could not download $tpl"
            return 1
        fi
        sections+=( "# https://github.com/$GI_REPO/blob/$GI_REF/$tpl"$'\n'"$body" )
    done

    print -r -- "${(pj:\n\n:)sections}"
}
