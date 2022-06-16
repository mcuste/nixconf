{ ... }:
{
  # home manager configs
  home-manager.users.mcst = {
    programs.bash = {
      enable = true;
      historySize = 500000;
      historyFileSize = 100000;
      historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
      historyIgnore = [ "exit" "ls" "bg" "fg" "history" "clear" ];
      shellOptions = [
        # Append to history file rather than replacing it.
        "histappend"

        # Save multi-line commands as one command 
	"cmdhist"

        # check the window size after each command and, if
        # necessary, update the values of LINES and COLUMNS.
        "checkwinsize"

        # Extended globbing.
        "extglob"
        
	# Turn on recursive globbing (enables ** to recurse all directories)
        "globstar"

	# Case-insensitive globbing (used in pathname expansion)
	"nocaseglob"

        # Warn if closing shell with running jobs.
        "checkjobs"

        # Prepend cd to directory names automatically
        "autocd"

	# Correct spelling errors during tab-completion
	"dirspell"

	# Correct spelling errors in arguments supplied to cd
	"cdspell"

	# This allows you to bookmark your favorite places across the file system
	# Define a variable containing a path and you will be able to cd into it 
	# regardless of the directory you're in
	"cdable_vars"
	
	# Examples:
	# export dotfiles="$HOME/dotfiles"
	# export projects="$HOME/projects"
	# export documents="$HOME/Documents"
	# export dropbox="$HOME/Dropbox"` 
      ];
      initExtra = ''
        # Prevent file overwrite on stdout redirection
        # Use `>|` to force redirection to an existing file
        set -o noclobber
        
        # Enable history expansion with space
        # E.g. typing !!<space> will replace the !! with your last command
        bind Space:magic-space
        
        ## SMARTER TAB-COMPLETION (Readline bindings) ##
        
        # Perform file completion in a case insensitive fashion
        bind "set completion-ignore-case on"
        
        # Treat hyphens and underscores as equivalent
        bind "set completion-map-case on"
        
        # Display matches for ambiguous patterns at first tab press
        bind "set show-all-if-ambiguous on"
        
        # Immediately add a trailing slash when autocompleting symlinks to directories
        bind "set mark-symlinked-directories on"
        
        # Enable incremental history search with up/down arrows (also Readline goodness)
        # Learn more about this here: 
        # http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
        bind '"\e[C": forward-char'
        bind '"\e[D": backward-char'
      '';
      sessionVariables = {
      	# Automatically trim long paths in the prompt (requires Bash 4.x)
        PROMPT_DIRTRIM = 2; 

	# Record each line as it gets issued
	PROMPT_COMMAND = "history -a";

	# Use standard ISO 8601 timestamp
	# %F equivalent to %Y-%m-%d
	# %T equivalent to %H:%M:%S (24-hours format)
	HISTTIMEFORMAT = "%F %T ";

	# This defines where cd looks for targets
	# Add the directories you want to have fast access to, separated by colon
	# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, 
	# in home and in the ~/projects folder
	CDPATH = ".:~/Projects";
      };
    };
  };
}
