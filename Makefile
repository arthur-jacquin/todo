include config.mk

clean:
	rm -f todo.tar.gz

dist: clean
	tar -cf todo.tar LICENSE Makefile config.mk readme.md todo.sh todo.1
	gzip todo.tar

install: todo.sh
	mkdir -p ${PREFIX}/bin
	cp -f todo.sh ${PREFIX}/bin/todo
	chmod 755 ${PREFIX}/bin/todo
	mkdir -p ${MANPREFIX}/man1
	cp todo.1 ${MANPREFIX}/man1
	chmod 644 ${MANPREFIX}/man1/todo.1

uninstall:
	rm -f ${PREFIX}/bin/todo ${MANPREFIX}/man1/todo.1

.PHONY: clean dist install uninstall
