<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pkg="http://www.tenbusch.info/pkg" version="1.0">
  <xsl:import href="Utils.xsl"/>
  <xsl:variable name="length_link" select="-1"/>
  <xsl:variable name="flag_fig" select="true()"/>
  <!--  -->
  <xsl:variable name="str_link_prefix" select="''"/>
  <xsl:template match="pie">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="author">
    <xsl:element name="center">
      <xsl:element name="i">
	<xsl:value-of select="."/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="block[@type = 'quote']">
    <xsl:element name="blockquote">
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
    <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="h">
    <xsl:copy-of select="@class"/>
    <xsl:call-template name="DATESTRING"/>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="htag">
    <xsl:element name="span">
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="tag|contact">
    <xsl:element name="div">
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:element name="span">
        <xsl:attribute name="class">
          <xsl:value-of select="name()"/>
        </xsl:attribute>
        <xsl:copy-of select="@class"/>
	<xsl:element name="a">
	  <xsl:attribute name="href">
	    <xsl:value-of select="concat('javascript:this.document.openTagged(','&quot;',.,'&quot;',')')"/>
	  </xsl:attribute>
          <xsl:value-of select="."/>
	</xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="section">
    <xsl:variable name="int_ancestors" select="count(ancestor-or-self::section)"/>
    <xsl:element name="section">
      <xsl:call-template name="CLASSATRIBUTE"/>
      <xsl:if test="@xpath">
	<xsl:attribute name="id">
	  <xsl:value-of select="translate(@xpath,'/*[]','_')"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="h">
	<xsl:element name="div">
	  <xsl:attribute name="class">
	    <xsl:text>header</xsl:text>
	  </xsl:attribute>
	  <xsl:element name="{concat('h',$int_ancestors)}">
	    <xsl:call-template name="ADDSTYLE"/>
	    <xsl:if test="@name">
	      <xsl:element name="a">
		<xsl:copy-of select="@name"/>
	      </xsl:element>
	    </xsl:if>
	    <xsl:element name="span">
	      <xsl:call-template name="MENUSET"/>
	      <xsl:element name="a"> <!-- target for link in ToC -->
	        <xsl:attribute name="name">
		  <xsl:value-of select="generate-id(.)"/>
		</xsl:attribute>
		<xsl:choose>
		  <xsl:when test="h/@hidden &gt; 0">
		    <xsl:element name="i">
		      <xsl:apply-templates select="h"/>
		    </xsl:element>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:apply-templates select="h"/>
		  </xsl:otherwise>
		</xsl:choose>
	      </xsl:element>
	    </xsl:element>
	  </xsl:element>
	</xsl:element>
      </xsl:if>
      <xsl:choose>
	<xsl:when test="$int_ancestors = 1">
	  <!-- TODO: use a variable for block level -->
	  <xsl:element name="div">
	    <xsl:attribute name="class">block</xsl:attribute>
	    <xsl:apply-templates select="*[not(name(.) = 'h')]"/>
	  </xsl:element>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates select="*[not(name(.) = 'h')]"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  <xsl:template match="task|_target">
    <xsl:choose>
      <xsl:when test="name(parent::node()) = 'list'">
	<!-- list item -->
	<xsl:element name="li">
	  <xsl:call-template name="TASK"/>
	</xsl:element>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="TASK"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="section[@class='slide']">
    <!-- slide section -->
    <xsl:element name="center">
      <xsl:element name="table">
	<xsl:attribute name="class">
	  <xsl:value-of select="name(.)"/>
	</xsl:attribute>
	<xsl:attribute name="border">
	  <xsl:text>0</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="cellspacing">
	  <xsl:text>1</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="width">
	  <xsl:text>80%</xsl:text>
	</xsl:attribute>
	<xsl:element name="tbody">
	  <xsl:element name="tr">
	    <xsl:element name="td">
	      <xsl:attribute name="align">center</xsl:attribute>
	      <xsl:element name="b">
		<xsl:element name="a">
		  <xsl:call-template name="ADDSTYLE"/>
		  <xsl:attribute name="name">
		    <xsl:value-of select="generate-id(.)"/>
		  </xsl:attribute>
		  <xsl:value-of select="h"/>
		</xsl:element>
	      </xsl:element>
	    </xsl:element>
	  </xsl:element>
	  <xsl:element name="tr">
	    <xsl:element name="td">
	      <xsl:attribute name="align">left</xsl:attribute>
	      <xsl:apply-templates select="*[not(name(.) = 'h')]"/>
	    </xsl:element>
	  </xsl:element>
	</xsl:element>
      </xsl:element>
      <xsl:if test="$flag_slidecap">
	<xsl:element name="p">
	  <xsl:element name="u">
	    <xsl:text>Folie:</xsl:text>
	  </xsl:element>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="h"/>
	</xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>
  <xsl:template match="_vcard">
    <!-- vcard -->
    <xsl:element name="table">
      <xsl:attribute name="class">
	<xsl:value-of select="name(.)"/>
      </xsl:attribute>
      <xsl:attribute name="border">
	<xsl:text>0</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="width">
	<xsl:text>40%</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="cellspacing">
	<xsl:text>1</xsl:text>
      </xsl:attribute>
      <xsl:element name="tbody">
	<xsl:element name="tr">
	  <xsl:element name="th">
	    <xsl:element name="a">
	      <xsl:attribute name="name">
		<xsl:value-of select="@id"/>
	      </xsl:attribute>
	      <xsl:if test="link">
		<xsl:attribute name="href">
		  <xsl:value-of select="link"/>
		</xsl:attribute>
	      </xsl:if>
	      <xsl:value-of select="concat(name,' ',firstname)"/>
	      <xsl:if test="title and not(title='')">
		<xsl:value-of select="concat(', ',title)"/>
	      </xsl:if>
	      <xsl:value-of select="concat(' (',@id,')')"/>
	    </xsl:element>
	    <xsl:if test="@idref">
	      <xsl:text>ref:</xsl:text>
	      <xsl:element name="a">
		<xsl:attribute name="href">
		  <xsl:value-of select="concat('#',@idref)"/>
		</xsl:attribute>
		<xsl:value-of select="@idref"/>
	      </xsl:element>
	    </xsl:if>
	  </xsl:element>
	</xsl:element>
	<xsl:element name="tr">
	  <xsl:element name="td">
	    <xsl:attribute name="align">
	      <xsl:text>right</xsl:text>
	    </xsl:attribute>
	    <xsl:element name="a">
	      <xsl:attribute name="href">
		<xsl:value-of select="concat('mailto:',mail/private)"/>
	      </xsl:attribute>
	      <xsl:value-of select="mail/private"/>
	    </xsl:element>
	    <xsl:element name="a">
	      <xsl:attribute name="href">
		<xsl:value-of select="concat('mailto:',mail/work)"/>
	      </xsl:attribute>
	      <xsl:value-of select="mail/work"/>
	    </xsl:element>
	  </xsl:element>
	</xsl:element>
	<xsl:element name="tr">
	  <xsl:element name="td">
	    <xsl:value-of select="concat('Tel. ',phone/private)"/>
	    <xsl:if test="phone/mobile">
	      <xsl:value-of select="concat(', ',phone/mobile)"/>
	    </xsl:if>
	    <xsl:if test="phone/work">
	      <xsl:value-of select="concat(', ',phone/work)"/>
	    </xsl:if>
	  </xsl:element>
	</xsl:element>
	<xsl:element name="tr">
	  <xsl:element name="td">
	    <xsl:element name="pre">
	      <xsl:choose>
		<xsl:when test="@gender='w'">
		  <xsl:text>Frau</xsl:text>
		</xsl:when>
		<xsl:when test="@gender='m'">
		  <xsl:text>Herrn</xsl:text>
		</xsl:when>
                <xsl:otherwise>
                </xsl:otherwise>
	      </xsl:choose>
	      <xsl:if test="title and not(title='')">
		<xsl:value-of select="concat(title,' ')"/>
	      </xsl:if>
	      <xsl:value-of select="concat(prefix,' ',firstname,' ',name,' ',additional,' ',suffix)"/>
	      <xsl:element name="br"/>
	      <xsl:value-of select="address/private"/>
	      <xsl:element name="br"/>
	      <xsl:value-of select="address/work"/>
	    </xsl:element>
	  </xsl:element>
	</xsl:element>
	<!--
	    <xsl:if test="p or list or img">
	    <xsl:element name="tr">
            <xsl:element name="td">
            <xsl:apply-templates select="p|list|img"/>
            </xsl:element>
	    </xsl:element>
	    </xsl:if>
	-->
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="list">
    <xsl:if test="child::*[not(@hidden) or @hidden &lt;= $level_hidden]">
      <xsl:choose>
	<xsl:when test="@enum = 'yes' or child::p[@enum = 'yes']">
	  <!-- enumerated list -->
	  <xsl:choose>
	    <xsl:when test="parent::list">
	      <xsl:element name="li"> <!-- create an hidden item for child list -->
		<xsl:attribute name="style">
		  <xsl:text>list-style-type: none;</xsl:text>
		</xsl:attribute>
		<xsl:if test="preceding-sibling::*[position() = 1 and name() = 'p' and @state = 'done']">
		  <xsl:attribute name="class">
		    <xsl:text>done</xsl:text>
		  </xsl:attribute>
		</xsl:if>
		<xsl:element name="ol">
		  <xsl:apply-templates/>
		</xsl:element>
	      </xsl:element>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:element name="ol">
		<xsl:apply-templates/>
	      </xsl:element>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:choose>
	    <xsl:when test="parent::list">
	      <xsl:element name="li"> <!-- create an hidden item for child list -->
		<xsl:attribute name="style">
		  <xsl:text>list-style-type: none;</xsl:text>
		</xsl:attribute>
		<xsl:if test="preceding-sibling::*[position() = 1 and name() = 'p' and @state = 'done']">
		  <xsl:attribute name="class">
		    <xsl:text>done</xsl:text>
		  </xsl:attribute>
		</xsl:if>
		<xsl:element name="ul">
		  <xsl:apply-templates/>
		</xsl:element>
	      </xsl:element>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:element name="ul">
		<xsl:if test="preceding-sibling::*[position() = 1 and name() = 'p' and @state = 'done']">
		  <xsl:attribute name="class">
		    <xsl:text>done</xsl:text>
		  </xsl:attribute>
		</xsl:if>
		<xsl:apply-templates/>
	      </xsl:element>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template match="link">
    <xsl:param name="target" select="'mainframe'"/>
    <xsl:element name="a">
    <xsl:copy-of select="@class"/>
    <xsl:if test="@href">
	<xsl:attribute name="target">
          <xsl:choose>
            <xsl:when test="@target">
              <xsl:value-of select="@target"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$target"/>
            </xsl:otherwise>
          </xsl:choose>
	</xsl:attribute>
	<xsl:copy-of select="@href"/>
      </xsl:if>
      <xsl:choose>
	<xsl:when test=". = @href and $length_link &gt; 0 and string-length(.) &gt; $length_link">
	  <xsl:value-of select="concat(substring(.,1,$length_link),'...')"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  <xsl:template match="translation">
    <!-- ignore -->
  </xsl:template>
  <xsl:template match="abstract">
    <xsl:element name="p">
      <xsl:attribute name="class">
	<xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="span">
    <xsl:copy-of select="@class"/>
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="b|u|i|date">
    <!-- map former elements to span -->
    <xsl:element name="span">
      <xsl:attribute name="class">
	<xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="em|strong|tt">
    <xsl:element name="{name()}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="p">
    <xsl:if test="@name">
      <xsl:element name="a">
	<xsl:copy-of select="@name"/>
      </xsl:element>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="parent::list">
	<!-- list item -->
	<xsl:choose>
	  <xsl:when test="not(@hidden)">
	    <!-- simple paragraph -->
	    <xsl:element name="li">
	      <xsl:call-template name="CLASSATRIBUTE"/>
	      <xsl:call-template name="ADDSTYLE"/>
	      <xsl:if test="parent::list[@enum = 'yes']">
		<xsl:attribute name="value">
		  <xsl:value-of select="count(preceding-sibling::p) + 1"/>
		</xsl:attribute>
	      </xsl:if>
	      <xsl:apply-templates/>
	      <xsl:call-template name="FORMATIMPACT"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:when test="@hidden &lt;= $level_hidden">
	    <!-- hidden paragraph -->
	    <xsl:element name="li">
	      <xsl:attribute name="class">hidden</xsl:attribute>
	      <xsl:apply-templates/>
	      <xsl:call-template name="FORMATIMPACT"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:otherwise>
	    <!-- really hidden paragraph -->
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:otherwise>
	<xsl:choose>
	  <xsl:when test="not(@hidden)">
	    <!-- simple paragraph -->
	    <xsl:element name="p">
	      <xsl:call-template name="CLASSATRIBUTE"/>
	      <xsl:call-template name="ADDSTYLE"/>
	      <xsl:apply-templates/>
	      <xsl:call-template name="FORMATIMPACT"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:when test="@hidden &lt;= $level_hidden">
	    <!-- hidden paragraph -->
	    <xsl:element name="p">
	      <xsl:attribute name="class">hidden</xsl:attribute>
	      <xsl:apply-templates/>
	      <xsl:call-template name="FORMATIMPACT"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:otherwise>
	    <!-- really hidden paragraph -->
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="pre">
    <xsl:element name="pre">
      <xsl:element name="code">
	<xsl:copy-of select="text()"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="hr">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="img">
    <xsl:if test="@src">
      <xsl:element name="a">
	<xsl:attribute name="name">
	  <xsl:value-of select="@src"/>
	</xsl:attribute>
      </xsl:element>
    </xsl:if>
    <xsl:element name="{name()}">
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="class">
	<xsl:value-of select="'localsize'"/>
      </xsl:attribute>
      <xsl:attribute name="title">
	<xsl:value-of select="@src"/>
      </xsl:attribute>
	<xsl:attribute name="alt">
	<xsl:choose>
	  <xsl:when test="parent::fig/child::h">
	    <xsl:value-of select="parent::fig/child::h"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@src"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      <xsl:choose>
	<xsl:when test="$str_link_prefix='' or starts-with(@src,'?') or starts-with(@src,'http://') or starts-with(@src,'https://') or starts-with(@src,'ftp://')">
	  <!-- use @src -->
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="src">
	    <xsl:value-of select="concat($str_link_prefix,'/',@src)"/>
	  </xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  <xsl:template name="TABLEHEADER">
    <!--  -->
    <xsl:param name="numRows" select="-1"/>
    <xsl:param name="numRowMax" select="-1"/>
    <!--
    <xsl:comment>
      <xsl:value-of select="concat(' numRows = ',$numRows,', numRowMax = ',$numRowMax,' ')"/>
      </xsl:comment>
      -->
    <xsl:choose>
      <xsl:when test="$numRows = 0"> <!-- end of list -->
	<xsl:element name="thead">
	  <xsl:element name="tr">
	    <xsl:element name="th">
	      <xsl:text>&#x2800;</xsl:text>
	    </xsl:element>
	    <xsl:for-each select="child::tr[position() = $numRowMax]/child::td">
	      <xsl:element name="th">
		<xsl:value-of select="position()"/>
	      </xsl:element>
	    </xsl:for-each>
	  </xsl:element>
	</xsl:element>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="TABLEHEADER"> <!-- recursion -->
	  <xsl:with-param name="numRows">
	    <xsl:choose>
	      <xsl:when test="$numRows &lt; 0">
		<xsl:value-of select="count(child::tr)"/> <!-- initial value -->
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="$numRows - 1"/> <!-- decrement value -->
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:with-param>
	  <xsl:with-param name="numRowMax">
	    <xsl:choose>
	      <xsl:when test="$numRows &lt; 0">
		<xsl:value-of select="count(child::tr)"/> <!-- initial value, last child -->
	      </xsl:when>
	      <xsl:when test="$numRowMax &lt; 0">
		<xsl:value-of select="$numRows"/> <!-- initial value -->
	      </xsl:when>
	      <xsl:when test="count(child::tr[position() = $numRowMax]/child::td) &lt; count(child::tr[position() = $numRows]/child::td)">
		<xsl:value-of select="$numRows"/> <!-- new maximum -->
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="$numRowMax"/> <!-- keep max value -->
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="table">
    <xsl:element name="center">
      <xsl:element name="table">
	<xsl:attribute name="id">
	  <xsl:text>localTable</xsl:text> <!-- TODO: handle multiple tables -->
	</xsl:attribute>
	<xsl:attribute name="class">
	  <xsl:text>tablesorter</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="border">
	  <xsl:text>1</xsl:text>
	</xsl:attribute>
	<xsl:copy-of select="@*"/>
	<xsl:attribute name="width">90%</xsl:attribute>
	<xsl:choose>
	  <xsl:when test="thead">
	    <!-- OK -->
	    <xsl:copy-of select="*[not(name()='t')]"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:call-template name="TABLEHEADER"/>
	    <tbody>
	      <xsl:for-each select="tr">
		<xsl:element name="{name()}">
		  <xsl:element name="th">
		    <xsl:value-of select="position()"/>
		  </xsl:element>
		  <xsl:for-each select="td|th">
		    <xsl:element name="{name()}">
		      <xsl:copy-of select="@*"/>
		      <xsl:apply-templates select="*|text()"/>
		    </xsl:element>
		  </xsl:for-each>
		</xsl:element>
	      </xsl:for-each>
	    </tbody>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="fig">
    <xsl:if test="$flag_fig and child::*">
      <xsl:choose>
	<xsl:when test="not(@hidden) or @hidden &lt;= $level_hidden">
	  <!-- normal figure -->
	  <xsl:element name="center">
	    <xsl:apply-templates select="img"/>
	    <xsl:if test="h">
	      <xsl:element name="p">
	      <xsl:call-template name="CLASSATRIBUTE"/>
		<xsl:element name="u">
		  <xsl:text>Fig.:</xsl:text>
		</xsl:element>
		<xsl:text> </xsl:text>
		<xsl:for-each select="child::h">
		  <xsl:apply-templates select="*|text()"/>
		</xsl:for-each>
	      </xsl:element>
	    </xsl:if>
	  </xsl:element>
	</xsl:when>
	<xsl:otherwise>
	  <!--  -->
	  <xsl:if test="h">
	    <xsl:element name="p">
	      <xsl:attribute name="class">hidden</xsl:attribute>
	      <xsl:element name="u">
		<xsl:text>Fig.:</xsl:text>
	      </xsl:element>
	      <xsl:text> </xsl:text>
	      <xsl:for-each select="child::h">
		<xsl:apply-templates select="*|text()"/>
	      </xsl:for-each>
	    </xsl:element>
	  </xsl:if>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template name="LISTCSS">
    <xsl:param name="list_css" select="''"/>
    <xsl:choose>
      <xsl:when test="$list_css=''">
	<!-- ignore empty -->
      </xsl:when>
      <xsl:when test="contains($list_css,',')">
	<xsl:call-template name="LISTCSS">
	  <xsl:with-param name="list_css">
	    <xsl:value-of select="substring-before($list_css,',')"/>
	  </xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="LISTCSS">
	  <xsl:with-param name="list_css">
	    <xsl:value-of select="substring-after($list_css,',')"/>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:element name="link">
	  <xsl:attribute name="rel">
	    <xsl:text>stylesheet</xsl:text>
	  </xsl:attribute>
	  <xsl:attribute name="media">
	    <xsl:text>screen, print</xsl:text>
	  </xsl:attribute>
	  <xsl:attribute name="type">
	    <xsl:text>text/css</xsl:text>
	  </xsl:attribute>
	  <xsl:attribute name="href">
	    <xsl:value-of select="$list_css"/>
	  </xsl:attribute>
	</xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="LISTJS">
    <xsl:param name="list_js" select="''"/>
    <xsl:choose>
      <xsl:when test="$list_js=''">
	<!-- ignore empty -->
      </xsl:when>
      <xsl:when test="contains($list_js,',')">
	<xsl:call-template name="LISTJS">
	  <xsl:with-param name="list_js">
	    <xsl:value-of select="substring-before($list_js,',')"/>
	  </xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="LISTJS">
	  <xsl:with-param name="list_js">
	    <xsl:value-of select="substring-after($list_js,',')"/>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:element name="script">
	  <xsl:attribute name="type">
	    <xsl:text>text/javascript</xsl:text>
	  </xsl:attribute>
	  <xsl:attribute name="src">
	    <xsl:value-of select="$list_js"/>
	  </xsl:attribute>
	  <xsl:text>// not empty!!!</xsl:text>
	</xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="HEADER">
    <xsl:param name="list_js" select="''"/>
    <xsl:element name="head">
      <xsl:element name="meta">
	<xsl:attribute name="name">
	  <xsl:text>generator</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="content">
	  <xsl:text>cxproc PIE/XML</xsl:text>
	</xsl:attribute>
      </xsl:element>
      <xsl:element name="meta">
	<xsl:attribute name="http-equiv">
	  <xsl:text>cache-control</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="content">
	  <xsl:text>no-cache</xsl:text>
	</xsl:attribute>
      </xsl:element>
      <xsl:element name="meta">
	<xsl:attribute name="http-equiv">
	  <xsl:text>pragma</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="content">
	  <xsl:text>no-cache</xsl:text>
	</xsl:attribute>
      </xsl:element>
      <!-- TODO: str_title -->
      <xsl:element name="title">
	<xsl:choose>
	  <xsl:when test="/pie/section/h">
	    <xsl:value-of select="/pie/section/h"/>
	  </xsl:when>
	  <xsl:when test="/map/node[@TEXT]">
	    <xsl:value-of select="/map/node/@TEXT"/>
	  </xsl:when>
	  <xsl:otherwise>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:element>
      <xsl:choose>
	<xsl:when test="$file_css = ''">
	  <xsl:call-template name="CREATESTYLE"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="LISTCSS">
	    <xsl:with-param name="list_css" select="$file_css"/>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="LISTJS">
	<xsl:with-param name="list_js" select="$list_js"/>
      </xsl:call-template>
     </xsl:element>
  </xsl:template>
  <xsl:template name="PIETAGCLOUD">
    <!--  -->
      <xsl:variable name="int_space" select="5"/>
      <xsl:element name="div">
	<xsl:attribute name="id">tags</xsl:attribute>
	<xsl:attribute name="style">display:none</xsl:attribute>
	<xsl:element name="p">
	  <xsl:element name="button">
	    <xsl:attribute name="id">tag_reset</xsl:attribute>
	    <xsl:attribute name="type">button</xsl:attribute>
	    <xsl:text>Reset Tags</xsl:text>
	  </xsl:element>
	  <xsl:element name="input">
	    <xsl:attribute name="type">text</xsl:attribute>
	    <xsl:attribute name="class">htag</xsl:attribute>
	    <xsl:attribute name="maxlength">25</xsl:attribute>
	    <xsl:attribute name="size">30</xsl:attribute>
	  </xsl:element>
	  <xsl:for-each select="pie/meta/t/t"> <!--  -->
	    <xsl:sort order="ascending" data-type="text" select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
	    <xsl:sort order="descending" data-type="number" select="@count"/>
	    <xsl:element name="span">
	      <xsl:attribute name="class">htag</xsl:attribute>
	      <xsl:if test="@count and @count &gt; 1">
                <xsl:variable name="int_counter">
                  <xsl:choose>
                    <xsl:when test="@count &gt; 9">
                      <!-- fixed max values -->
                      <xsl:value-of select="10"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="@count"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
		<xsl:attribute name="title">
                  <xsl:value-of select="concat(@count,' x ',.)"/>
                </xsl:attribute>
                <xsl:attribute name="style">
                  <xsl:value-of select="concat('font-size:',(80+$int_counter*10),'%;')"/>
                  <xsl:value-of select="concat('margin:',($int_counter*$int_space),'px ',($int_counter*$int_space),'px ',($int_counter*$int_space),'px ',($int_counter*$int_space),'px ',';')"/>
                </xsl:attribute>
	      </xsl:if>
	      <xsl:value-of select="."/>
	    </xsl:element>
	    <xsl:text> </xsl:text>
	  </xsl:for-each>
	</xsl:element>
	<!-- -->
	<xsl:element name="p">
	  <xsl:attribute name="style">text-align:right</xsl:attribute>
	  <xsl:element name="i">
	    <xsl:text>&lt;CRTL&gt; include/add tags (OR); &lt;ALT&gt; combine tags (AND); &lt;SHIFT&gt; exclude/subtract tags</xsl:text>
	  </xsl:element>
	</xsl:element>
	<!--
	    <xsl:if test="string-length($str_tag) &gt; 0">
	    <hr/>
	    <xsl:element name="dl">
	    <xsl:element name="dt">
	    <xsl:element name="a">
            <xsl:attribute name="name">result</xsl:attribute>
            <xsl:for-each select="pie/meta/t//word[contains(.,$str_tag)]">
	    <xsl:value-of select="concat(.,' ')"/>
            </xsl:for-each>
	    </xsl:element>
	    </xsl:element>
	    <xsl:for-each select="descendant::text()[not(name(parent::node())='word') and contains(.,$str_tag)]">
	    <xsl:element name="dt">
            <xsl:for-each select="ancestor::node()">
	    <xsl:choose>
	    <xsl:when test="name(.)='pie'"/>
	    <xsl:when test="name(.)='section'">
	    <xsl:value-of select="concat(' / ',h)"/>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:value-of select="concat(' / ',name(.))"/>
	    </xsl:otherwise>
	    </xsl:choose>
            </xsl:for-each>
	    </xsl:element>
	    <xsl:element name="dd">
            <xsl:call-template name="TAGMARKUP">
	    <xsl:with-param name="str_mark">
	    <xsl:value-of select="."/>
	    </xsl:with-param>
            </xsl:call-template>
	    </xsl:element>
	    </xsl:for-each>
	    </xsl:element>
	    </xsl:if>
	-->
	<hr/>
      </xsl:element>
  </xsl:template>
  <xsl:template match="script">
    <!--  -->
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template name="PIETOC">
    <xsl:param name="display" select="block"/>
    <xsl:if test="count(//section[child::h and not(ancestor::section[@valid='no'])]) &gt; 3">
<!--
      <xsl:element name="a">
	<xsl:attribute name="href">
	  <xsl:text>javascript:this.document.switchDisplay('toc')</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="title">
	  <xsl:text>Show Table of Contents</xsl:text>
	</xsl:attribute>
	<xsl:text>toc</xsl:text>
      </xsl:element>
      <xsl:text> </xsl:text>
-->
      <xsl:element name="pre">
	<xsl:attribute name="id">toc</xsl:attribute>
	<xsl:attribute name="style">
	  <xsl:value-of select="concat('display:',$display)"/>
	</xsl:attribute>
	<xsl:for-each select="//section[h and not(ancestor-or-self::section[@valid='no']) and not(ancestor::meta)]">
	  <xsl:for-each select="ancestor::section[h]">
	    <xsl:text>   </xsl:text>
	  </xsl:for-each>
	  <xsl:element name="a">
	    <xsl:attribute name="href">
	      <xsl:value-of select="concat('#',generate-id(.))"/>
	    </xsl:attribute>
	    <xsl:value-of select="normalize-space(h)"/>
	  </xsl:element>
	  <xsl:value-of select="$newline"/>
	</xsl:for-each>
	<hr/>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template name="PIELINKLIST">
    <xsl:if test="count(//link[not(ancestor::*[@valid='no']) and string-length(@href) &gt; 4]) &gt; 1">
<!--
      <hr/>
      <xsl:element name="a">
	<xsl:attribute name="href">
	  <xsl:text>javascript:this.document.switchDisplay('links')</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="title">
	  <xsl:text>Show List of Links</xsl:text>
	</xsl:attribute>
	<xsl:text>links</xsl:text>
      </xsl:element>
      <xsl:text> </xsl:text>
-->
      <xsl:element name="div">
	<xsl:attribute name="id">links</xsl:attribute>
	<xsl:attribute name="style">display:none</xsl:attribute>
	<xsl:element name="h2">Link list</xsl:element>
	<xsl:element name="ol">
	  <xsl:for-each select="//link[not(ancestor::*[@valid='no']) and string-length(@href) &gt; 4]">
	    <xsl:element name="li">
	      <xsl:element name="a">
		<xsl:attribute name="href">
		  <xsl:choose>
		    <xsl:when test="starts-with(@href,'\\')">
		      <xsl:value-of select="concat('file://',@href)"/>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:value-of select="@href"/>
		    </xsl:otherwise>
		  </xsl:choose>
		</xsl:attribute>
		<xsl:value-of select="@href"/>
	      </xsl:element>
	      <xsl:element name="br"/>
	      <xsl:element name="i">
		<xsl:text>(</xsl:text>
		<xsl:for-each select="ancestor::section">
		  <xsl:if test="position() &gt; 1">
		    <xsl:text>::</xsl:text>
		  </xsl:if>
		  <xsl:value-of select="h"/>
		</xsl:for-each>
		<xsl:text>)</xsl:text>
	      </xsl:element>
	    </xsl:element>
	  </xsl:for-each>
	</xsl:element>
	<hr/>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template name="TAGMARKUP">
    <xsl:param name="str_mark"/>
    <xsl:variable name="str_tail" select="substring-after($str_mark,$str_tag)"/>
    <xsl:choose>
      <xsl:when test="contains($str_mark,$str_tag)">
	<xsl:value-of select="substring-before($str_mark,$str_tag)"/>
	<xsl:element name="span">
	  <xsl:attribute name="class">datum</xsl:attribute>
	  <xsl:value-of select="$str_tag"/>
	</xsl:element>
	<xsl:if test="string-length($str_tail) &gt; 0">
	  <xsl:call-template name="TAGMARKUP">
	    <!-- recursive call -->
	    <xsl:with-param name="str_mark">
	      <xsl:value-of select="$str_tail"/>
	    </xsl:with-param>
	  </xsl:call-template>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$str_mark"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="ADDSTYLE">
    <xsl:param name="flag_background" select="true()"/>
    <xsl:if test="@color or @background">
      <xsl:attribute name="style">
	<xsl:choose>
	  <xsl:when test="$flag_background">
            <xsl:choose>
              <xsl:when test="@background and @color">
                <xsl:value-of select="concat('color:',@color,';background-color:',@background)"/>
              </xsl:when>
              <xsl:when test="@background">
                <xsl:value-of select="concat('background-color:',@background)"/>
              </xsl:when>
              <xsl:when test="@color">
                <xsl:value-of select="concat('color:',@color)"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- no node colors at all -->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
	  <xsl:when test="@color and not(@background)">
	    <xsl:value-of select="concat('color:',@color)"/>
	  </xsl:when>
          <xsl:otherwise>
	    <!-- default is black/white -->
          </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>
  <xsl:template name="MENUSET">
    <xsl:attribute name="name">
      <xsl:value-of select="concat(@flocator,':',@fxpath,':',@xpath)"/>
    </xsl:attribute>
    <xsl:attribute name="class">
      <xsl:value-of select="concat('context-menu-',name())"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template name="FORMATTOOLTIP">
    <xsl:param name="node"/>
    <xsl:value-of select="concat(ancestor::*[@flocator and position() = 1]/@flocator,' ')"/>
    <xsl:for-each select="@*">
      <xsl:if test="not(contains(name(),'id')) and not(name()='hstr') and not(contains(name(),'xpath')) and not(contains(name(),'locator'))">
	<xsl:value-of select="concat(name(),'=',.,' ')"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:value-of select="$newline"/>
    <xsl:for-each select="*[not(name()='h') and not(name()='t')]">
      <xsl:if test="string-length(.)">
	<xsl:value-of select="concat(name(),': ',text(),' ',$newline)"/>
      </xsl:if>
      <xsl:call-template name="FORMATTOOLTIP">
	<xsl:with-param name="node" select="self::node()"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="TIMESTRING">
    <xsl:if test="@hour">
      <xsl:value-of select="concat(@hour,'.',@minute)"/>
      <xsl:if test="@hour-end">
	<xsl:value-of select="concat('-',@hour-end,'.',@minute-end)"/>
      </xsl:if>
      <xsl:value-of select="concat('',' ')"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="CLASSATRIBUTE">
    <xsl:attribute name="class">
      <xsl:choose>
	<xsl:when test="@state">
	  <xsl:value-of select="concat(name(),'-',@state)"/>
	</xsl:when>
	<xsl:when test="@done">
	  <xsl:value-of select="concat(name(),'-done')"/>
	</xsl:when>
	<xsl:when test="@impact">
	  <xsl:value-of select="concat(name(),@impact)"/>
	</xsl:when>
	<xsl:when test="@class">
	  <xsl:value-of select="@class"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="name()"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  <xsl:template name="TASK">
    <!-- callable for task element -->
    <xsl:param name="flag_line" select="false()"/>
    <xsl:param name="flag_ancestor" select="false()"/>
    <xsl:param name="flag_contact" select="true()"/>
    <xsl:element name="div">
      <xsl:call-template name="CLASSATRIBUTE"/>
      <xsl:call-template name="ADDSTYLE"/>
      <xsl:attribute name="id">
	<xsl:value-of select="translate(@xpath,'/*[]','_')"/>
      </xsl:attribute>
      <xsl:element name="span">
	<xsl:call-template name="MENUSET"/>
	  <xsl:if test="@name">
	    <xsl:element name="a">
	      <xsl:copy-of select="@name"/>
	    </xsl:element>
	  </xsl:if>
	<xsl:if test="$flag_ancestor">
	  <!--  -->
	  <xsl:element name="i">
	    <xsl:element name="a">
	      <xsl:attribute name="title">
		<xsl:call-template name="FORMATTOOLTIP">
		  <xsl:with-param name="node" select="self::node()"/>
		</xsl:call-template>
	      </xsl:attribute>
	      <xsl:choose>
		<xsl:when test="@hstr">
		  <xsl:value-of select="@hstr"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:for-each select="ancestor::section[position() &lt; 3]">
		    <xsl:value-of select="h"/>
		    <xsl:text>::</xsl:text>
		  </xsl:for-each>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:element>
	  </xsl:element>
	</xsl:if>
	<xsl:element name="span">
	  <xsl:choose>
	    <xsl:when test="@state">
	      <xsl:attribute name="class">
		<xsl:value-of select="concat('htag-',@state)"/>
	      </xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@class">
	      <xsl:attribute name="class">
		<xsl:value-of select="concat('htag-',@class)"/>
	      </xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:attribute name="class">htag-todo</xsl:attribute>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:call-template name="FORMATTASKPREFIX"/>
	</xsl:element>
	<xsl:apply-templates select="h"/>
	<xsl:call-template name="FORMATIMPACT"/>
	<!--  -->
	<xsl:if test="@effort">
	  <xsl:text> / </xsl:text>
	  <xsl:value-of select="@effort"/>
	</xsl:if>
	<!--  -->
	<xsl:choose>
	  <xsl:when test="not($flag_contact)"/>
	  <xsl:when test="$flag_line">
	    <xsl:for-each select="contact|tag">
	      <xsl:variable name="str">
		<xsl:choose>
		  <xsl:when test="self::contact">
		    <xsl:value-of select="translate(@idref,'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ','abcdefghijklmnopqrstuvwxyzäöü')"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ','abcdefghijklmnopqrstuvwxyzäöü')"/>
		  </xsl:otherwise>
		</xsl:choose>
	      </xsl:variable>
	      <xsl:text> / </xsl:text>
	      <xsl:element name="a">
		<xsl:attribute name="href">
		  <xsl:value-of select="concat($file_ref,translate($str,'ÄÖÜ','äöü'))"/>
		</xsl:attribute>
		<xsl:value-of select="$str"/>
		<xsl:text> </xsl:text>
	      </xsl:element>
	    </xsl:for-each>
	  </xsl:when>
	  <xsl:when test="count(child::*[not(name()='h')]) &gt; 0">
	    <xsl:element name="div">
	      <xsl:attribute name="style">margin: 5px 5px 5px 15px;</xsl:attribute>
	      <xsl:if test="contact">
		<xsl:for-each select="contact[child::*]">
		  <xsl:element name="div">
		    <xsl:attribute name="class">tag</xsl:attribute>
		    <xsl:element name="a">
		      <xsl:attribute name="href">
			<xsl:value-of select="concat($file_ref,@idref)"/>
		      </xsl:attribute>
		      <xsl:value-of select="@idref"/>
		    </xsl:element>
		  </xsl:element>
		  <xsl:apply-templates select="p|list|pre|text()"/>
		</xsl:for-each>
	      </xsl:if>
	      <!--  -->
	      <xsl:apply-templates select="*[not(name()='contact') and not(name()='h')]"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:otherwise>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>
<xsl:template name="CREATESTYLE">
    <xsl:element name="style">
/* this is the CSS for txt2x: txt2x.css

  replace patterns:               draft
    background-color:#ffffff;
    basis font-size:12px;
    link color:#001dc1;
    li margin-top:30px;

 */

body,table {
  background-color:#ffffff;
  font-family: Arial,sans-serif;
  /* font-family:Courier; */
  font-size:12px;
  margin: 5px 5px 5px 5px;
}

/* Header tags

 */

h1,h2,h3,h4 {
  /* 
 margin: 10px 10px 20px 20px;
     margin-top
     margin-bottom
     margin-left
     margin-right
  */
 font-weight:bold;
}

h1 {
  font-size:200%;
}

h2 {
  font-size:160%;
}

h3 {
  font-size:140%;
}

h4 {
  font-size:100%;
}

h5 {
  font-size:90%;
}

h6 {
  font-size:80%;
}

h7 {
  font-size:70%;
}

/* Links

 */
a {
  text-decoration:none;
}

a:active {
  color:#ff0000;
}

a:link {
  /* color:#AA5522; */
}

a:visited {
  /* color:#772200; */
}

a.datum {
  background-color:#00FF00;
}
a.error {
  background-color:#FF0000;
}
a.warning {
  background-color:#00FFFF;
}
a.ok {
  background-color:#00FF00;
}
.done {
 color:#aaaaaa;
 /*  text-decoration:line-through; */
}
.geb {
 color:#000000;
 background-color:#00FF00;
}

/* 

 */
b.em {
  font-size:100%;
  font-weight:normal;
  text-decoration:underline;
}

/* settings for tables
 */

table {
  width: 95%;
  border-collapse: collapse;
  margin-left:auto;
  margin-right:auto;
}
.PIE {
}

table.vcard {
  margin: 5px 5px 5px 5px;
  background-color:#ffffff;
}

table.unlined {
  background-color:#ffffff;
}

tr {
}

/* data cells */
td {
  border: 1px solid grey;
  vertical-align:top;
}
.empty {
  margin-bottom:0px;
}
.c11 {
  background-color:#ffcccc;
}
.c12 {
  background-color:#eeffee;
}
.c21 {
  background-color:#ffeeee;
}
.c22 {
  background-color:#ffffff;
}
.state {
  text-align:center;
}
.transition {
  text-align:center;
  background-color:#e0e0e0;
}
.Sa,.sat,.So,.sun {
  margin-bottom:0px;
  text-align:left;
  background-color:#f0f0f0;
  font-weight:bold;
}
.summary {
  margin-bottom:0px;
  text-align:left;
  background-color:#fffed2;
}
.today {
  background-color:#e0e0ff;
}
.gantt-low {
  background-color:#BBffBB;
  vertical-align:middle;
  text-align:center;
}
.gantt {
  background-color:#ffffBB;
  vertical-align:middle;
  text-align:center;
}
.gantt-high {
  background-color:#ffBBBB;
  vertical-align:middle;
  text-align:center;
}

table.formicons {
  border-spacing:3px;
}
td.formicon {
  text-align:left;
  width: 27px;
}
.separator {
  width: 10px;
}
.filename {
  text-align:right;
}

td.SLIDE {
  margin: 15px 15px 15px 15px;
  background-color:#00FF00;
}

/* header cells */
th {
  border: 1px solid grey;
  margin-bottom:0px;
  text-align:left;
  background-color:#d9d9d9;
  color:#000000;
  font-weight:bold;
}
.title {
  margin-bottom:0px;
  text-align:left;
  background-color:#e0e0e0;
  font-weight:bold;
}
.header {
  margin-bottom:0px;
  text-align:left;
  background-color:#d9d9d9;
  font-weight:bold;
}
th.marker {
  margin-bottom:0px;
  text-align:center;
  background-color:#d9d9d9;
  font-weight:bold;
}

div.contact {
 height: 150px;
  writing-mode: bt-rl;
}

div.tag {
 margin: 3px 3px 3px 3px;
 text-align:right;
}

span.tag {
 margin: 3px 3px 3px 3px;
 background-color:#FFFEA1;
}
span.tagGreen {
 margin: 3px 3px 3px 3px;
 background-color:#88FF88;
}
span.tagYellow {
 margin: 3px 3px 3px 3px;
 background-color:#FFFF88;
}
span.tagRed {
 margin: 3px 3px 3px 3px;
 background-color:#FF8888;
}

/* lists */
ul {
  list-style-type:square;
}

li {
  /* 
 margin: 5px 5px 20px 20px;
     margin-top
     margin-bottom
     margin-left
     margin-right
  */
  margin-left:0px;
  /* text-indent:0.1cm; */
}

/* misc tags

*/
p {
  /* 
 margin: 5px 5px 20px 20px;
     margin-top
     margin-bottom
     margin-left
     margin-right
  */
  /* text-indent:0.1cm; */
 margin: 3px 2px 3px 1px;
}
.p1 {
  background-color:#ffcccc;
}
.p2 {
  background-color:#ccffcc;
}
.p3 {
  background-color:#ccccff;
}
.done {
 color:#aaaaaa;
/*  text-decoration:line-through; */
}
.target {
  margin-bottom:0px;
  text-align:left;
  background-color:#fffea1;
}
.abstract {
 font-style:italic;
  margin-bottom:0px;
  text-align:center;
}
.outlook {
 color:#666666;
 /*  text-decoration:line-through; */
}

li.hidden,p.hidden {
  /* 
 margin: 5px 5px 20px 20px;
     margin-top
     margin-bottom
     margin-left
     margin-right
  */
  /* text-indent:0.1cm; */
  /* margin: 5px 5px 2px 2px; */
  /* background-color:#00ff00; */
  margin-top:5px;
  margin-bottom:5px;
 font-family:Courier;
 font-size:120%;
}

pre {
  font-family:Courier,monospace;
  margin: 4px 4px 5px 20px;
  /* border: 1px solid #a0a0a0; */
  border-spacing:3px;
}

dt {
  /* 
 margin: 10px 10px 20px 20px;
     margin-top
     margin-bottom
     margin-left
     margin-right
  */
 font-weight:bold;
 margin: 5px 5px 5px 5px;
}

dd {
  /* 
 margin: 10px 10px 20px 20px;
     margin-top
     margin-bottom
     margin-left
     margin-right
 margin: 2px 2px 2px 2px;
  */
}

img {
 margin: 10px 10px 20px 20px;
 border:none
}
.localsize {
 width: 800px;
 margin: 5px 5px 10px 10px;
 border:none
}

input,textarea,select {
}
.additor {
  background-color:#EEEEEE;
  border-width:1px; 
  border-color:#BBBBBB;
  border-style:solid;
  padding:2px;
}

p.pieTab {
  line-height: 1.75;
}

span.pieTab {
  vertical-align: top;
 display: inline-block;
 width: 7em;
  text-align:right;
 padding:5px;
  font-weight:bold;
}

input.pieTab {
  vertical-align: top;
  background-color:#EEEEEE;
  border-width:1px; 
  border-color:#BBBBBB;
  border-style:solid;
 padding:2px;
}

select.pieTab {
  vertical-align: top;
  background-color:#EEEEEE;
  border-width:1px; 
  border-color:#BBBBBB;
  border-style:solid;
 padding:2px;
}

textarea.pieTab {
  vertical-align: top;
  background-color:#EEEEEE;
  border-width:1px; 
  border-color:#BBBBBB;
  border-style:solid;
 padding:2px;
}

/* 
p,ul,ol,li,div,td,th,address,blockquote,i,b,input {
}
 */

*.task {
  background-color:#EEEEEE;
  padding: 1px;
  margin: 2px 2px 0px 0px;
}

*.taskDone,*.targetDone {
  color:#AAAAAA;
  background-color:#EEEEEE;
  padding: 1px;
  margin: 2px 2px 0px 0px;
}

*.task1 {
  background-color:#ffdddd;
  padding: 1px;
  margin: 2px 2px 0px 0px;
}

*.task2 {
  background-color:#ddffdd;
  padding: 1px;
  margin: 2px 2px 0px 0px;
}

*.task3 {
  background-color:#ddddff;
  padding: 1px;
  margin: 2px 2px 0px 0px;
}

*.target {
  vertical-align: top;
  background-color:#fffea1;
  padding:1px;
  margin: 2px 2px 0px 0px;
}

*.highlight {
  border-right-color:#ff4444;
  border-right-style: solid;
  border-right-width: 8px;
  padding-right: 5px;
}

/* text marker like styles
 */
span.marker-red {
  background-color:#ff8888;
}
span.marker-yellow {
  background-color:#ffff00;
}
span.marker-green {
  background-color:#88ff88;
}
span.u {
  text-decoration:underline;
}
span.b {
  font-weight:bold;
}
span.i {
  font-style:italic;
}

    </xsl:element>
</xsl:template>
  <xsl:template match="meta|t|contact">
    <!-- ignore this elements -->
  </xsl:template>
</xsl:stylesheet>
