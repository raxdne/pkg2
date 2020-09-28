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

<xsl:output method="html" encoding="UTF-8" media-type="text/html"/>  

<xsl:variable name="name_tag" select="'stelle'"/>
<xsl:variable name="name_str" select="'Modelle'"/>

<xsl:template match="/">
  <html>
    <body>
      <table border="0" width="95%" cellspacing="1">
        <tbody>
          <xsl:apply-templates/>
        </tbody>
      </table>
    </body>
  </html>
</xsl:template>


<xsl:template match="petrinet|pie">
  <tr>
    <th colspan="3">
      <xsl:value-of select="$name_str"/>
    </th>
  </tr>
  <xsl:call-template name="ELEMENT">
    <xsl:with-param name="id_knot" select="*[name() = $name_tag]"/>
  </xsl:call-template>
  <xsl:apply-templates select="block|section[@id]"/>
</xsl:template>


<xsl:template match="section[@id]">
  <xsl:if test="not($name_tag='section')">
    <tr>
      <th colspan="3">
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:value-of select="concat(@id,'.html')"/>
          </xsl:attribute>
          <xsl:value-of select="h"/>
        </xsl:element>
      </th>
    </tr>
  </xsl:if>
  <xsl:call-template name="ELEMENT">
    <xsl:with-param name="id_knot" select="*[name() = $name_tag and @id]"/>
  </xsl:call-template>
  <xsl:apply-templates select="block|section[@id]"/>
</xsl:template>


<xsl:template name="ELEMENT">
  <xsl:param name="id_knot"/>
    <xsl:if test="not(@id='')">
    </xsl:if>
  <xsl:for-each select="$id_knot">
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
    </td>
    <td>
      <xsl:value-of select="abstract"/>
    </td>
  </tr>
  </xsl:for-each>
</xsl:template>

  <xsl:template match="block">
    <xsl:apply-templates />
  </xsl:template>

<xsl:template match="*"/>

</xsl:stylesheet>
