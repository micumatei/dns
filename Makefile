BASEDIR=dns/
CC=g++
CFLAGS= -g -Werror=all -std=c++0x
LIBS= -l sqlite3
UTILS=$(BASEDIR)parser.cpp $(BASEDIR)exceptions.cpp $(BASEDIR)dns.cpp $(BASEDIR)server.cpp $(BASEDIR)reader.cpp $(BASEDIR)db.cpp $(BASEDIR)worker.cpp
MAIN=$(BASEDIR)main.cpp
EXECUTABLE=$(BASEDIR)dns

TESTS=$(BASEDIR)unittests/*.cpp
FRAMEWORK=$(BASEDIR)unittests/*.hpp
UNITTESTS_EXECUTABLE=$(BASEDIR)tests

all: 
	$(CC) $(CFLAGS) $(UTILS) $(MAIN) $(LIBS) -o $(EXECUTABLE)

tests:
	$(CC) $(CFLAGS) $(UTILS) $(FRAMEWORK) $(TESTS) $(LIBS) -o $(UNITTESTS_EXECUTABLE)

install-deps:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install -y libc6:i386 libstdc++6:i386 g++
	sudo apt-get install -y sqlite3 libsqlite3-dev 

doxygen :
	@echo " DOXY Docs"
	@doxygen config/Doxyfile
