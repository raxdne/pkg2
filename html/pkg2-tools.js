//
//
//

// Bsp. von http://www.metaprog.com/samples/encoder.htm


function sendAnnotatedMailTo(name, company, domain, subject, body) {
  locationstring = 'mai' + 'lto:' + name + '@' + company + '.' + domain + "?subject=" + escape("PKG2: Kommentar") + "&body=" + escape("\nzur Seite: " + location.href);
  window.location.replace(locationstring);
}

function sendAnnotatedMailPKG2(address) {
  //
  locationstring = 'mailto:' + address + "?subject=" + escape("PKG2: Kommentar") + "&body=" + escape("\nzur Seite: " + location.href);
  window.location.replace(locationstring);
}

var arrNet = new Array();


function setChildsInactive(nameNet) {

    var formSearch = document.forms[0];
    var flagDisable = true;
    //    
    for (i=0; i<formSearch.elements.length; i++) {

	if (formSearch.elements[i].name == nameNet) {
	    flagDisable = formSearch.elements[i].checked;
	}
	else {
	    for (j=0; j<arrNet[nameNet].length; j++) {
		if (formSearch.elements[i].value == arrNet[nameNet][j]) {
		    formSearch.elements[i].disabled = flagDisable;
		}
	    }
	}
    }
}


// TODO: add setStateInactive() for start and target

function getChildsInactive() {

    var formSearch = document.forms[0];
    var strResult = ':';

    //    
    for (i=0; i<formSearch.elements.length; i++) {
	// (formSearch.elements[i].name=='state' || formSearch.elements[i].name=='transition')
	if (formSearch.elements[i].checked) {
	    strResult = strResult.concat(formSearch.elements[i].value + ':');
	}
    }
    formSearch.elements['removed'].value = strResult;
    //alert(strResult);

    formSearch.submit();
}

