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

<xsl:template name="COPYRIGHTNET">
<xsl:text>
</xsl:text>
<xsl:value-of select="concat('// Petrinet:  ',/descendant::section[1]/h)"/>
<xsl:text>
</xsl:text>
<xsl:value-of select="concat('// Version:   ',/descendant::section[1]/@version)"/>
<xsl:text>
</xsl:text>
<xsl:value-of select="concat('// Contact:   ',/descendant::author[1])"/>
<xsl:text>
</xsl:text>
<xsl:value-of select="concat('// Copyright: ',/descendant::copyright[1])"/>
<xsl:text>

</xsl:text>
</xsl:template>

<xsl:template name="COPYRIGHTPKG">
<xsl:text>
// Creator: PKG (C) 1999 ... 2020 A. Tenbusch, GNU General Public License
</xsl:text>
</xsl:template>


</xsl:stylesheet>
