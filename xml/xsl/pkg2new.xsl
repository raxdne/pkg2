<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:pie="http://www.tenbusch.info/pie"
  xmlns:pkg="http://www.tenbusch.info/pkg">

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

  <xsl:output method="xml" encoding="UTF-8"/>  

  <!-- ignore all elements with a lost IDREF's -->

  <xsl:template match="node()">
    <xsl:choose>
      <!--  -->
      <xsl:when test="self::PETRINET">
        <xsl:element name="pie:pie">
          <xsl:attribute name="lang">de</xsl:attribute>
          <xsl:attribute name="class">petrinet</xsl:attribute>
          <xsl:apply-templates select="CONTACT|COPYRIGHT" /> 
          <xsl:element name="section">
            <xsl:apply-templates select="@*|*|comment()|processing-instruction()" /> 
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::SUBNET">
<!--
        <xsl:element name="section">
          <xsl:copy-of select="@*[not(name())='FILE']"/>
          <xsl:if test="@FILE">
          <xsl:element name="import">
            <xsl:attribute name="name">
              <xsl:value-of select="@FILE"/>
            </xsl:attribute>
            <xsl:attribute name="type">xml</xsl:attribute>
          </xsl:element>
          <xsl:apply-templates select="document(@FILE)/PETRINET" /> 
          </xsl:if>
          <xsl:apply-templates select="*|comment()|processing-instruction()" /> 
        </xsl:element>
-->
        <xsl:choose>
          <xsl:when test="@FILE">
            <xsl:element name="section">
              <xsl:apply-templates select="document(@FILE)/PETRINET/SUBNET/@*"/>
              <xsl:apply-templates select="document(@FILE)/PETRINET/SUBNET/*" /> 
            </xsl:element>
          </xsl:when>
          <xsl:when test="@ID">
            <xsl:element name="section">
              <xsl:apply-templates select="@*|*|comment()|processing-instruction()" /> 
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="self::KATALOG">
        <xsl:element name="section">
          <xsl:attribute name="class">requirements</xsl:attribute>
          <xsl:apply-templates select="document(@FILE)/PETRINET/KATALOG/*" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::GRUPPE">
        <xsl:element name="section">
          <xsl:apply-templates select="@*|*|comment()|processing-instruction()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::RELATION">
        <xsl:element name="pkg:relation">
          <xsl:apply-templates select="@*|*|comment()|processing-instruction()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::NAME">
        <xsl:element name="h">
          <xsl:choose>
            <xsl:when test="string-length(normalize-space(.)) &gt; 0">
              <xsl:apply-templates select="text()" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="../@ID"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::FORM or self::TOOL">
        <xsl:element name="p">
          <xsl:apply-templates/> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::STELLE">
        <xsl:element name="pkg:stelle">
          <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" />
          <xsl:if test="not(child::NAME)">
            <xsl:element name="h">
              <xsl:value-of select="normalize-space(attribute::ID)"/>
            </xsl:element>
          </xsl:if>
          <!--
          <xsl:element name="fig">
            <xsl:element name="img">
              <xsl:attribute name="src">
                <xsl:value-of select="concat(@ID,'.png')"/>
              </xsl:attribute>
            </xsl:element>
          </xsl:element>
          -->
          <xsl:element name="import">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('man/',@ID,'.txt')"/>
            </xsl:attribute>
          </xsl:element>
          <!--
          <xsl:element name="import">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('tmp/',@ID,'.txt')"/>
            </xsl:attribute>
          </xsl:element>
          -->
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::TRANSITION">
        <xsl:element name="pkg:transition">
          <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" />
          <xsl:if test="not(child::NAME)">
            <xsl:element name="h">
              <xsl:value-of select="normalize-space(attribute::ID)"/>
            </xsl:element>
          </xsl:if>
          <!--
          <xsl:copy-of select="make"/>
          <xsl:element name="fig">
            <xsl:element name="img">
              <xsl:attribute name="src">
                <xsl:value-of select="concat(@ID,'.png')"/>
              </xsl:attribute>
            </xsl:element>
          </xsl:element>
          -->
          <xsl:element name="import">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('man/',@ID,'.txt')"/>
            </xsl:attribute>
          </xsl:element>
          <!--
          <xsl:element name="import">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('tmp/',@ID,'.txt')"/>
            </xsl:attribute>
          </xsl:element>
          -->
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::DESCRIPTION">
        <xsl:if test="string-length(normalize-space(.)) &gt; 0">
          <xsl:element name="abstract">
            <xsl:apply-templates/> 
          </xsl:element>
        </xsl:if>
      </xsl:when>
      <xsl:when test="self::REQUIREMENT">
        <xsl:element name="pkg:requirement">
            <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" /> 
          <xsl:element name="import">
            <xsl:attribute name="name">
              <xsl:value-of select="concat('man/',@ID,'.txt')"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::REQ">
        <xsl:element name="pkg:req">
            <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::CHECK">
        <xsl:element name="pkg:check">
            <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::COPYRIGHT">
        <xsl:element name="copyright">
            <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::CONTACT">
        <xsl:element name="author">
            <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" /> 
        </xsl:element>
      </xsl:when>
      <xsl:when test="self::LINK">
        <xsl:element name="p">
          <xsl:element name="link">
            <xsl:apply-templates select="@*|*|text()|comment()|processing-instruction()" /> 
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()|text()|comment()|processing-instruction()" /> 
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:attribute name="{translate(name(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ -/()+','abcdefghijklmnopqrstuvwxyz___')}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:if test="string-length(normalize-space(.)) &gt; 0">
      <xsl:value-of select="."/>
      <xsl:element name="translation">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:value-of select="."/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()">
    <xsl:copy-of select="."/>
  </xsl:template>
      
</xsl:stylesheet>
