<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0" exclude-result-prefixes="tei">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>
  <!--  ============================================================
       ROOT
       ============================================================  -->
  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
        <script type="module">
          import * as bootstrap from 'bootstrap'
          
          new bootstrap.Popover(document.getElementById('popoverButton'))
        </script>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
        <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English:ital@0;1&amp;family=EB+Garamond:ital,wght@0,400;0,600;1,400&amp;display=swap" rel="stylesheet"/>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous"/>
          <style>
            
            /* ── Variabili base ── */
            :root {
            --warm-bg: #faf8f4;
            --warm-mid: #c8b89a;
            --warm-dark: #5c4a2a;
            --ink: #2a2017;
            --accent: 
            --note-bg: #f5f0e8;
            }
            .rif_luogo {
              background: #78f5ac;
            }
          .rif_persona {
          background: #e6d1ac;
          }
          .rif_organizzazione {
          background: #e68ff1;
          }
          .rif_opera {
          background: #7072e7;
          }
            body {
            background: var(--warm-bg);
            color: var(--ink);
            font-family: 'EB Garamond', Georgia, serif;
            font-size: 1.05rem;
            }
            
            
            /* mostra al hover */
            span:hover .popup {
            display: block;
            }
            .sezioni{
              margin: 100px;
              padding: 50px;
              border: 50px;
            }
      </style>
      </head>
      <body>
        <script>
          document.addEventListener('DOMContentLoaded', function () {
          const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
          
          popoverTriggerList.forEach(el => {
          new bootstrap.Popover(el, {
          trigger: 'hover focus'
          });
          });
          });
        </script>
        <xsl:apply-templates select="//tei:body"/>
      </body>
    </html>
    </xsl:template>
  <xsl:template match="tei:body">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:div">
    <div class="sezioni">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="tei:p">
    
    <p>
      <xsl:apply-templates/>
    </p>
    
  </xsl:template>
  <xsl:template match="tei:cb">
    
    <div class="column-break">
      <xsl:apply-templates/>
    </div>
    
  </xsl:template>
  <xsl:template match="tei:head">
    
    <h2><xsl:apply-templates/></h2>
    
  </xsl:template>
  <xsl:template match="tei:persName">
    
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListPerson.xml')"/>
    <xsl:variable name="person" select="$doc//tei:person[@xml:id=$id]"/>
    
    <span
      class="rif_persona"
      tabindex="0"
      data-bs-toggle="popover"
      data-bs-trigger="hover focus"
      data-bs-placement="top"
      data-bs-content="{normalize-space($person/tei:note)}">
      
      <xsl:value-of select="."/>
      
    </span>
  
  </xsl:template>
  <xsl:template match="tei:placeName">
    
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListPlace.xml')"/>
    <xsl:variable name="place" select="$doc//tei:place[@xml:id=$id]"/>
    
    <span
      class="rif_luogo"
      tabindex="0"
      data-bs-toggle="popover"
      data-bs-trigger="hover focus"
      data-bs-placement="top"
      data-bs-content="{normalize-space($place/tei:note)}">
      
      <xsl:value-of select="."/>
      
    </span>
    
  </xsl:template>
  <xsl:template match="tei:orgName">
    
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListOrganisation.xml')"/>
    <xsl:variable name="org" select="$doc//tei:org[@xml:id=$id]"/>
    
    <span
      class="rif_organizzazione"
      tabindex="0"
      data-bs-toggle="popover"
      data-bs-trigger="hover focus"
      data-bs-placement="top"
      data-bs-content="{normalize-space($org/tei:note)}">
      
      <xsl:value-of select="."/>
      
    </span>
    
  </xsl:template>
  <xsl:template match="tei:title">
    
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListWork.xml')"/>
    <xsl:variable name="work" select="$doc//tei:biblStruct[@xml:id=$id]"/>
    
    <span
      class="rif_opera"
      tabindex="0"
      data-bs-toggle="popover"
      data-bs-trigger="hover focus"
      data-bs-placement="top"
      data-bs-content="{normalize-space($work/tei:note)}">
      
      <xsl:value-of select="."/>
      
    </span>
    
  </xsl:template>
 
</xsl:stylesheet>