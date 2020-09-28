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
  <xsl:import href="PieHtml.xsl"/>
  <xsl:output method="html"/>
  <xsl:variable name="id_element" select="''"/>
<!--  -->
  <xsl:variable name="prefix_tmp" select="'tmp'"/>
  <xsl:variable name="prefix_tmpi" select="translate($prefix_tmp,'\','/')"/>
  <xsl:variable name="level_hidden" select="0"/>
<!-- flag for displaying graph -->
  <xsl:variable name="flag_graph" select="true()"/>
<!-- flag for matrix of requirements -->
  <xsl:variable name="flag_req" select="true()"/>
<!-- flag for including external docs -->
  <xsl:variable name="flag_doc" select="true()"/>
<!--  -->
  <xsl:variable name="flag_xpath" select="true()"/>
<!--  -->
  <xsl:variable name="str_url"  select="''"/>
<!-- additional language 'en' -->
  <xsl:variable name="lang" select="''"/>
  <xsl:template match="/">
    <html>
      <body>
        <table border="0" width="95%" cellspacing="1">
          <tbody>
            <xsl:apply-templates select="//*[@id = $id_element]"/>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="pkg:stelle|pkg:transition|pkg:requirement|section[@id]">
    <xsl:call-template name="THEADER"/>
    <xsl:if test="$flag_graph and not(self::pkg:requirement)">
      <tr>
        <td align="center">
          <xsl:copy-of select="document(concat($prefix_tmpi,'/graph_',$id_element,'.xml'))"/>
<!-- -->
          <xsl:element name="img">
            <xsl:attribute name="usemap">
              <xsl:text>#pkg2</xsl:text>
<!-- <xsl:value-of select="@id"/> -->
            </xsl:attribute>
            <xsl:attribute name="src">
              <xsl:value-of select="concat('graph_',@id,'.png')"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
              <xsl:value-of select="concat('Graph ',@id)"/>
            </xsl:attribute>
          </xsl:element>
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="not(self::section)">
      <tr>
        <td>
          <xsl:apply-templates select="*[not(name()='h') and not(name()='check')]"/>
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="self::pkg:requirement and child::pkg:check">
      <tr>
        <td>Prüfungen
        <ul><xsl:apply-templates select="pkg:check"/></ul>
      </td>
      </tr>
    </xsl:if>
  </xsl:template>
  <xsl:template name="THEADER">
    <tr>
      <th>
        <xsl:value-of select="h"/>
<!-- only if parent is a subnet -->
        <xsl:text> (</xsl:text>
        <xsl:choose>
          <xsl:when test="self::pkg:stelle or self::pkg:transition or self::section">
            <xsl:element name="a">
              <xsl:attribute name="href">
                <xsl:value-of select="concat(parent::section/@id,'.html')"/>
              </xsl:attribute>
              <xsl:value-of select="parent::section/h"/>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="parent::section/h"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:if test="@dimension">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@dimension"/>
        </xsl:if>
<!-- mark check properties -->
        <xsl:if test="self::pkg:requirement">
          <xsl:if test="@color">
            <xsl:text> </xsl:text>
            <xsl:element name="img">
              <xsl:attribute name="src">
                <xsl:value-of select="concat(@color,'.png')"/>
              </xsl:attribute>
            </xsl:element>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:value-of select="@check"/>
        </xsl:if>
      </th>
    </tr>
  </xsl:template>
  <xsl:template match="pkg:check">
    <li>
      <xsl:choose>
        <xsl:when test="@href">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </li>
  </xsl:template>
  <xsl:template match="pkg:relation">
    <tr>
      <th>
        <xsl:value-of select="@to"/>
      </th>
    </tr>
    <xsl:apply-templates select="pkg:req"/>
  </xsl:template>
</xsl:stylesheet>
