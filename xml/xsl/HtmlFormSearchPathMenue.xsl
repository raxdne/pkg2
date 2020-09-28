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
	<xsl:variable name="str_prefix" select="''"/>

  <xsl:output method="html"/>

<xsl:template match="/">
  <html>
    <body>
      <!-- <script type="text/javascript" src="/cxproc/exe?file=main.xml&amp;xsl=PlainJsArray">#</script> -->

  <form method="post" action="/Pkg2Search.cxp">
    <input type="hidden" name="file" value="main.xml"/>
    <input type="hidden" name="removed" value=""/>
  <table class="hidden" cellspacing="1" cellpadding="5" width="100%">
    <tbody>
      <tr>
        <th colspan="3">
          <xsl:text>Start-Modell </xsl:text>
          <select name="start" size="1">
            <option value=""/>
            <xsl:for-each select="//pkg:stelle[@id]">
              <xsl:element name="option">
                <xsl:attribute name="value">
                  <xsl:value-of select="@id"/>
                </xsl:attribute>
                  <xsl:value-of select="h"/>
                </xsl:element>
              </xsl:for-each>
            </select>
            <xsl:text> Ziel-Modell </xsl:text>
            <select name="target" size="1">
              <option value=""/>
              <xsl:for-each select="//pkg:stelle[@id]">
                <xsl:element name="option">
                  <xsl:attribute name="value">
                    <xsl:value-of select="@id"/>
                  </xsl:attribute>
                  <xsl:value-of select="h"/>
                </xsl:element>
              </xsl:for-each>
            </select>
            <input type="button" onclick="getChildsInactive()" name="mode" value="Suche"/>
			<!--
            <input type="submit" name="mode" value="Graph"/>
            <input type="submit" name="mode" value="XML"/>
            <input type="submit" name="mode" value="XSL"/>
			-->
            <input type="reset" value="Reset"/>
          </th>
        </tr>

        <tr>
          <th colspan="3">
            <input name="l_min" type="text" size="2" maxlength="2"/>
            &lt; Laenge &lt;=
            <input name="l_max" type="text" size="2" maxlength="2" value="7"/>
          </th>
        </tr>

        <tr>
          <td colspan="3">Bitte waehlen Sie die auszuschliessenden
          <!--
          <select name="policy" size="1">
            <option value="include">auszuschliessenden</option>
            <option value="exclude">einzuschliessenden</option>
          </select>
          -->
          Elemente an!</td>
        </tr>

        <tr>
          <td valign="top">
            <table class="hidden">
              <tbody>
                <tr>
                  <th colspan="1">Subnetze</th>
                </tr>
                <xsl:apply-templates select="//section[@id and not(descendant::pkg:requirement)]"/>
              </tbody>
            </table>
          </td>

          <td valign="top">
            <table class="hidden">
              <tbody>
                <tr>
                  <th colspan="1">Modelle</th>
                </tr>
                <xsl:apply-templates select="//pkg:stelle[@id]"/>
              </tbody>
            </table>
          </td>

          <td valign="top">
            <table class="hidden">
              <tbody>
                <tr>
                  <th colspan="1">Prozesse</th>
                </tr>
                <xsl:apply-templates select="//pkg:transition[@id]"/>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
    </body>
  </html>
</xsl:template>


<xsl:template match="section|pkg:stelle|pkg:transition">
  <tr>
    <td>
      <xsl:element name="input">
        <xsl:attribute name="type">checkbox</xsl:attribute>
        <xsl:attribute name="name">
          <xsl:choose>
            <xsl:when test="self::pkg:stelle">state</xsl:when>
            <xsl:when test="self::pkg:transition">transition</xsl:when>
            <xsl:otherwise>subnet</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:if test="self::section">
          <xsl:attribute name="onchange">
            <xsl:text>setChildsInactive('</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>')</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:attribute name="value">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:element>

      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="concat($str_prefix,@id,'.html')"/>
        </xsl:attribute>
        <xsl:value-of select="h"/>
      </xsl:element>
    </td>
  </tr>
</xsl:template>

</xsl:stylesheet>
