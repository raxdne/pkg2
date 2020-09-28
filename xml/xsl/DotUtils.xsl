<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg" version="1.0">

  <xsl:output method='text' encoding='ISO-8859-1'/>

<xsl:variable name="tabulator">
  <xsl:text>	</xsl:text>
</xsl:variable>

<xsl:variable name="newline">
<!-- a newline xsl:text element -->
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
    <!-- string contains minus char -->
    <xsl:when test="contains($StringToTransform,'-')">
      <!-- output substring that comes before the first linefeed -->
      <!-- note: use of substring-before() function means        -->
      <!-- $StringToTransform will be treated as a string,       -->
      <!-- even if it is a node-set or result tree fragment.     -->
      <!-- So hopefully $StringToTransform is really a string!   -->
      <xsl:value-of select="substring-before($StringToTransform,'-')"/>
      <!-- by putting a 'br' element in the result tree instead  -->
      <!-- of the linefeed character, a <br> will be output at   -->
      <!-- that point in the HTML                                -->
      <xsl:text>-\n</xsl:text>
      <!-- repeat for the remainder of the original string -->
      <xsl:call-template name="lf2br">
        <xsl:with-param name="StringToTransform">
          <xsl:value-of select="substring-after($StringToTransform,'-')"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <!-- string contains space char -->
    <xsl:when test="contains($StringToTransform,' ')">
      <!-- output substring that comes before the first linefeed -->
      <!-- note: use of substring-before() function means        -->
      <!-- $StringToTransform will be treated as a string,       -->
      <!-- even if it is a node-set or result tree fragment.     -->
      <!-- So hopefully $StringToTransform is really a string!   -->
      <xsl:value-of select="substring-before($StringToTransform,' ')"/>
      <!-- by putting a 'br' element in the result tree instead  -->
      <!-- of the linefeed character, a <br> will be output at   -->
      <!-- that point in the HTML                                -->
      <xsl:text>\n</xsl:text>
      <!-- repeat for the remainder of the original string -->
      <xsl:call-template name="lf2br">
        <xsl:with-param name="StringToTransform">
          <xsl:value-of select="substring-after($StringToTransform,' ')"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <!-- string does not contain newline, so just output it -->
    <xsl:otherwise>
      <xsl:value-of select="$StringToTransform"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
