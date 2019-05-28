function ranger-cd
	command ranger --choosedir=$HOME/.rangerdir; set RANGERDIR (cat $HOME/.rangerdir); cd $RANGERDIR $argv;
end
