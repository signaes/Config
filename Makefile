init:
	chmod u+x init.sh
	sh init.sh

install:
	chmod u+x install.sh
	sh install.sh

config:
	chmod u+x config.sh
	sh config.sh

setup: init install config
