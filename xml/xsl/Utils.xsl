<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg" version="1.0">

<xsl:variable name="tabulator">
  <xsl:text>	</xsl:text>
</xsl:variable>

<xsl:variable name="newline">
<!-- a newline xsl:text element -->
<xsl:text>
</xsl:text>
</xsl:variable>

<xsl:variable name="newpar">
<xsl:text>

</xsl:text>
</xsl:variable>

<!-- template that actually does the conversion 
     http://www.xmlpitstop.com/XMLJournal/Article6-November2001/sourcecode/Q3-RecursionExamples/LineFeed_to_br/LF_to_BR.xsl
-->
<xsl:template name="lf2br">
  <!-- import $StringToTransform -->
  <xsl:param name="StringToTransform"/>
  <xsl:choose>
    <!-- string contains linefeed -->
    <xsl:when test="contains($StringToTransform,'&#xA;')">
      <!-- output substring that comes before the first linefeed -->
      <!-- note: use of substring-before() function means        -->
      <!-- $StringToTransform will be treated as a string,       -->
      <!-- even if it is a node-set or result tree fragment.     -->
      <!-- So hopefully $StringToTransform is really a string!   -->
      <xsl:value-of select="substring-before($StringToTransform,'&#xA;')"/>
      <!-- by putting a 'br' element in the result tree instead  -->
      <!-- of the linefeed character, a <br> will be output at   -->
      <!-- that point in the HTML                                -->
      <xsl:choose>
        <xsl:when test="false() and contains($StringToTransform,'-')">
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <!-- repeat for the remainder of the original string -->
      <xsl:call-template name="lf2br">
        <xsl:with-param name="StringToTransform">
          <xsl:value-of select="substring-after($StringToTransform,'&#xA;')"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <!-- string does not contain newline, so just output it -->
    <xsl:otherwise>
      <xsl:value-of select="$StringToTransform"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

  <xsl:template name="FORMATTASKPREFIX">
    <xsl:choose>
      <xsl:when test="@state = 'done'">
	<xsl:value-of select="concat('DONE: ','')"/>
      </xsl:when>
      <xsl:when test="@class">
        <xsl:value-of select="concat(translate(@class,'todnreqabugs','TODNREQABUGS'),': ')"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="concat('TODO: ','')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="FORMATTASK">
    <xsl:call-template name="FORMATTASKPREFIX"/>
    <xsl:apply-templates select="h"/>
  </xsl:template>

  <xsl:template name="DATESTRING">
    <xsl:choose>
      <xsl:when test="@done = '1'">
	  <xsl:text> ✔ </xsl:text>
      </xsl:when>
      <xsl:when test="ancestor-or-self::*[@done]">
	<xsl:value-of select="concat(ancestor-or-self::*[@done][1]/@done,' ✔ ')"/>
      </xsl:when>
      <xsl:when test="ancestor-or-self::*[@date]">
	<xsl:value-of select="concat(ancestor-or-self::*[@date][1]/@date,' ')"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="FORMATIMPACT">
    <!--  -->
    <xsl:choose>
      <xsl:when test="@impact='1'">
	<xsl:text> +++</xsl:text>
      </xsl:when>
      <xsl:when test="@impact='2'">
	<xsl:text> ++</xsl:text>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MIMETYPE">
    <!-- converts MIME type string into RFC 1738 format -->
    <xsl:param name="str_type"/>
    <xsl:choose>
      <xsl:when test="contains($str_type,'+') and contains(substring-after($str_type,'+'),'+')"> <!-- two '+' -->
        <xsl:value-of select="concat(substring-before($str_type,'+'),'%2B',substring-before(substring-after($str_type,'+'),'+'),'%2B',substring-after(substring-after($str_type,'+'),'+'))"/>
      </xsl:when>
      <xsl:when test="contains($str_type,'+')"> <!-- single '+' -->
        <xsl:value-of select="concat(substring-before($str_type,'+'),'%2B',substring-after($str_type,'+'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$str_type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
