<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg" version="1.0">
	<!--

PKG2 - ProzessKettenGenerator second implementation 
Copyright (C) 1999-2020 by Alexander Tenbusch

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License 
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

-->
	<xsl:variable name="str_prefix" select="''"/>
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:template match="/">
		<html>
			<body>
				<xsl:call-template name="MENULIST"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="MENULIST">
		<xsl:element name="ul">
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'index.html')"/>
				</xsl:attribute>
				<xsl:element name="img">
					<xsl:attribute name="src">
					<xsl:value-of select="concat($str_prefix,'logo.png')"/>
				</xsl:attribute>
					<xsl:attribute name="alt">PKG2-Logo</xsl:attribute>
				</xsl:element>
			</xsl:element>
		</xsl:element>
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'netze.html')"/>
				</xsl:attribute>
				<xsl:text>Netze</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'modelle.html')"/>
				</xsl:attribute>
				<xsl:text>Modelle</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'prozesse.html')"/>
				</xsl:attribute>
				<xsl:text>Prozesse</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'anforderungen.html')"/>
				</xsl:attribute>
				<xsl:text>Anforderungen</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
                                  <!-- <xsl:value-of select="concat('/cxproc/exe','?file=main.xml','&amp;','cxp=PkgSearchPath')"/> -->
                                  <xsl:value-of select="concat($str_prefix,'pfad-suche.html')"/>
				</xsl:attribute>
				<xsl:text>Pfadsuche</xsl:text>
			</xsl:element>
		</xsl:element>
<!--
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'text-suche.html')"/>
				</xsl:attribute>
				<xsl:text>Textsuche</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="li">
			<xsl:attribute name="class">ui-tab</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="class">ui</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="concat($str_prefix,'hilfe.html')"/>
				</xsl:attribute>
				<xsl:text>Hilfe</xsl:text>
			</xsl:element>
		</xsl:element>
-->
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
