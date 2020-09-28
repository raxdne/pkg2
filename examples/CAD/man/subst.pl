#
#
#
use lib "/var/pkg/lib";
use pkg_kern;

$emacs_call = "emacs -batch --no-site-file -L ../programm/ -l pkg-fta.el -l pkg-sonst.el ";

foreach $argument (@ARGV) {

    open( DATEI, $argument )
	or die "Konnte " . $argument . " nicht oeffnen ...";

    ($begriff, $endung) = split( /\./, $argument );

    while (<DATEI>) {

	if ( /\<head\>/ ) {
	    print "$_<link rel=\"stylesheet\" type=\"text/css\" href=\"pkg.css\">\n";
	}
	elsif ( /modell_io/ ) {
#	    $eval_code = "(princ (format-html-modell-prozesse \'" . $begriff . "))";
	    $eval_code = "(princ (concat "
		. "(format-html-modell-vor-und-nachteile \'$begriff)"
		. "(format-html-modell-prozesse \'$begriff)"
		. "(format-html-element-regeln \'$begriff)))";

	    #printf STDERR $eval_code;

	    open( EA, $emacs_call . " --eval \"" . $eval_code . "\" |");
	    while ( <EA> ) {
		print;
	    }
	    close(EA);
	}
	elsif ( m/<\!doctype[^>]*>/i ) { # aufpassen wenn keine eigene Zeile!
	    print '<!doctype html public "-//W3C//DTD HTML 3.2//EN">';
	}
	elsif ( /modell_kurz/ ) { # Kurzerkärung zum Modell einfügen

	    $eval_code =
		"(princ (concat \\\"\<i\>\\\" "
		. "(modell-erklaerung \'" . $begriff . ")"
		. "\\\"; z.B. \\\""
		. "(modell-form \'" . $begriff . ")"
		. "\\\"\</i\>\\\"))"
		    ;

	    #printf STDERR $eval_code;

	    open( EA, $emacs_call . " --eval \"" . $eval_code . "\" |");
	    while ( <EA> ) {
		print;
	    }
	    close(EA);
	}
	elsif ( /prozess_io/ ) {

#	    $eval_code = "(princ (format-html-prozess-modelle \'" . $begriff . "))";
	    $eval_code = "(princ (concat "
		. "(format-html-prozess-vor-und-nachteile \'$begriff)"
		. "(format-html-prozess-modelle \'$begriff)"
		. "(format-html-element-regeln \'$begriff)"
		. "(format-html-fehlerbaeume \'$begriff)"
		. "))"    ;

#	    print STDERR $emacs_call . " --eval \"" . $eval_code . "\"";

	    open( EA, $emacs_call . " --eval \"" . $eval_code . "\" |");
	    while ( <EA> ) {
		print;
	    }
	    close(EA);
	}
	elsif ( /prozess_kurz/ ) { # Kurzerkärung zum Prozess einfügen

	    $eval_code =
		"(princ (concat \\\"\<i\>\\\" "
		. "(prozess-erklaerung \'" . $begriff . ")"
		. "\\\"; z.B. \\\""
		. "(prozess-mittel \'" . $begriff . ")"
		. "\\\"\</i\>\\\"))"
		    ;

#	    $eval_code = "(princ (concat \\\"\<i\>\\\" (prozess-erklaerung \'" . $begriff . ") \\\".\</i\>\\\"))";
	    open( EA, $emacs_call . " --eval \"" . $eval_code . "\" |");
	    while ( <EA> ) {
		print;
	    }
	    close(EA);
	}
	elsif ( /<body/ ) { # /
#	    s|<body[^>]*>|<body bgcolor=\"\#a8d9f7\">|;
	    print;

	    &format_html_input();
	}
	elsif ( /<\/body>/ ) { # /

	    &format_html_fuss();
	    exit;
	}
	else {

#	    s^\<\!-- neustart --\>^<a href=\"\/cgi-bin/eins.pl\"><img src=\"neustart.gif\" border=0></a>^;

#	    s^\<\!-- download --\>^<p><a href="ftp://localhost/pub/pkg/$begriff/">Test-Daten laden</a></p>^;

#	    s^\<\!-- entwurf --\>^<p><img src=\"entwurf-2b.gif\"></p>^;

	    s^<h2>Beschreibung</h2>^^;

	    s^<h2>Literatur</h2>^<h2>Zusätzliche Informationen</h2>^;

#	    s^h2>^h3>^;		# Überschriften anpassen

	    print;
	}
    }

    close(DATEI);
}

