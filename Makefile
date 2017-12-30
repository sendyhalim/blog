clean:
	stack exec site clean

rebuild:
	stack exec site rebuild

build:
	stack exec site build

watch: clean build
	stack exec site watch

.PHONY: clean, rebuild, build, watch
