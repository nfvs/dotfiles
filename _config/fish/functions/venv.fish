function venv
    if test -n "$VIRTUAL_ENV"
        deactivate
    else if test (count .venv*) -gt 0
        . .venv*/bin/activate.fish
    else
        echo No python virtual environment found.
    end
end
