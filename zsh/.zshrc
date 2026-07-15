export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin
# Add quarto to the path
if [[ -d /Users/yusuf/Applications/quarto/bin ]]; then
  export PATH="/Users/yusuf/Applications/quarto/bin:$PATH"
fi
export JAVA_HOME=$(/usr/libexec/java_home -v 25)
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/yusuf/.local/bin:$PATH"
