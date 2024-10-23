set -l custom_functions_path ~/.dotfiles/_config/fish/functions

if test -d $custom_functions_path
    set fish_function_path $custom_functions_path $fish_function_path
end


