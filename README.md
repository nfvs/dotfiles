# Virtual Home

Personal configurations files and tweaks.


## Applications

### Sublime Text 2
 * `sublime-text-2/User` directory with User configuration including packages, syntax-specific configuration, etc.
 * `sublime-text-2/Default` directory with Default and platform-specific configuration; copy only individual files, not entire directory.

_Target directory:_
 * OS X: `~/Library/Application Support/Sublime Text 2/Packages/`
 * Linux: `~/.config/sublime-text-2/Packages/`
 * Windows: `%APPDATA%\Sublime Text 2\Packages\`

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
