# Virtual Home

Personal configurations files and tweaks.


## Applications

### Sublime Text 2
 * `sublime-text-2` directory with user configuration including packages, syntax-specific configuration, etc.

_Target directory:_
 * OS X: `~/Library/Application Support/Sublime Text 2/Packages/User`
 * Linux: `~/.config/sublime-text-2/Packages/User`
 * Windows: `%APPDATA%\Sublime Text 2\Packages\User`

### Vim
 * `_vim/` directory with plugins and filetype-based syntax configuration
 * `_vimrc` Vim configuration
 * `_gvimrc` Vim GUI configuration

_Target directory:_ `~/`

### Git
 * `_gitconfig` git global configuration, name, email

_Target directory:_ `~/`

### GNU Screen
 * `_screenrc` screen configuration

_Target directory:_ `~/`


## Deployment

### OS X / Unix
Run `deploy.sh` to copy all configuration files to the target directories. 

### Windows
_TODO_
