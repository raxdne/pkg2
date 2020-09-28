// Tipue 3.0.2
//
// Tipue Copyright (C) 2002-2006 Tri-State Consultants. See www.tipue.com for further details
// Tipue is open source and released under the GNU General Public License


// ---------- script properties ----------


var results_location = 'text-suche-ergebnis.html';
var results_per_page = 10;
var xml = 1;
var xml_data = 'tip_data.xml';
var whole_words = 0;
var context = 1;
var context_length = 25;
var include_num = 1;
var include_url = 0;
var header_links = 0;
var bold_query = 1;
var bold_title = 1;
var bold_footer = 1;
var include_images = 0;
var image_height = 0;
var image_width = 0;


// ---------- string properties ----------


var s_1 = 'Your search - ';
var s_2 = ' - did not match any documents.<p>Suggestions:<p>Make sure all keywords are spelled correctly.<br>Try different or more general keywords.';
var s_3 = 'Previous';
var s_4 = 'Next';
var s_5 = 'to';
var s_6 = 'of';
var s_7 = 'for';
// var s_8 = '<p>Search powered by open source <a href="http://www.tipue.com" target="_blank">Tipue</a>';
var s_8 = '';
// var s_9 = 'Blank search';
var s_9 = 'Kein Ergebnis';


// ---------- end of properties ----------


var fo = new Array();
var tid = window.location.search;
tid = decodeURI(tid);
var list = tid.split("&");
for (i = 0; i <= list.length - 1; i++)
{
	var fot = list[i].split("="); 
	fo.splice(fo.length, 2, fot[0], fot[1]);
}
for (i = 0; i <= fo.length - 1; i++)
{
	fo[i] = fo[i].replace(/\+/g," ");
	fo[i] = unescape(fo[i]);
}
var dit = fo[1];
var tn = parseInt(fo[3]);
var od = dit;
var ww = whole_words;
var nr = results_per_page;
var r_l = results_location;
var b_q = bold_query;
var b_t = bold_title;
var b_f = bold_footer;
var ct = context;
var ct_l = context_length;
var nc = 0;
var nd = 0;
var tr = new Array();
var rt = new Array();
var co = 0;
var tm = 0;

var nud = false;
if (dit == '' || dit == ' ') nud = true;

if (xml == 1)
{
	var s = new Array();
	if (window.ActiveXObject)
	{
		var xmldoc = new ActiveXObject("Microsoft.XMLDOM");
		xmldoc.async = false;
		xmldoc.onreadystatechange = function ()
		{
			if (xmldoc.readyState == 4) get_xml();
		}
	}
	else if (document.implementation && document.implementation.createDocument)
	{
		var xmldoc = document.implementation.createDocument("", "", null);
		xmldoc.async = false;
		xmldoc.onload = get_xml;
	}
	xmldoc.load(xml_data);
	
}

function get_xml()
{
	if (xml == 1)
	{
		if (document.implementation && document.implementation.createDocument) xmldoc.normalize();
		var pages = xmldoc.getElementsByTagName("page");
		for (var c = 0; c < pages.length; c++)
		{
			var rs = pages[c];
			var es0 = rs.getElementsByTagName("title")[0].firstChild.data;
			var es1 = rs.getElementsByTagName("url")[0].firstChild.data;
			var es2 = rs.getElementsByTagName("text")[0].firstChild.data;
			var es3 = rs.getElementsByTagName("content")[0].firstChild.data;
			if (rs.getElementsByTagName("open").length > 0) var es4 = rs.getElementsByTagName("open")[0].firstChild.data; else var es4 = '0';
			if (rs.getElementsByTagName("rank").length > 0) var es5 = rs.getElementsByTagName("rank")[0].firstChild.data; else var es5 = '0';
			if (rs.getElementsByTagName("image").length > 0) var es6 = rs.getElementsByTagName("image")[0].firstChild.data; else var es6 = '';
			s[c] = es0 + '^' + es1 + '^' + es2 + '^' + es3 + '^' + es4 + '^' + es5 + '^' + es6;
		}
	}
}

if (dit.charAt(0) == '"' && dit.charAt(dit.length - 1) == '"') tm = 1;
var rn = dit.search(/ or /i);
if (rn != -1) tm = 2;
rn = dit.search(/ not /i);
if (rn != -1 && tm != 1) dit = dit.replace(/ not /gi, ' -');
rn = dit.search(/\+/i);
if (rn != -1)
{
	rn = dit.search(/ /i);
	if (rn != 0) dit = dit.replace(/\+/gi, ' +');
}

if (tm == 0)
{
	var ct_d = 0;
	var woin = new Array();
	dit = dit.replace(/ and /gi, ' ');
	var wt = dit.split(' ');
	for (var a = 0; a < wt.length; a++)
	{
		woin[a] = 0;
		if (wt[a].charAt(0) == '-') woin[a] = 1;
	}
	for (var a = 0; a < wt.length; a++)
	{
		wt[a] = wt[a].replace(/^\-|^\+/gi, '');
	}
	a = 0;
	for (var c = 0; c < s.length; c++)
	{
		s[c] = s[c].replace(/&apos;/gi, '\'');
		s[c] = s[c].replace(/&amp;/gi, '\&');
		s[c] = s[c].replace(/&quot;/gi, '\"');
		s[c] = s[c].replace(/&gt;/gi, '\>');
		s[c] = s[c].replace(/&lt;/gi, '\<');
		var es = s[c].split('^');
		var rk = 100;
		if (es[5] == null) es[5] = '0';
		if (parseInt(es[5]) > 10) es[5] = '10';
		var pa = 0;
		var nh = 0;
		for (var i = 0; i < woin.length; i++)
		{
			if (woin[i] == 0)
			{
				nh++;
				var nt = 0;
				if (ww == 1) var pat = new RegExp("\\b" + wt[i] + "\\b", 'i'); else var pat = new RegExp(wt[i], 'i');
				rn = es[0].search(pat);
				if (rn != -1)
				{
					rk = rk - 11;
					rk = rk - parseInt(es[5]);					
					nt = 1;
					if (ct == 1) ct_d = 1;
				}
				rn = es[2].search(pat);
				if (rn != -1)
				{
					rk = rk - 11;
					rk = rk - parseInt(es[5]);					
					nt = 1;
					if (ct == 1) ct_d = 1;
				}
				rn = es[3].search(pat);
				if (rn != -1)
				{
					rk = rk - 11;
					rk = rk - parseInt(es[5]);					
					nt = 1;
				}
				if (nt == 1) pa++;
			}
			if (woin[i] == 1)
			{
				if (ww == 1) var pat = new RegExp("\\b" + wt[i] + "\\b", 'i'); else var pat = new RegExp(wt[i], 'i');
				rn = es[0].search(pat);
				if (rn != -1) pa = 0;
				rn = es[2].search(pat);
				if (rn != -1) pa = 0;
				rn = es[3].search(pat);
				if (rn != -1) pa = 0;
			}
		}
		if (pa == nh)
		{
			if (ct != 0 && ct_d == 0)
			{
				if (es[3].length > 120)
				{
					if (ww == 1) var pat = new RegExp("\\b" + wt[0] + "\\b", 'i'); else var pat = new RegExp(wt[0], 'i');	
					rn = es[3].search(pat);		
					if (rn > 50)
					{
						var t_1 = es[3].substr(rn - 49);
						rn = t_1.indexOf('. ');
						if (rn != -1)
						{
							t_1 = t_1.substr(rn + 1);
							var t_2 = t_1.split(' ');
							if (t_2.length > ct_l)
							{
								es[2] = '';
								for (var i = 1; i < ct_l + 1; i++)
								{
									es[2] = es[2] + ' ' + t_2[i];
								}
								
								if (es[2].charAt(es[2].length -1) == '.' || es[2].charAt(es[2].length -1) == ',') es[2] = es[2].substr(0, es[2].length - 1);
								es[2] = es[2] + ' ...';
							}
						}
					}
				}
			}
			tr[a] = rk + '^' + es[0] + '^' + es[1] + '^' + es[2] + '^' + es[3] + '^' + es[4] + '^' + es[5] + '^' + es[6];
			a++;
		}
	}
	tr.sort();
	co = a;
}

if (tm == 1)
{
	dit = dit.replace(/"/gi, '');
	var a = 0;
	var ct_d = 0;
	var pat = new RegExp(dit, 'i');
	for (var c = 0; c < s.length; c++)
	{
		s[c] = s[c].replace(/&apos;/gi, '\'');
		s[c] = s[c].replace(/&amp;/gi, '\&');
		s[c] = s[c].replace(/&quot;/gi, '\"');
		s[c] = s[c].replace(/&gt;/gi, '\>');
		s[c] = s[c].replace(/&lt;/gi, '\<');
		var es = s[c].split('^');
		var rk = 100;
		if (es[5] == null) es[5] = '0';
		if (parseInt(es[5]) > 10) es[5] = '10';
		rn = es[0].search(pat);
		if (rn != -1)
		{
			rk = rk - 11;
			rk = rk - parseInt(es[5]);
			if (ct == 1) ct_d = 1;
		}
		rn = es[2].search(pat);
		if (rn != -1)
		{
			rk = rk - 11;
			rk = rk - parseInt(es[5]);
			if (ct == 1) ct_d = 1;
		}
		rn = es[3].search(pat);
		if (rn != -1)
		{
			rk = rk - 11;
			rk = rk - parseInt(es[5]);
		}
		if (rk < 100)
		{
			if (ct != 0 && ct_d == 0)
			{
				if (es[3].length > 120)
				{
					if (ww == 1) var pat = new RegExp("\\b" + dit + "\\b", 'i'); else var pat = new RegExp(dit, 'i');	
					rn = es[3].search(pat);		
					if (rn > 50)
					{
						var t_1 = es[3].substr(rn - 49);
						rn = t_1.indexOf('. ');
						if (rn != -1)
						{
							t_1 = t_1.substr(rn + 1);
							var t_2 = t_1.split(' ');
							if (t_2.length > ct_l)
							{
								es[2] = '';
								for (var i = 1; i < ct_l + 1; i++)
								{
									es[2] = es[2] + ' ' + t_2[i];
								}
								
								if (es[2].charAt(es[2].length -1) == '.' || es[2].charAt(es[2].length -1) == ',') es[2] = es[2].substr(0, es[2].length - 1);
								es[2] = es[2] + ' ...';
							}
						}
					}
				}
			}
			tr[a] = rk + '^' + es[0] + '^' + es[1] + '^' + es[2] + '^' + es[3] + '^' + es[4] + '^' + es[5] + '^' + es[6];
			a++;
		}
	}
	tr.sort();
	co = a;
}

if (tm == 2)
{
	dit = dit.replace(/ or /gi, ' ');
	var wt = dit.split(' ');
	var ct_d = 0;
	var a = 0;
	for (var i = 0; i < wt.length; i++)
	{
		if (ww == 1) var pat = new RegExp("\\b" + wt[i] + "\\b", 'i'); else var pat = new RegExp(wt[i], 'i');
		for (var c = 0; c < s.length; c++)
		{
			s[c] = s[c].replace(/&apos;/gi, '\'');
			s[c] = s[c].replace(/&amp;/gi, '\&');
			s[c] = s[c].replace(/&quot;/gi, '\"');
			s[c] = s[c].replace(/&gt;/gi, '\>');
			s[c] = s[c].replace(/&lt;/gi, '\<');
			var es = s[c].split('^');
			var rk = 100;
			if (es[5] == null) es[5] = '0';
			if (parseInt(es[5]) > 10) es[5] = '10';
			var pa = 0;
			rn = es[0].search(pat);
			if (rn != -1)
			{
				rk = rk - 11;
				rk = rk - parseInt(es[5]);		
				if (rn != -1)
				{
					for (var e = 0; e < rt.length; e++) {
						if (s[c] == rt[e])
						{
							pa = 1;
							if (ct == 1) ct_d = 1;
						}
					}
				}
			}
			rn = es[2].search(pat);
			if (rn != -1)
			{
				rk = rk - 11;
				rk = rk - parseInt(es[5]);		
				if (rn != -1)
				{
					for (var e = 0; e < rt.length; e++)
					{
						if (s[c] == rt[e])
						{
							pa = 1;
							if (ct == 1) ct_d = 1;
						}
					}
				}
			}
			rn = es[3].search(pat);
			if (rn != -1)
			{
				rk = rk - 11;
				rk = rk - parseInt(es[5]);		
				if (rn != -1)
				{
					for (var e = 0; e < rt.length; e++)
					{
						if (s[c] == rt[e]) pa = 1;
					}
				}
			}
			if (rk < 100 && pa == 0)
			{
				if (ct != 0 && ct_d == 0)
				{
					if (es[3].length > 120)
					{
						if (ww == 1) var pat = new RegExp("\\b" + wt[0] + "\\b", 'i'); else var pat = new RegExp(wt[0], 'i');	
						rn = es[3].search(pat);		
						if (rn > 50)
						{
							var t_1 = es[3].substr(rn - 49);
							rn = t_1.indexOf('. ');
							if (rn != -1)
							{
								t_1 = t_1.substr(rn + 1);
								var t_2 = t_1.split(' ');
								if (t_2.length > ct_l)
								{
									es[2] = '';
									for (var i = 1; i < ct_l + 1; i++)
									{
										es[2] = es[2] + ' ' + t_2[i];
									}

									if (es[2].charAt(es[2].length -1) == '.' || es[2].charAt(es[2].length -1) == ',') es[2] = es[2].substr(0, es[2].length - 1);
									es[2] = es[2] + ' ...';
								}
							}
						}
					}
				}
				rt[a] = s[c];
				tr[a] = rk + '^' + es[0] + '^' + es[1] + '^' + es[2] + '^' + es[3] + '^' + es[4] + '^' + es[5] + '^' + es[6];
				a++;			
				co++;
			}
		}
	}
	tr.sort();
}
if (nud) co = 0;


// ---------- External references ----------


function tip_query()
{
	if (od != 'undefined' && od != null) document.tip_Form.d.value = od;
}

function tip_header()
{
	if (co > 0)
	{
		var ne = nr + tn;
		if (ne > co) ne = co;
		document.write('Results ', tn + 1, ' ', s_5, ' ', ne, ' ', s_6, ' ', co, ' ', s_7 , ' ');
		if (header_links == 1)
		{
			if (tm == 0 || tm == 2)
			{
				var wt = od.split(' ');
				for (var i = 0; i < wt.length; i++)
				{
					if (wt[i].toLowerCase() != 'or' && wt[i].toLowerCase() != 'and' && wt[i].toLowerCase() != 'not' && wt[i] != '+' && wt[i] != '-')
					{
						if (wt[i].charAt(0) == '+' || wt[i].charAt(0) == '-')
						{
							document.write(wt[i].charAt(0));
							wt[i] = wt[i].slice(1, wt[i].length); 
						}
						document.write('<a href="', r_l, '?d=', wt[i], '&n=0');
						document.write('">', wt[i], '</a> ');
					}
					else document.write(wt[i] + ' ');	
				}
			}
			else document.write(od);
		}
		else document.write(od);		
	}
}

function tip_out()
{
	if (co == 0)
	{
		if (od.length == 0)
		{
			document.write(s_9);
		}
		else
		{
			document.write(s_1);
			if (b_q == 1) document.write('<b>' + od + '</b>'); else document.write(od);
			document.write(s_2);
		}
		return;
	}
	if (tn + nr > co) nd = co; else nd = tn + nr;
	for (var a = tn; a < nd; a++)
	{
		var os = tr[a].split('^');
		if (os[5] == null) os[5] = '0';
		if (include_images == 1)
		{
			if (os[7] != null) document.write('<a href="', os[2], '"><img src="', os[7], '" title="', os[1], '" alt="', os[1], '" border=0 width=', image_width, ' height=', image_height, '></a><p>');
		}
		if (b_q == 1 && (tm == 0 || tm == 2))
		{
			for (var i = 0; i < wt.length; i++)
			{
				var lw = wt[i].length;
				var tw = new RegExp(wt[i], 'i');
				rn = os[3].search(tw);
				if (rn != -1)
				{
					var o1 = os[3].slice(0, rn);
					var o2 = os[3].slice(rn, rn + lw);
					var o3 = os[3].slice(rn + lw);
					os[3] = o1 + '<b>' + o2 + '</b>' + o3; 
				}
			}
		}
		if (b_q == 1 && tm == 1)
		{
			var lw = dit.length;
			var tw = new RegExp(dit, 'i');
			rn = os[3].search(tw);
			if (rn != -1)
			{
				var o1 = os[3].slice(0, rn);
				var o2 = os[3].slice(rn, rn + lw);
				var o3 = os[3].slice(rn + lw);
				os[3] = o1 + '<b>' + o2 + '</b>' + o3;
			}
		}
		if (include_num == 1) document.write(a + 1, '. ');
		if (os[5] == '0')
		{	
			if (b_t == 1) document.write('<a href="', os[2], '"><b>', os[1], '</b></a>'); else document.write('<a href="', os[2], '">', os[1], '</a>');
		}
		if (os[5] == '1')
		{
			if (b_t == 1) document.write('<a href="', os[2], '" target="_blank"><b>', os[1], '</b></a>'); else document.write('<a href="', os[2], '" target="_blank">', os[1], '</a>');
		}
		if (os[5] != '0' && os[5] != '1')
		{
			if (b_t == 1) document.write('<a href="', os[2], '" target="', os[5], '"><b>', os[1], '</b></a>'); else document.write('<a href="', os[2], '" target="', os[5], '">', os[1], '</a>');
		}
		if (os[3].length > 1) document.write('<br>', os[3]);
		if (include_url == 1)
		{
			if (os[5] == '0') document.write('<br><a href="', os[2], '">', os[2], '</a><p>');
			if (os[5] == '1') document.write('<br><a href="', os[2], '" target="_blank">', os[2], '</a><p>');
			if (os[5] != '0' && os[5] != '1') document.write('<br><a href="', os[2], '" target="', os[5], '">', os[2], '</a><p>');
		}
		else document.write('<p>');
	}
}

function tip_footer()
{	
	if (co > nr)
	{
		encodeURI(od);
		var np = Math.ceil(co / nr);
		nc = co - (tn + nr);
		if (tn > 0) var na = Math.ceil(tn / nr) + 1; else var na = 1;
		if (tn > 1) document.write('<a href="', r_l, '?d=', od, '&n=', tn - nr, '">', s_3, '</a> &nbsp;');
		if (np < 10)
		{
			for (var i = 0; i < np; i++)
			{
				var nb = nr * i;
				if (nb == tn)
				{
					if (b_f == 1) document.write('<b>', i + 1, '</b> &nbsp;'); else document.write(i + 1, ' &nbsp;');
				}
				else document.write('<a href="', r_l, '?d=', od, '&n=', nb, '">', i + 1, '</a> &nbsp;');
			}
		}
		if (np > 9)
		{
			if (na < 8)
			{
				for (var i = 0; i < 9; i++)
				{
					var nb = nr * i;
					if (nb == tn)
					{
						if (b_f == 1) document.write('<b>', i + 1, '</b> &nbsp;'); else document.write(i + 1, ' &nbsp;');
					}
					else document.write('<a href="', r_l, '?d=', od, '&n=', nb, '">', i + 1, '</a> &nbsp;');
				}
			}
			else
			{
				var ng = na - 5;
				if (np > ng + 9) var nf = ng + 9; else nf = np; 
				for (var i = ng; i < nf; i++)
				{
					var nb = nr * i;
					if (nb == tn)
					{
						if (b_f == 1) document.write('<b>', i + 1, '</b> &nbsp;'); else document.write(i + 1, ' &nbsp;');
					}
					else document.write('<a href="', r_l, '?d=', od, '&n=', nb, '">', i + 1, '</a> &nbsp;');
				}				
			}
		}
		if (nc > 0) document.write('<a href="', r_l, '?d=', od, '&n=', tn + nr, '">', s_4, '</a>');
	}
	document.write(s_8);
}
