all:
	swift build
	swift run TwtxtClient

clean:
	swift build --clean
