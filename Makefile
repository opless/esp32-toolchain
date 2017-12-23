DOCKERUSERNAME=opless

build:
	docker build -t $(DOCKERUSERNAME)/esp32-toolchain .
