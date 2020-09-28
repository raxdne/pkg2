<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg">

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

  <xsl:variable name="font">Helvetica</xsl:variable>

  <xsl:template name="HEADER">
  <xsl:text>// </xsl:text><xsl:value-of select="h"/>

<xsl:text>
digraph pkg2 {
//overlap=&quot;false&quot;;
//splines=&quot;true&quot;;
//Damping=&quot;0.5&quot;;
//ratio = &quot;fill&quot;;
fontsize = &quot;8&quot;
</xsl:text>

<xsl:text>  fontname = &quot;</xsl:text>
<xsl:value-of select="$font"/>
<xsl:text>&quot;
</xsl:text>

<xsl:text>label = &quot;(C) </xsl:text>
<xsl:value-of select="/descendant::copyright[1]"/>
<xsl:text>&quot;
</xsl:text>

<xsl:text>

node [
  fixedsize= &quot;true&quot;
  shape = &quot;circle&quot;
  fontsize = &quot;9&quot;
</xsl:text>

<xsl:text>  fontname = &quot;</xsl:text>
<xsl:value-of select="$font"/>
<xsl:text>&quot;
</xsl:text>

<xsl:text>
];

</xsl:text>
</xsl:template>

</xsl:stylesheet>
