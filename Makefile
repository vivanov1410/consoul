test:
	mocha --colors --require should --reporter spec --compilers coffee:coffee-script

watch:
	coffee --watch --lint --output public/javascripts --compile lib/consoul.coffee

start:
	nodemon --watch routes app.coffee

.PHONY: test