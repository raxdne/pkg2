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
  <xsl:import href="DotHeader.xsl"/>
  <xsl:import href="DotFooter.xsl"/>
  <xsl:import href="DotCopyrights.xsl"/>
  <xsl:import href="DotUtils.xsl"/>
  <!--  encoding="ISO-8859-1" -->
  <xsl:output method="text" encoding="ISO-8859-1"/>
  <xsl:variable name="id_element" select="''"/>
  <!--
       <xsl:variable name="id_element" select="'plz_cad'"/>
       <xsl:variable name="id_element" select="'cad_net'"/>
       <xsl:variable name="id_element" select="'bildbearbeitung'"/>
       -->
  <xsl:variable name="color_default" select="'black'"/>
  <xsl:variable name="length_max" select="25"/>
  <xsl:variable name="flag_color" select="true()"/>
  <xsl:variable name="flag_style" select="true()"/>
  <xsl:variable name="flag_stelle" select="true()"/>
  <xsl:variable name="flag_edge" select="true()"/>
  <xsl:variable name="flag_subnet" select="true()"/>
  <xsl:template match="/">
    <xsl:call-template name="HEADER"/>
    <xsl:choose>
      <xsl:when test="string-length($id_element)">
        <xsl:apply-templates select="//*[@id = $id_element]"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- use global by default -->
        <xsl:apply-templates select="pie/*|petrinet/*"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="COPYRIGHTNET"/>
    <xsl:call-template name="FOOTER"/>
    <xsl:call-template name="COPYRIGHTPKG"/>
  </xsl:template>
  <xsl:template match="section[@id]">
    <xsl:variable name="int_cluster">
      <xsl:choose>
        <xsl:when test="parent::pie or parent::petrinet">
          <xsl:value-of select="0"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- use global by default -->
          <xsl:value-of select="position()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="child::node()">
      <xsl:value-of select="concat('// Netz ',@id,$newline)"/>
      <xsl:if test="$flag_subnet">
        <xsl:value-of select="concat('subgraph cluster',$int_cluster,' {',$newline)"/>
        <xsl:value-of select="concat('label=','&quot;',h,'&quot;',$newline)"/>
      </xsl:if>
      <xsl:if test="$flag_stelle">
        <xsl:text>// Modelle</xsl:text>
        <xsl:value-of select="$newline"/>
        <xsl:for-each select="pkg:stelle">
          <xsl:call-template name="KNOT">
            <xsl:with-param name="id_knot">
              <xsl:value-of select="@id"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
      <xsl:text>// Prozesse</xsl:text>
      <xsl:value-of select="$newline"/>
      <xsl:for-each select="pkg:transition">
        <xsl:call-template name="KNOT">
          <xsl:with-param name="id_knot">
            <xsl:value-of select="@id"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:if test="$flag_edge">
        <xsl:text>// Relations Net</xsl:text>
        <xsl:value-of select="$newline"/>
        <xsl:apply-templates select="pkg:relation"/>
      </xsl:if>
      <xsl:apply-templates select="section[@id]"/>
      <xsl:if test="$flag_subnet">
        <xsl:value-of select="concat('}',$newline)"/>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template match="pkg:stelle|pkg:transition">
    <xsl:text>// Knot graph</xsl:text>
    <xsl:value-of select="$newline"/>
    <xsl:call-template name="KNOT">
      <xsl:with-param name="id_knot">
        <xsl:value-of select="@id"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="$flag_edge">
      <xsl:text>// Relations</xsl:text>
      <xsl:value-of select="$newline"/>
      <!--  <xsl:apply-templates select="//relation[@to = $id_element or @from = $id_element]"/> -->
      <xsl:for-each select="//pkg:relation[@to = $id_element]">
        <xsl:call-template name="KNOT">
          <xsl:with-param name="id_knot">
            <xsl:value-of select="@from"/>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
      <xsl:for-each select="//pkg:relation[@from = $id_element]">
        <xsl:call-template name="KNOT">
          <xsl:with-param name="id_knot">
            <xsl:value-of select="@to"/>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="KNOT">
    <xsl:param name="id_knot"/>
    <xsl:for-each select="//*[@id = $id_knot]">
      <xsl:value-of select="concat('&quot;',@id,'&quot;')"/>
      <xsl:text> [label = "</xsl:text>
      <xsl:call-template name="lf2br">
        <xsl:with-param name="StringToTransform" select="h"/>
      </xsl:call-template>
      <xsl:text>", </xsl:text>
      <!-- detect transition -->
      <xsl:if test="self::pkg:transition">
        <xsl:text>shape="box", </xsl:text>
      </xsl:if>
      <!-- color -->
      <xsl:text>color = "</xsl:text>
      <xsl:choose>
        <xsl:when test="$flag_color and @color">
          <xsl:value-of select="@color"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$color_default"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>", </xsl:text>
      <!-- URI -->
      <xsl:text>href = "</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>.html", </xsl:text>
      <!-- peripheries -->
      <xsl:if test="$flag_style">
        <xsl:text>peripheries="</xsl:text>
        <xsl:value-of select="@rating"/>
        <xsl:text>" </xsl:text>
      </xsl:if>
      <xsl:text>];</xsl:text>
      <xsl:value-of select="$newline"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="pkg:relation">
    <!--  -->
    <xsl:value-of select="concat('&quot;',@from,'&quot;')"/>
    <xsl:text> -&gt; </xsl:text>
    <xsl:value-of select="concat('&quot;',@to,'&quot;')"/>
    <xsl:text> [</xsl:text>
    <!-- color -->
    <xsl:text>color = "</xsl:text>
    <xsl:choose>
      <xsl:when test="$flag_edge and $flag_color and @color">
        <xsl:value-of select="@color"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$color_default"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>", </xsl:text>
    <!-- peripheries -->
    <xsl:choose>
      <xsl:when test="not($flag_edge)">
        <xsl:text>style="invis"</xsl:text>
      </xsl:when>
      <xsl:when test="$flag_style">
        <xsl:text>style="</xsl:text>
        <xsl:value-of select="@STYLE"/>
        <xsl:text>" </xsl:text>
      </xsl:when>
      <xsl:otherwise>
    </xsl:otherwise>
    </xsl:choose>
    <xsl:text>];</xsl:text>
    <xsl:value-of select="$newline"/>
  </xsl:template>

  <xsl:template match="block">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="*"/>
</xsl:stylesheet>
