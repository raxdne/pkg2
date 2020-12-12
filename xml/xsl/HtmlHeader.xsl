<?xml version="1.0" encoding="UTF-8"?>
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
  <xsl:output method="html" encoding="UTF-8"/>
  <xsl:variable name="str_prefix" select="''"/>
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" media="screen, print" type="text/css" href="{concat($str_prefix,'pkg2.css')}"/>
        <!-- problems with IE 6 if element is empty -->
        <script src="{concat($str_prefix,'pkg2-tools.js')}" type="text/javascript">// </script>
        <title>
          <xsl:value-of select="descendant::section[1]/h"/>
        </title>
      </head>
    </html>
  </xsl:template>
</xsl:stylesheet>
