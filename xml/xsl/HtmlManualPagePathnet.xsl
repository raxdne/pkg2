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
  <xsl:variable name="id_element" select="'main'"/>
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
        <table border="0" width="100%" cellspacing="1">
          <tbody>
            <xsl:apply-templates select="*[1]"/>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="pie|petrinet">
    <xsl:element name="h3">
      <xsl:value-of select="h"/>
    </xsl:element>
    <xsl:copy-of select="document(concat($prefix_tmpi,'/graph_',$id_element,'.xml'))"/>
    <!-- -->
    <xsl:element name="center">
      <xsl:element name="img">
        <xsl:attribute name="usemap">
          <xsl:text>#pkg2</xsl:text>
          <!-- <xsl:value-of select="@ID"/> -->
        </xsl:attribute>
        <xsl:attribute name="src">
          <xsl:value-of select="concat('graph_',$id_element,'.png')"/>
        </xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:text>Graph </xsl:text>
          <xsl:value-of select="$id_element"/>
        </xsl:attribute>
      </xsl:element>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
