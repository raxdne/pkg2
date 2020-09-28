<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg">

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

  <xsl:output method="html"/>

<xsl:template match="/">
  <html>
    <body>
  <table border="0" width="100%" cellspacing="1">
    <tbody>
      <tr>
        <th colspan="3">
          <xsl:text>Anforderungskatalog</xsl:text>
        </th>
        <th>
          <xsl:text>Check</xsl:text>
        </th>
        <th>
          <xsl:text>Repair</xsl:text>
        </th>
      </tr>
      <tr>
        <td colspan="5" align="right">
          Status "verbindlich festgeschrieben" <img src="green.png"/><br/>
          Status "in Diskussion" <img src="yellow.png"/><br/>
          Status "Handlungsbedarf" <img src="red.png"/></td>
      </tr>
      <tr>
        <td colspan="5" align="right">
          Prüffunktion aus PTC ModelCHECK "mc"<br/>
          Prüffunktion in cadlink "tcl"<br/>
          Prüffunktion in PE-Check "pec"</td>
      </tr>
      <xsl:apply-templates select="descendant::section[@class='requirements']/child::section"/>
    </tbody>
  </table>
    </body>
  </html>
</xsl:template>

<xsl:template match="section">
  <xsl:if test="child::pkg:requirement">
    <tr>
      <th colspan="5">
        <xsl:for-each select="ancestor-or-self::node()">
          <xsl:if test="child::h">
            <xsl:value-of select="child::h"/>
            <xsl:text> :: </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </th>
    </tr>
  </xsl:if>
  <xsl:apply-templates select="pkg:requirement">
    <xsl:sort select="@check" order="descending"/>
    <xsl:sort select="@color" order="descending"/>
  </xsl:apply-templates>
  <xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="pkg:requirement">
  <tr>
    <td>
      <xsl:value-of select="position()"/>
    </td>
    <td>
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="concat(@id,'.html')"/>
        </xsl:attribute>
        <xsl:value-of select="h"/>
      </xsl:element>
      <xsl:if test="@basics = 'yes'">
        <xsl:text>*</xsl:text>
      </xsl:if>
    </td>
    <td>
      <xsl:value-of select="abstract"/>
    </td>
    <th>
      <xsl:value-of select="@check"/>
      <xsl:if test="@color">
        <xsl:text> </xsl:text>
        <xsl:element name="img">
          <xsl:attribute name="src">
            <xsl:value-of select="concat(@color,'.png')"/>
          </xsl:attribute>
        </xsl:element>
      </xsl:if>
    </th>
    <th>
      <xsl:value-of select="@repair"/>
    </th>
  </tr>
</xsl:template>


</xsl:stylesheet>
