all:
	swift build
	swift run YarnTwix

allclean:
	swift build --clean

clean:
	rm -rf .build

dist: clean
	rm -rf YarnTwix
	git clone . YarnTwix
	rm -rf YarnTwix/.git
	rm -f YarnTwix.zip
	zip -r YarnTwix.zip YarnTwix
	rm -rf YarnTwix
