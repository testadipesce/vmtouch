PREFIX?=	/usr/local
BINDIR?=	$(PREFIX)/bin
MANDIR?=	$(PREFIX)/share/man/man8

BUILDINFO='`ec_git_describe|tr "\n" " "`'

CC?=		cc
CFLAGS+=	-Wall -O2 -g -std=c99

all: vmtouch vmtouch.8

.PHONY: all install clean uninstall

vmtouch: vmtouch.c
	printf "BUILDINFO: %s\n" "$(BUILDINFO)"
	${CC} -v ${CFLAGS} ${LDFLAGS} -D BUILDINFO="\"$(BUILDINFO)\"" -o vmtouch vmtouch.c

vmtouch.8: vmtouch.pod
	pod2man --section 8 --center "System Manager's Manual" --release " " vmtouch.pod > vmtouch.8

install: vmtouch vmtouch.8
	mkdir -p $(DESTDIR)$(BINDIR) $(DESTDIR)$(MANDIR)
	install -m 0755 vmtouch $(DESTDIR)$(BINDIR)/vmtouch
	install -m 0644 vmtouch.8 $(DESTDIR)$(MANDIR)/vmtouch.8

clean:
	rm -f vmtouch vmtouch.8

uninstall:
	rm $(DESTDIR)$(BINDIR)/vmtouch $(DESTDIR)$(MANDIR)/vmtouch.8
