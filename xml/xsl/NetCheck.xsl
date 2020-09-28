<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:pkg="http://www.tenbusch.info/pkg"
  xmlns:pie="http://www.tenbusch.info/pie">

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

<xsl:output method="text" encoding="ISO-8859-1"/>  

<xsl:variable name="newline">
<!-- a newline xsl:text element -->
<xsl:text>
</xsl:text>
</xsl:variable>

<!-- use on validated and cleaned xml's only -->
<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="pie|section">
  <xsl:choose>
    <xsl:when test="not(attribute::id)">
      <xsl:value-of select="concat(name(),' ',position(),' ','&quot;',h,'&quot;',': needs an ID',$newline)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="not(child::h)">
        <xsl:value-of select="concat(name(),' ',@id,': needs a name',$newline)"/>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
  <!-- empty net -->
  <xsl:if test="not(child::*)">
    <xsl:value-of select="concat(name(),' ',@id,': is empty',$newline)"/>
  </xsl:if>

  <xsl:apply-templates select="section"/>
  <xsl:apply-templates select="pkg:stelle"/>
  <xsl:apply-templates select="pkg:transition"/>
  <xsl:apply-templates select="pkg:requirement"/>
  <xsl:apply-templates select="pkg:relation"/>
</xsl:template>

<xsl:template match="pkg:stelle|pkg:transition|pkg:requirement">
  <!-- these elements are needing id and h -->
  <xsl:choose>
  <xsl:when test="not(attribute::id or attribute::class)">
    <xsl:value-of select="concat(name(),' ',position(),': needs an ID',$newline)"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:variable name="id" select="@id"/>
    <xsl:if test="not(child::h)">
      <xsl:value-of select="concat(name(),' ',@id,': needs a name',$newline)"/>
    </xsl:if>
    <!-- report undescribed elements
    <xsl:if test="not(child::abstract)">
      <xsl:value-of select="concat(name(),' ',@id,': is not described',$newline)"/>
    </xsl:if>
 -->
    <!-- report isolated knots -->
    <xsl:if test="(self::pkg:stelle and not(//pkg:relation[@from = $id or @to = $id])) or (self::pkg:transition and not(//pkg:relation[@from = $id]))">
      <xsl:value-of select="concat(name(),' ',@id,': is isolated',$newline)"/>
    </xsl:if>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template match="pkg:relation">
  <xsl:variable name="id_from" select="@from"/>
  <xsl:variable name="id_to"   select="@to"/>

  <xsl:if test="$id_from=''">
    <xsl:value-of select="concat(name(),' @from is empty',$newline)"/>
  </xsl:if>

  <xsl:if test="$id_to=''">
    <xsl:value-of select="concat(name(),' @to is empty',$newline)"/>
  </xsl:if>

  <!-- knots must be pkg:stelle/pkg:transition or pkg:transition/pkg:stelle -->
  <xsl:if test="not((//pkg:stelle[@id = $id_from] and //pkg:transition[@id = $id_to]) or (//pkg:transition[@id = $id_from] and //pkg:stelle[@id = $id_to]))">
    <xsl:value-of select="concat(name(),' ',@from,' -> ',@to,': Knots not suitable',$newline)"/>
  </xsl:if>
  <xsl:if test="parent::section/parent::section">
    <!-- both knots must be in same section -->
    <xsl:if test="not((../pkg:stelle[@id = $id_from] and ../pkg:transition[@id = $id_to]) or (../pkg:transition[@id = $id_from] and ../pkg:stelle[@id = $id_to]))">
      <xsl:value-of select="concat(name(),' ',@from,' -> ',@to,': Knots in different sections',$newline)"/>
      </xsl:if>
      <xsl:if test="parent::petrinet or parent::pie and //*[@id = $id_from]/../@id = //*[@id = $id_to]/../@id and not(//*[@id = $id_from]/parent::petrinet)">
        <!-- both knots must be in same section -->
        <xsl:value-of select="concat(name(),' ',@from,' -> ',@to,': Knots are in same section ',//*[@id = $id_from]/../@id,$newline)"/>
     </xsl:if>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
