<?xml version="1.0" encoding="ISO-8859-1"?>
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
  <xsl:output method="html" encoding="UTF-8" media-type="text/html"/>  

  <xsl:variable name="str_prefix" select="''"/>
  <xsl:variable name="n_max" select="15"/>
<!-- flag for displaying graph -->
  <xsl:variable name="flag_vmi" select="false()"/>
<!-- <xsl:variable name="id_task" select="'re'"/> -->
  <xsl:variable name="str_filter" select="''"/>
  <xsl:template match="/">
    <html>
      <body>
        <table border="0" width="95%" cellspacing="1">
          <tbody>
            <xsl:apply-templates/>
          </tbody>
        </table>
        <hr/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="pathtable">
    <tr>
      <td colspan="6">
        <xsl:choose>
          <xsl:when test="@count &gt; $n_max">
            <xsl:text>Es werden </xsl:text>
            <xsl:value-of select="$n_max"/>
            <xsl:text> von </xsl:text>
            <xsl:value-of select="@count"/>
            <xsl:text> ermittelten Pfaden dargestellt</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Es wurden </xsl:text>
            <xsl:value-of select="@count"/>
            <xsl:text> Pfade ermittelt.</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
    <xsl:apply-templates select="path">
      <xsl:sort select="count(child::pkg:stelle)"/>
    </xsl:apply-templates>
    <tr>
      <td colspan="6">
        <xsl:value-of select="concat('Ohne: ',translate($str_filter,':',' '))"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="path">
    <xsl:if test="position() &lt; $n_max + 1">
      <tr>
        <th colspan="6">
          <xsl:text>Pfad </xsl:text>
          <xsl:value-of select="position()"/>
        </th>
      </tr>
      <tr>
        <th>
          <xsl:text>Nr.</xsl:text>
        </th>
        <th>
          <xsl:text/>
        </th>
        <th>
          <xsl:text>Beschreibung</xsl:text>
        </th>
        <xsl:if test="$flag_vmi">
          <th>
            <xsl:text>V</xsl:text>
          </th>
          <th>
            <xsl:text>M</xsl:text>
          </th>
          <th>
            <xsl:text>I</xsl:text>
          </th>
        </xsl:if>
      </tr>
      <xsl:apply-templates/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="pkg:stelle|pkg:transition">
    <tr>
      <td>
        <xsl:value-of select="(position()+1)*0.5"/>
      </td>
      <xsl:element name="td">
        <xsl:attribute name="class">
          <xsl:value-of select="name()"/>
        </xsl:attribute>
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:value-of select="concat($str_prefix,@id,'.html')"/>
          </xsl:attribute>
          <xsl:value-of select="h"/>
        </xsl:element>
      </xsl:element>
      <td>
        <xsl:value-of select="abstract"/>
      </td>
      <xsl:if test="$flag_vmi">
        <td>
          <xsl:value-of select="parent"/>
        </td>
        <td>
      </td>
        <td>
      </td>
      </xsl:if>
    </tr>
  </xsl:template>
  <xsl:template match="pkg:relation">
    <xsl:if test="abstract">
      <tr>
        <td>
      </td>
        <td>
      </td>
        <td align="right">
          <xsl:value-of select="abstract"/>
        </td>
        <xsl:if test="$flag_vmi">
          <td>
        </td>
          <td>
        </td>
          <td>
        </td>
        </xsl:if>
      </tr>
    </xsl:if>
  </xsl:template>
  <xsl:template match="*">
    <tr>
      <td>
    </td>
      <td align="right">
        <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
