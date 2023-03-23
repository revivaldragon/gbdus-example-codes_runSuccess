.PHONY: all
FLAGS=$(shell pkg-config --libs --cflags gio-2.0 gio-unix-2.0 glib-2.0)

all: gen service-alarm client-alarm

gen:
	gdbus-codegen --interface-prefix es.aleksander --generate-c-code alarm es.aleksander.Alarm.xml

%.o: %.c
	gcc -o $@ $^ -c $(FLAGS)

service-alarm: service-alarm.o alarm.o 
	gcc -o $@ $^ $(FLAGS)

client-alarm: client-alarm.o alarm.o 
	gcc -o $@ $^ $(FLAGS)

clean:
	rm -f *.o service-alarm client-alarm alarm.c alarm.h
