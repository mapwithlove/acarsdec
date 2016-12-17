# See README 
CFLAGS= -g  -pthread -D WITH_RTL -D WITH_ALSA -D WITH_SNDFILE
#CFLAGS= -Ofast -pthread -D WITH_RTL -I.  `pkg-config --cflags libairspy`
LDLIBS= -lm -pthread  -lrtlsdr -lasound -lsndfile
#LDLIBS= -lm -pthread  `pkg-config --libs libairspy` -lusb-1.0


acarsdec:	acarsdec.o acars.o msk.o rtl.o air.o output.o alsa.o soundfile.o
	$(CC) acarsdec.o acars.o msk.o rtl.o air.o output.o alsa.o soundfile.o -o $@ $(LDLIBS)

acarsserv:	acarsserv.o dbmgn.o
	$(CC) -Ofast acarsserv.o dbmgn.o -o $@ -lsqlite3

acarsdec.o:	acarsdec.c acarsdec.h
acars.o:	acars.c acarsdec.h syndrom.h
msk.o:	msk.c acarsdec.h
output.o:	output.c acarsdec.h
rtl.o:	rtl.c acarsdec.h
acarsserv.o:	acarsserv.h
dbmgm.o:	acarsserv.h

clean:
	@\rm -f *.o acarsdec acarsserv
