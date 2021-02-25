INSTALL_ROOT ?= /usr/local

install-cli:
	@cp bin/trash $(INSTALL_ROOT)/bin/trash
	@cat bin/trash-daemon | INSTALL_ROOT=$(INSTALL_ROOT) envsubst > $(INSTALL_ROOT)/bin/trash-daemon
	@chmod +x $(INSTALL_ROOT)/bin/trash $(INSTALL_ROOT)/bin/trash-daemon

uninstall-cli:
	@rm $(INSTALL_ROOT)/bin/trash $(INSTALL_ROOT)/bin/trash-daemon

install-systemd:
	@cp systemd/trash.timer /usr/lib/systemd/trash.timer
	@cat systemd/trash.service | INSTALL_ROOT=$(INSTALL_ROOT) envsubst > /usr/lib/systemd/trash.service

uninstall-systemd:
	@rm /usr/lib/systemd/trash.timer /usr/lib/systemd/trash.service

install: install-cli install-systemd
uninstall: uninstall-cli uninstall-systemd
