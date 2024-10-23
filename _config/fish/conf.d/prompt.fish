# Pure prompt
function pure_prompt
    # Store last status
    set -l last_status $status

    # Show username@hostname only in SSH or container
    if set -q SSH_TTY; or test -e /.dockerenv
        set_color brblack
        echo -n "$USER@"(hostname)" "
    end

    # Path
    set_color blue
    echo -n (prompt_pwd)

    # Git status with arrows
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set_color brblack

        # Get branch name
        set -l git_branch (git rev-parse --abbrev-ref HEAD)

        # Check for changes
        set -l is_dirty (git status -s --ignore-submodules=dirty)

        # Get upstream status
        set -l git_ahead (git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)

        # Show branch name
        echo -n " $git_branch"

        # Show dirty state
        if test -n "$is_dirty"
            set_color yellow
            echo -n "*"
        end

        # Show arrows based on upstream status
        if test -n "$git_ahead"
            switch "$git_ahead"
                case "0*0"
                    echo -n ""
                case "*	0"
                    set_color red
                    echo -n " ⇣" # Need to pull
                case "0	*"
                    set_color cyan
                    echo -n " ⇡" # Need to push
                case "*	*"
                    set_color magenta
                    echo -n " ⇡⇣" # Diverged
            end
        end
    end

    # Prompt symbol
    echo
    if test $last_status -eq 0
        set_color magenta
    else
        set_color red
    end
    echo -n "❯ "
    set_color normal
end

function fish_prompt
	pure_prompt
end
