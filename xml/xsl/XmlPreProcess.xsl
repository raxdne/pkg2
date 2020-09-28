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

  <!-- copy all elements and process include instructions -->

  <xsl:template match="@*|node()">
    <xsl:choose>
      <!-- not valid -->
      <xsl:when test="@VALID = 'no'"/>
      <!-- includes -->
      <xsl:when test="(self::SUBNET or self::KATALOG or self::DICTIONARY) and @FILE">
        <xsl:comment>
          <xsl:text> begin of include: </xsl:text>
          <xsl:value-of select="@FILE"/>
          <xsl:text> </xsl:text>
        </xsl:comment>
        <xsl:text> 
</xsl:text>
        <xsl:apply-templates select="document(@FILE)/PETRINET/*"/>
        <xsl:comment>
          <xsl:text> end of include: </xsl:text>
          <xsl:value-of select="@FILE"/>
          <xsl:text> </xsl:text>
        </xsl:comment>
        <xsl:text> 
</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()" /> 
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
      
</xsl:stylesheet>

