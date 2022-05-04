# packages and config files specific to develoment in a VS Code container.

## Configure R

# install packages required for VSCode-R (use renv to copy to cache)
R --quiet --no-init-file -e "renv::install(c('jsonlite', 'rlang'))"
R --quiet --no-init-file -e "renv::install(c('languageserver', 'httpgd', 'rmarkdown'))"

# add VSCode-R config options to .RProfile
echo -e '

source(file.path(Sys.getenv("HOME"), ".vscode-R", "init.R"))
options(vsc.use_httpgd = TRUE)

' >> ~/.Rprofile

# add radian console
sudo /usr/bin/pip3 install radian

## Add development tools to Conda base environment
conda env update --name base -f $DOCKERFILE_PATH/.devcontainer/config/base_dev.yml


## Other useful settings

# add mouse scrolling in tmux 
echo '
set -g mouse on
' > ~/.tmux.conf

# add mouse scrolling in screen
echo '
# change escape key
escape ^Bb
# enable scrolling
termcapinfo xterm* ti@:te@
' > ~/.screenrc
