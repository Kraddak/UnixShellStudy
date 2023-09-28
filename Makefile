

CC				=  gcc
AR              =  ar
CFLAGS	        += -std=c99 -Wall -pedantic -g -DMAKE_VALGRIND_HAPPY
ARFLAGS         =  rvs
INCLUDES		= -I./books
LDFLAGS 		= -L.
OPTFLAGS		=	 
LIBS    		= -pthread -lstore

LIBRARY = libstore.a
OBJECTS = os_interface.o ob_store.o client.o message.o	
TARGETS = $(LIBRARY) ob_store client
INCLUDE_FILES = 			\
	books/os_interface.h 	\
	books/message.h 		\
	books/ruler.h



.PHONY: all clean test logc logo server test1

%: %.c
	$(CC) $(CFLAGS) $(INCLUDES) $(OPTFLAGS) -o $@ $< $(LDFLAGS) 

%.o: books/%.c
	$(CC) $(CFLAGS) $(INCLUDES) $(OPTFLAGS) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) $(OPTFLAGS) -c -o $@ $<

%.a: $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $^

all: $(TARGETS)
	echo objects built
	rm ob_store.o client.o

#ob_store.o
ob_store: ob_store.o $(LIBRARY) $(INCLUDE_FILES)
	$(CC) $(CFLAGS) $(INCLUDES) $(OPTFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) 

client: client.o $(LIBRARY) $(INCLUDE_FILES)
	$(CC) $(CFLAGS) $(INCLUDES) $(OPTFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) 

server:
	clear
	valgrind ./ob_store

test1:
	clear
	printf "" > testout.log
	./client ClienteA 1 >> testout.log &
	./client ClienteA 3 >> testout.log &
	./testsum.sh

test2:
	clear
	printf "" > testout.log
	./test.sh 2 1 1

test:
	clear
	printf "" > testout.log
	./test.sh 50 30 20


#valgrind ./ob_store 2> obstorelog

logc:
	cat clientlog

logo:	
	cat obstorelog

clean:
	rm data -r -d
	rm $(TARGETS) testout.log objstore

