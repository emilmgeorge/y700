.PHONY: subwoofer_install subwoofer_uninstall

subwoofer_install:
	@sudo $(MAKE) -C subwoofer/ install

subwoofer_uninstall:
	@sudo $(MAKE) -C subwoofer/ uninstall