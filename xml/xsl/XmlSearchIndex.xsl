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
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:variable name="prefix_tmp" select="'tmp'"/>
  <xsl:variable name="prefix_tmpi" select="translate($prefix_tmp,'\','/')"/>
  <xsl:template match="/">
    <xsl:element name="site">
      <xsl:text> 
</xsl:text>
      <xsl:apply-templates select="//*[@id and not(@id = '') and h]"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="*[@id]">
    <xsl:element name="page">
      <xsl:element name="title">
        <xsl:value-of select="h"/>
      </xsl:element>
      <xsl:element name="url">
        <xsl:value-of select="@id"/>
        <xsl:text>.html</xsl:text>
      </xsl:element>
      <xsl:element name="text">
        <xsl:choose>
          <xsl:when test="abstract != ''">
            <xsl:value-of select="abstract"/>
          </xsl:when>
          <xsl:when test="h != ''">
            <xsl:value-of select="h"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@id"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <xsl:element name="content">
        <xsl:value-of select="@id"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@from"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@to"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="h"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="abstract"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="descendant::*"/>
      </xsl:element>
      <xsl:element name="rank">
        <xsl:text>1</xsl:text>
      </xsl:element>
    </xsl:element>
    <xsl:text> 
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
