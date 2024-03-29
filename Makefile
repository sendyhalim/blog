build:
	zola build

deploy:
	make build
	git fetch origin
	git checkout -b gh-pages origin/gh-pages
	cp -r public/* .
	rm -rf public/
	rm -rf extra-functionalities/
	git add .
	git commit -m "Redeploy blog"
	git push origin gh-pages
	git checkout master
	git branch -D gh-pages

server:
	zola serve --drafts

.PHONY: build deploy
