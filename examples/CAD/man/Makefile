#
#
#

CPP_FLAGS=-P -C -DANONYM

#TXT2X_FLAGS=--nocpp --kk --english # --draft
TXT2X_FLAGS=--nocpp --kk # --draft

#HTML_DATEIEN=$(shell ls -1 *.txt | sed 's/txt$$/html/')

#GIF_DATEIEN=$(shell ls -1 *.gif)

.SUFFIXES: .txt .html .gif

.txt.html:
	cat $< \
          | cpp $(CPP_FLAGS) \
          | txt2x --html $(TXT2X_FLAGS) \
         > $*.html


all: $(HTML_DATEIEN)

ps:
#	for F in *.html ; do w3m -dump $$F | a2ps -o - > /tmp/$$F.ps ; done
# hier muß netscape laufen, das 'cd ...' ist nicht ganz sauber
	(cd /var/www/pkg && ( for F in *.html ; do a2ps -2 $$F -o /tmp/$$F.ps ; done ) )

install: all
	test -d $(WWW_INST_DIR) || install -d -g $(WWW_GROUP) -m 0775 $(WWW_INST_DIR)

	for F in [A-Z]*.html $(HTML_DATEIEN) index.html entwicklung.html ; do \
          echo $$F ; perl ./subst.pl $$F > $(WWW_INST_DIR)/$$F ; \
        done

	install -m 0644 *.gif *.jpg pkg.css $(WWW_INST_DIR)
#	install -m 0644 $(HTML_DATEIEN) $(WWW_INST_DIR)

deinstall: all
	@echo -e -n "\nWirklich deinstallieren? " ; read
	for F in *.html *.gif *.jpg pkg.css ; do \
          rm -f $(WWW_INST_DIR)/$$F ; \
        done


clean:
	rm -f *~

veryclean: clean
	rm -f $(HTML_DATEIEN)

