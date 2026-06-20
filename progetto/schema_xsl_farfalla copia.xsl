<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="2.0"
                exclude-result-prefixes="tei">
  
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>
  
  <xsl:key name="facs-lookup" match="tei:surface | tei:zone" use="@xml:id"/>
  
  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
        <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English:ital@0;1&amp;family=EB+Garamond:ital,wght@0,400;0,600;1,400&amp;display=swap" rel="stylesheet"/>
        
        <style>
          :root {
          --warm-bg: #faf8f4;
          --warm-mid: #c8b89a;
          --warm-dark: #5c4a2a;
          --ink: #2a2017;
          --note-bg: #f5f0e8;
          }
          
          html {
          scroll-behavior: smooth; /* Permette uno scorrimento fluido al clic */
          }
          
          body {
          background: var(--warm-bg);
          color: var(--ink);
          font-family: 'EB Garamond', Georgia, serif;
          font-size: 1.1rem;
          }
          
          /* --- Pannelli ad Assetto Affiancato (Split-Screen) --- */
          .facsimile-panel {
          position: sticky;
          top: 10px;
          height: 95vh;
          overflow-y: auto;
          border-right: 2px solid var(--warm-mid);
          padding-right: 15px;
          }
          
          .text-panel {
          height: 95vh;
          overflow-y: auto;
          padding-left: 30px;
          }
          
          .surface-container {
          background: #fff;
          border: 1px solid var(--warm-mid);
          padding: 10px;
          margin-bottom: 30px;
          border-radius: 4px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.05);
          }
          
          .facsimile-img {
          display: block;
          max-width: 100%;
          height: auto;
          }
          
          /* --- Effetto Puntatore/Evidenziatore Dinamico al Clic --- */
          .column-anchor-target {
          display: block;
          padding: 10px;
          border-left: 4px solid transparent;
          transition: all 0.4s ease-in-out;
          border-radius: 0 4px 4px 0;
          }
          
          /* Si attiva automaticamente quando viene cliccata l'area corrispondente sulla foto */
          .column-anchor-target:target {
          border-left-color: var(--warm-dark);
          background-color: rgba(200, 184, 154, 0.3);
          animation: pulse-highlight 2s infinite alternate;
          }
          
          @keyframes pulse-highlight {
          0% { background-color: rgba(200, 184, 154, 0.1); }
          100% { background-color: rgba(200, 184, 154, 0.35); }
          }
          
          .sezioni {
          margin-bottom: 40px;
          }
          
          /* Colori per le Entità Evidenziate (Opzionali) */
          .rif_persona .rif_luogo .rif_organizzazione .rif_opera { background-color: #da9e74; cursor: pointer; }
          .rif_opera {font-style:italic}
        </style>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/image-map-resizer/1.0.10/imageMapResizer.min.js"></script>
        
        <script>
          window.addEventListener('load', function () {
          // 1. Inizializzazione Popover di Bootstrap
          const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
          popoverTriggerList.forEach(el => {
          new bootstrap.Popover(el, { trigger: 'hover focus' });
          });
          
          // 2. Ricalcolo delle coordinate delle mappe in base alle dimensioni reali della foto
          try {
          imageMapResize();
          console.log("Mappe d'immagine coordinate e attivate.");
          } catch(err) {
          console.error("Errore nel ridimensionamento delle mappe: ", err);
          }
          });
        </script>
      </head>
      <body>
        <div class="container-fluid py-3">
          <div class="row">
            
            <div class="col-lg-5 facsimile-panel">
              <h4 class="text-center mb-3 text-muted" style="font-family:'IM Fell English', serif;">Facsimili Manoscritto</h4>
              <xsl:apply-templates select="//tei:facsimile/tei:surface"/>
            </div>
            
            <div class="col-lg-7 text-panel">
              <xsl:apply-templates select="//tei:body"/>
            </div>
            
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:surface">
    <div class="surface-container" id="visual-{@xml:id}">
      <h6 class="text-muted mb-2">Superficie: <xsl:value-of select="substring-after(@xml:id, 'pag_')"/></h6>
      
      <xsl:variable name="w">
        <xsl:choose>
          <xsl:when test="@width"><xsl:value-of select="replace(@width, '[^\d]', '')"/></xsl:when>
          <xsl:when test="@lrx"><xsl:value-of select="@lrx"/></xsl:when>
          <xsl:otherwise>3370</xsl:otherwise> </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="h">
        <xsl:choose>
          <xsl:when test="@height"><xsl:value-of select="replace(@height, '[^\d]', '')"/></xsl:when>
          <xsl:when test="@lry"><xsl:value-of select="@lry"/></xsl:when>
          <xsl:otherwise>4844</xsl:otherwise> </xsl:choose>
      </xsl:variable>
      
      <img src="{tei:graphic/@url}" 
           usemap="#map-{@xml:id}" 
           width="{$w}" 
           height="{$h}" 
           class="facsimile-img" 
           alt="Facsimile {@xml:id}"/>
      
      <map name="map-{@xml:id}" id="map-{@xml:id}">
        <xsl:for-each select="tei:zone">
          <xsl:choose>
            <xsl:when test="@points">
              <xsl:variable name="cleanCoords" select="replace(normalize-space(@points), '[\s,]+', ',')"/>
              <area shape="poly" coords="{$cleanCoords}" href="#{@xml:id}" title="Salta alla colonna {@xml:id}" style="cursor:pointer;"/>
            </xsl:when>
            
            <xsl:when test="@ulx and @uly and @lrx and @lry">
              <area shape="rect" coords="{@ulx},{@uly},{@lrx},{@lry}" href="#{@xml:id}" title="Salta alla colonna {@xml:id}" style="cursor:pointer;"/>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </map>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:body">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()">
    <xsl:value-of select="replace(., '-\s+', '')"/>
  </xsl:template>
  
  <xsl:template match="tei:div">
    <div class="sezioni">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:cb">
    <xsl:variable name="zoneId" select="substring-after(@facs, '#')"/>
    <div class="column-anchor-target my-3" id="{$zoneId}">
      <span class="badge bg-secondary">Inizio Colonna <xsl:value-of select="@n"/></span>
    </div>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:head">
    <h2 class="mb-3" style="font-family:'IM Fell English', serif;"><xsl:apply-templates/></h2>
  </xsl:template>
  
  <xsl:template match="tei:p">
    <p class="mb-3" style="text-align: justify; line-height: 1.6;"><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="tei:persName">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListPerson.xml')"/>
    <xsl:variable name="person" select="$doc//tei:person[@xml:id=$id]"/>
    <span class="rif_persona" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{normalize-space($person/tei:note)}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  
  <xsl:template match="tei:placeName">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListPlace.xml')"/>
    <xsl:variable name="place" select="$doc//tei:place[@xml:id=$id]"/>
    <span class="rif_luogo" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{normalize-space($place/tei:note)}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  
  <xsl:template match="tei:orgName">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListOrganisation.xml')"/>
    <xsl:variable name="org" select="$doc//tei:org[@xml:id=$id]"/>
    <span class="rif_organizzazione" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{normalize-space($org/tei:note)}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  
  <xsl:template match="tei:title">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:variable name="id" select="substring-after($ref, '#')"/>
    <xsl:variable name="doc" select="document('coverlessListWork.xml')"/>
    <xsl:variable name="work" select="$doc//tei:biblStruct[@xml:id=$id]"/>
    <span class="rif_opera" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{normalize-space($work/tei:note)}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  
</xsl:stylesheet>