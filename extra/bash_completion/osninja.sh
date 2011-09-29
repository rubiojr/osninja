_osninja()
{
local opts cur
COMPREPLY=()
cur="${COMP_WORDS[COMP_CWORD]}"
if [ -z "$OSNINJA_COMMADS" ]; then
  export OSNINJA_COMMADS=`osninja list-commands |tail -n +2|awk '{print $1}'`
fi
COMPREPLY=( $(compgen -W "${OSNINJA_COMMADS}" -- ${cur}) )
return 0
}
complete -F _osninja osninja
