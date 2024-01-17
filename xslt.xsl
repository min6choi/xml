<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html"/>

    <!-- remove WS only text nodes -->
    <xsl:strip-space elements="*"/>

    <!-- root element -->
    <xsl:template match="/tei:TEI">
        <html>
            <head>
                <title>Title</title>
                <style>
                    /* add style */
                    body {
                        font-family: 'Arial', sans-serif;
                        line-height: 1.6;
                        margin: 20px;
                    }

                    h1 {
                        color: #3498db; 
                    }

                    .div {
                        /* div element style */
                        margin: 10px;
                        padding: 10px;
                        border: 1px solid #1F1F1F;
                        background-color: #FEFEFE;
                    }

                    .br {
                        /* br element style */
                        color: #3498db; 
                    }

                    .pb {
                        /* pb element style */
                        color: #ae2778; 
                    }

                    span.ed {
                        /*emph style*/
                    font-family: serif;
                    font-style: italic;
                    }

                    .span.sup {
                    font-size: 80%;
                    font-weight: bold;
                    vertical-align: super;
                    }

                    .super {
                        /* super class style */
                        font-size: 80%;
                        font-weight: bold;
                        vertical-align: super;
                        color: #0a5e26; 
                    }
                </style>
            </head>
            <body>
                <h1>TEI Sample</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- Identity template: copies everything as is by default -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Templates for specific elements -->

    <!-- Remove TEI header -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Modify div element -->
    <xsl:template match="tei:div">
        <div class="div">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Modify lb element -->
    <xsl:template match="tei:lb">
        <br class="br"/>
    </xsl:template>
    
    <!-- Modify pb element -->
    <xsl:template match="tei:pb">
        <!--위에 문장과 구분하기 위해 두개의 br를 추가-->
        <br/>
        <br/>
        <span class="pb">
            <xsl:choose>
                <xsl:when test="@n">
                    <span class="super">
                        <xsl:value-of select="@n"/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    &#x25ae;
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- emph > em -->
    <xsl:template match="tei:emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <!-- Modify span element for small font size and superscript style -->
    <xsl:template match="tei:span">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- choice 요소 (축약어 출력) -->
    <xsl:template match="tei:choice">
        <!-- for blank -->
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="tei:abbr"/>
    </xsl:template>



    <!--img -->
    <xsl:template match="tei:graphic">
        <img>
            <xsl:attribute name="src"><xsl:value-of select="@url"/></xsl:attribute>
            <xsl:attribute name="width">500px</xsl:attribute>
            <xsl:if test="following-sibling::tei:figDesc">
                <xsl:attribute name="alt">
                    <xsl:value-of select="following-sibling::tei:figDesc"/>
                </xsl:attribute>
            </xsl:if>
        </img>
    </xsl:template>
    
    <xsl:template match="tei:figDesc">
        <figcaption>
            <xsl:apply-templates/>
        </figcaption>
    </xsl:template>

    <!-- for list-->
    <xsl:template match="tei:list">
        <xsl:choose>
            <xsl:when test="@type = 'numbered'">
                <ol>
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

</xsl:stylesheet>
