clean:
	stack exec site clean

build:
	stack exec site build

watch: clean build
	stack exec site watch

.PHONY: watch
