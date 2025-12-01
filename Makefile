.PHONY: build serve

build:
	hugo

serve:
	hugo server --disableFastRender
