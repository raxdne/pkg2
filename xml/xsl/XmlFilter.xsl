<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg" version="1.0">
  <xsl:variable name="str_filter" select="''"/>
  <xsl:output method="xml" encoding="ISO-8859-1"/>
  <xsl:template match="@*|node()">
    <xsl:choose>
      <!-- knoten und netze -->
      <xsl:when test="contains($str_filter,concat(':',@id,':'))"/>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
