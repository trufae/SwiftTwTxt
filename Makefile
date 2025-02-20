all:
	swift build
	swift run TwtxtClient

allclean:
	swift build --clean

clean:
	rm -rf .build

dist: clean
	rm -rf SwiftTwTxt
	git clone . SwiftTwTxt
	rm -rf SwiftTwTxt/.git
	rm -f SwiftTwTxt.zip
	zip -r SwiftTwTxt.zip SwiftTwTxt
