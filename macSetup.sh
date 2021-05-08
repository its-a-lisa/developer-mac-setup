
#!/bin/bash

start=`date +%s`
bold=$(tput bold)
normal=$(tput sgr0)
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# if test ! $(which gcc); then
#   echo "Installing command line developer tools..."
#   xcode-select --install
# fi

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install caskroom/cask/brew-cask
    brew tap homebrew/cask-versions
    brew tap homebrew/cask-cask
    brew tap 'homebrew/bundle'
    brew tap 'homebrew/cask'
    brew tap 'homebrew/cask-drivers'
    brew tap 'homebrew/cask-fonts'
    brew tap 'homebrew/core'
    brew tap 'homebrew/services'
    brew tap aws/tap

fi

echo "Updating homebrew..."
brew update
brew upgrade


beginDeploy() {
    echo
    echo "${bold}$1${normal}"
}

############# General Tools #############
beginDeploy "############# General Tools #############"
echo -n "Do you wish to install General Tools (${bold}${green}y${reset}/${bold}${red}n${reset})? "
read General

CaskGeneralToolList=(
    google-chrome
    lastpass
   
)
if [ "$General" != "${General#[Yy]}" ] ;then
    echo Yes
    brew install --cask --appdir="/Applications" ${CaskGeneralToolList[@]}
else
    echo No
fi


############# Developer Utilities #############
beginDeploy "############# Developer Utilities #############"
echo -n "Do you wish to install Developer Utilities (${bold}${green}y${reset}/${bold}${red}n${reset})? "
read DeveloperUtilities

DeveloperUtilitiesList=(
   ruby
   jq
    yarn
    wget
    nvm
    bash-completion
    curl
)
CaskDeveloperUtilitiesList=(
    postman
    github
    docker
)
if [ "$DeveloperUtilities" != "${DeveloperUtilities#[Yy]}" ] ;then
    
    echo Yes
    brew install ${DeveloperUtilitiesList[@]}
    brew install --cask ${CaskDeveloperUtilitiesList[@]}


    mkdir ~/.nvm
    echo '
    # NVM CONFIG
    export NVM_DIR="$HOME/.nvm"
        [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
        [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion' >> ~/.bash_profile


    echo '
    # BASH-COMPLETION CONFIG
    [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"' >> ~/.bash_profile


fi


############# IDEs #############
beginDeploy "############# IDEs #############"
echo -n "Do you wish to install IDEs (${bold}${green}y${reset}/${bold}${red}n${reset})? "
read IDEs

CaskIDEsList=(
    visual-studio-code
)
if [ "$IDEs" != "${IDEs#[Yy]}" ] ;then
    echo Yes
    brew install --cask --appdir="/Applications" ${CaskIDEsList[@]}
    cat vscode-extensions.txt | xargs -L1 code --install-extension
else
    echo No
fi



############# Productivity Tools #############
beginDeploy "############# Productivity Tools #############"
echo -n "Do you wish to install Productivity Tools (${bold}${green}y${reset}/${bold}${red}n${reset})? "
read Productivity

CaskProductivityToolList=(
    slack
    gpg-suite
    zoomus
    signal
    discord
    virtualbox
    spotify
)
if [ "$Productivity" != "${Productivity#[Yy]}" ] ;then
    echo Yes
    brew install --cask --appdir="/Applications" ${CaskProductivityToolList[@]}
else
    echo No
fi


############# Mac Application #############

beginDeploy "############# CLEANING HOMEBREW #############"
brew cleanup


runtime=$((($(date +%s)-$start)/60))
beginDeploy "############# Total Setup Time ############# $runtime Minutes"
