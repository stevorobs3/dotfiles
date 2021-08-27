A simple dotfiles projects for common aliases.

add this to bash_profile:

source /Users/<user-name>/dev/dotfiles/dotfiles.sh

Other useful commands:

	run clojure repl remotely
		java -cp service.jar clojure.main
	find open port:
		lsof -nP -i4TCP:$PORT | grep LISTEN
	lein nvd and ancient
		lein ancient upgrade
		lein ancient upgrade :plugins
		lein nvd check
			todo: set ok level