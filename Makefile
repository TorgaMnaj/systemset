#! /usr/bin/make -f

help:  		## This help dialog.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

dev_install:  	## Install development dependencies and tools
	sudo apt update
	cat dev_requirements.apt | xargs sudo apt install -y
	
tests_bash:  	## Run bash scripts tests
	bash ./.devbin/shtests.sh

commit:  	## Test and commit changes to git and push on github
	bash ./.devbin/bigcommit.sh
