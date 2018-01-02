clean:
	stack exec site clean

rebuild:
	stack exec site rebuild

build:
	stack exec site build

watch: clean rebuild
	stack exec site watch

deploy:
	make clean
	make rebuild
	git fetch origin
	git checkout -b gh-pages origin/gh-pages
	cp -r _site/* .
	rm -rf _site
	rm -rf _cache
	git add .
	git commit -m "Redeploy blog"
	git push origin gh-pages
	git checkout master
	git branch -D gh-pages

.PHONY: clean, rebuild, build, watch, publish
