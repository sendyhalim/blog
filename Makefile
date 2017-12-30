clean:
	stack exec site clean

rebuild:
	stack exec site rebuild

build:
	stack exec site build

watch: clean rebuild
	stack exec site watch

publish:
	rm -rf _site/
	git clone git@github.com:sendyhalim/blog --branch gh-pages _site/
	make rebuild
	cd _site/
	git add .
	git commit -m "Redeploy blog"
	git push origin gh-pages -f
	cd ..

.PHONY: clean, rebuild, build, watch, publish
