<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg">

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

  <!-- map PKG2 specific elements to PIE -->

  <xsl:template match="@*|node()">
    <xsl:choose>
      <!--  -->
      <xsl:when test="self::relation|self::pkg:relation|self::req|self::pkg:req"/>
      <xsl:when test="self::stelle or self::pkg:stelle or self::transition or self::pkg:transition">
        <xsl:element name="section">
          <xsl:apply-templates select="@*|node()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::abstract or self::pkg:abstract">
        <xsl:element name="p">
          <xsl:apply-templates select="@*|node()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::copyright or self::pkg:copyright or self::author or self::pkg:author">
        <xsl:element name="p">
          <xsl:value-of select="concat(name(),': ',.)"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()" /> 
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>