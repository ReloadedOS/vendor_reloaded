function __print_reloaded_functions_help() {
cat <<EOF
Additional functions:
- mka:             Builds using all available CPUs
- brunch:          Lunch + mka in one command
EOF
}

# Make using all available CPUs
function mka() {
    m "$@"
}

function brunch()
{
    lunch $1-userdebug
    if [ $? -eq 0 ]; then
        time m reloaded
    else
        echo "Lunch failed!"
        return 1
    fi
    return $?
}
