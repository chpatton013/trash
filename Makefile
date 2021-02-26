INSTALL_ROOT ?= /usr/local

# CLI tools

install-cli:
	@cp bin/trash $(INSTALL_ROOT)/bin/trash
	@cat bin/trash-task | INSTALL_ROOT=$(INSTALL_ROOT) envsubst > $(INSTALL_ROOT)/bin/trash-task
	@chmod +x $(INSTALL_ROOT)/bin/trash $(INSTALL_ROOT)/bin/trash-task

uninstall-cli:
	@rm $(INSTALL_ROOT)/bin/trash $(INSTALL_ROOT)/bin/trash-task

# SystemD

install-systemd: install-cli
	@cp systemd/trash.timer /usr/lib/systemd/trash.timer
	@cat systemd/trash.service | INSTALL_ROOT=$(INSTALL_ROOT) envsubst > /usr/lib/systemd/trash.service
	@systemctl enable trash.timer
	@systemctl start trash.timer

uninstall-systemd: uninstall-cli
	@systemctl disable trash.timer
	@systemctl stop trash.timer
	@rm /usr/lib/systemd/trash.timer /usr/lib/systemd/trash.service

# Cron

install-cron: install-cli
	@(crontab -l 2>/dev/null | grep -v $(INSTALL_ROOT)/bin/trash-task; echo '*/15 * * * * $(INSTALL_ROOT)/bin/trash-task') | crontab -

uninstall-cron: uninstall-cli
	@(crontab -l 2>/dev/null | grep -v $(INSTALL_ROOT)/bin/trash-task) | crontab -
