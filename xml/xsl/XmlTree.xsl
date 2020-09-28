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
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:variable name="id_element" select="'cad_des'"/>
  <xsl:variable name="list_black" select="'modellbildung,mentales_modell,cad_ref,cad_modellierung,vr,vr_aufbereitung,geometrie_vergleich'"/>

  <xsl:variable name="int_depth" select="6"/>

  <xsl:template match="/">
    <xsl:element name="map">
      <!--
      <xsl:element name="node">
	<xsl:attribute name="TEXT">
	  <xsl:value-of select="//*[@id = $id_element]/child::h/text()"/>
	</xsl:attribute>
      -->
	<xsl:choose>
	  <xsl:when test="string-length($id_element)">
            <xsl:apply-templates select="//*[@id = $id_element]">
	      <xsl:with-param name="int_depth" select="$int_depth"/>
	    </xsl:apply-templates>
	  </xsl:when>
	  <xsl:otherwise>
            <!-- use global by default -->
	  </xsl:otherwise>
	</xsl:choose>
	<!--
      </xsl:element>
	-->
    </xsl:element>
  </xsl:template>

  <xsl:template match="pkg:stelle|pkg:transition">
    <xsl:param name="int_depth" select="0"/>
    <xsl:param name="id_last" select="''"/>
    <xsl:element name="node">
      <xsl:attribute name="TEXT">
	<xsl:value-of select="child::h/text()"/>
      </xsl:attribute>
      <xsl:choose>
	<xsl:when test="name() = 'stelle'">
	  <xsl:element name="icon">
	    <xsl:attribute name="BUILTIN">list</xsl:attribute>
	  </xsl:element>
	</xsl:when>
	<xsl:when test="$int_depth &gt; 1">
	  <xsl:attribute name="FOLDED">true</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$int_depth &gt; 1">
	<xsl:variable name="id" select="@id"/>
	<xsl:apply-templates select="//pkg:relation[@from = $id and not(@to = $id_last) and not(@to = $id_element)]">
	  <xsl:with-param name="int_depth" select="$int_depth - 1"/>
	</xsl:apply-templates>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="pkg:relation">
    <xsl:param name="int_depth" select="0"/>
    <xsl:variable name="id_to" select="@to"/>
    <xsl:apply-templates select="//*[@id = $id_to and not(contains($list_black,@id))]">
      <xsl:with-param name="int_depth" select="$int_depth"/>
      <xsl:with-param name="id_last" select="@from"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="block">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="*"/>
</xsl:stylesheet>
