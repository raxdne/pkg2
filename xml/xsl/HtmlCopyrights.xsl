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
  <xsl:template match="/">
    <html>
      <body>
        <table class="hidden" cellpadding="0" width="100%">
          <tr>
            <td>Petrinetz</td>
            <td>
              <a href="info.html">
                <xsl:value-of select="descendant::section[1]/h"/>
              </a>
            </td>
            <td rowspan="4" align="right" valign="top">
              <a class="ui" style="font-weight:normal;font-style:italic;" href="{descendant::author/@href}">Seite kommentieren</a>
            </td>
          </tr>
          <tr>
            <td>Version</td>
            <td>
              <xsl:value-of select="descendant::section[1]/@version"/>
            </td>
          </tr>
          <tr>
            <td>Kontakt</td>
            <td>
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="descendant::author/@href"/>
                </xsl:attribute>
                <xsl:value-of select="descendant::author"/>
              </xsl:element>
            </td>
          </tr>
          <tr>
            <td>Copyright</td>
            <td>
              <xsl:value-of select="descendant::copyright"/>
            </td>
          </tr>
        </table>
        <p><a href="http://pkg2.tenbusch.info/">PKG2 (C) 1999 ... 2020 A. Tenbusch</a>, GNU General Public License</p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
