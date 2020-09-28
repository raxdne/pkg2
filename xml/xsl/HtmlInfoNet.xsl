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
  <xsl:output method="html"/>
  <xsl:template match="/">
    <html>
      <body>
        <table border="0" cellspacing="1" cellpadding="2">
          <tbody>
            <tr>
              <th>Netz</th>
              <th>
                <xsl:value-of select="child::*[1]/section[1]/h"/>
              </th>
            </tr>
            <tr>
              <th>Element-Typ</th>
              <th>Element-Anzahl</th>
            </tr>
            <tr>
              <th>Subnetze</th>
              <td align="right">
                <xsl:value-of select="count(//section[@id])"/>
              </td>
            </tr>
            <tr>
              <th>Modelle</th>
              <td align="right">
                <xsl:value-of select="count(//pkg:stelle)"/>
              </td>
            </tr>
            <tr>
              <th>Prozesse</th>
              <td align="right">
                <xsl:value-of select="count(//pkg:transition)"/>
              </td>
            </tr>
            <tr>
              <th>Relationen</th>
              <td align="right">
                <xsl:value-of select="count(//pkg:relation)"/>
              </td>
            </tr>
            <tr>
              <th>Anforderungen</th>
              <td align="right">
                <xsl:value-of select="count(//pkg:requirement)"/>
              </td>
            </tr>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
