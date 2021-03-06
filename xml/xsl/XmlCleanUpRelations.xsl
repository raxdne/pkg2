<?xml version="1.0" encoding="iso-8859-1"?>
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

  <xsl:output method="xml" encoding="ISO-8859-1"/>  

  <!-- ignore all elements with a lost IDREF's -->

  <xsl:template match="@*|node()">
    <xsl:choose>
      <!-- dont copy comment nodes -->
      <xsl:when test="self::comment()"/>
      <!--  -->
      <xsl:when test="self::pkg:relation">
        <xsl:variable name="id_from" select="@from"/>
        <xsl:variable name="id_to"   select="@to"/>
        <xsl:if test="//pkg:transition[@id = $id_from or @id = $id_to] and //pkg:stelle[@id = $id_from or @id = $id_to]">
          <xsl:copy>
            <xsl:apply-templates select="@*|node()" /> 
          </xsl:copy>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()" /> 
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
      
</xsl:stylesheet>




