<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0" exclude-result-prefixes="tei">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>
  <xsl:key name="facs-lookup" match="tei:surface | tei:zone" use="@xml:id"/>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
        <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English:ital@0;1&amp;family=EB+Garamond:ital,wght@0,400;0,600;1,400&amp;display=swap" rel="stylesheet"/>
          <!--  Bootstrap Icons  -->
          <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link href="styles.css" rel="stylesheet"/>
        </head>
        <body>
          <!--  ════════════════ HEADER ════════════════  -->
          <header class="site-header">
            <div class="header-inner">
              <!--  Sinistra: badge progetto  -->
              <div class="project-badge">
                <div>Progetto PRIN PNRR</div>
                <div style="color:#c8b89a; font-size:.9em;">COVerLeSS</div>
              </div>
              <!--  Centro: titolo documento  -->
              <div>
                <h1 class="doc-title">
                  <xsl:value-of select="//tei:biblStruct/tei:analytic/tei:title[@level='a']"/>
                </h1>
                <div style="text-align:center; font-size:.75rem; opacity:.5; margin-top:.2rem; letter-spacing:.06em;"> Edizione digitale TEI/XSLT </div>
              </div>
              <!--  Destra: meta documento  -->
              <div class="doc-meta">
                <span>
                  <i class="bi bi-journal-text"/>
                  
                  <em>
                    <xsl:value-of select="//tei:monogr/tei:title"/>
                  </em>
                </span>
                <span>
                  <xsl:value-of select="//tei:imprint/tei:pubPlace"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="//tei:imprint/tei:date"/>
                </span>
                <span style="margin-top:.15rem; opacity:.7;">
                  vol. 
                  <xsl:value-of select="//tei:biblScope[@unit='volume']"/>
                  , n. 
                  <xsl:value-of select="//tei:biblScope[@unit='issue']"/>
                  , pp. 
                  <xsl:value-of select="//tei:biblScope[@unit='page']"/>
                </span>
              </div>
            <!--  Barra secondaria  -->
            <div class="header-sub">
              <h3> <a href="homepage.html" class="nav link text-light">Homepage</a> </h3>
              <h3> <a href="bibliografia.html" class="nav link text-light">Bibliografia e metedati</a> </h3>
            </div>
            </div>
          </header>
          <!--  ════════════════ LEGENDA ════════════════  -->
          <div class="legenda-bar">
            <span class="leg-label">Legenda</span>
            <span class="leg-pill pers">
              <i class="bi bi-person"/>
              Persona
            </span>
            <span class="leg-pill luogo">
              <i class="bi bi-geo-alt"/>
              Luogo
            </span>
            <span class="leg-pill opera">
              <i class="bi bi-book"/>
              Opera
            </span>
            <span class="leg-pill term">
              <i class="bi bi-chat-quote"/>
              Termine
            </span>
          <span class="leg-pill dist">
            <i class="bi bi-chat-quote"/>
            Parole arcaiche
          </span>
            <span style="margin-left:auto; font-size:.72rem; color:var(--c-dark); opacity:.6;">
              <i class="bi bi-cursor-text"/>
              Passa il cursore sulle entità evidenziate per i dettagli
            </span>
          </div>
          <!--  ════════════════ CORPO ════════════════  -->
          <div class="main-layout">
            <!--  Pannello facsimile  -->
            <div class="facsimile-panel">
              <h5>
                <i class="bi bi-image"/>
                Fonte facsimile
              </h5>
              <xsl:apply-templates select="//tei:facsimile/tei:surface"/>
            </div>
            <!--  Pannello testo  -->
            <div class="text-panel">
              <xsl:apply-templates select="//tei:body"/>
            </div>
          </div>
          <!--  ════════════════ FOOTER ════════════════  -->
          <footer class="site-footer">
            <div class="container-fluid px-4">
              <div class="row g-4">
                <!--  Col 1: identità progetto  -->
                <div class="col-md-4">
                  <div class="footer-logo">COVerLeSS</div>
                  <div class="footer-desc"> Progetto PRIN PNRR di codifica digitale di testi della letteratura italiana ottocentesca. Edizioni TEI/XML realizzate presso il CNR-ILC. </div>
                  <div style="margin-top:.8rem;">
                    <a href="http://chroma.cnr.it/progetti/" target="_blank">
                      <i class="bi bi-box-arrow-up-right"/>
                      Sito del progetto
                    </a>
                  </div>
                </div>
                <!--  Col 2: metadati documento  -->
                <div class="col-md-4">
                  <h6>Documento</h6>
                  <ul class="footer-meta-list">
                    <li>
                      <span class="fml-label">File</span>
                      <span class="fml-val" style="font-size:.72rem; word-break:break-all;">
                        <xsl:value-of select="//tei:idno[@type='fileName']"/>
                      </span>
                    </li>
                    <li>
                      <span class="fml-label">Rivista</span>
                      <span class="fml-val">
                        <em>
                          <xsl:value-of select="//tei:monogr/tei:title"/>
                        </em>
                      </span>
                    </li>
                    <li>
                      <span class="fml-label">Luogo</span>
                      <span class="fml-val">
                        <xsl:value-of select="//tei:imprint/tei:pubPlace"/>
                      </span>
                    </li>
                    <li>
                      <span class="fml-label">Data</span>
                      <span class="fml-val">
                        <xsl:value-of select="//tei:imprint/tei:date"/>
                      </span>
                    </li>
                    <li>
                      <span class="fml-label">Pagine</span>
                      <span class="fml-val">
                        <xsl:value-of select="//tei:biblScope[@unit='page']"/>
                      </span>
                    </li>
                  </ul>
                </div>
                <!--  Col 3: standard e licenza  -->
                <div class="col-md-4">
                  <h6>Standard e accesso</h6>
                  <ul class="footer-meta-list">
                    <li>
                      <span class="fml-label">Schema</span>
                      <span class="fml-val">TEI P5 / XSLT 2.0</span>
                    </li>
                    <li>
                      <span class="fml-label">Accesso</span>
                      <span class="fml-val">
                        <xsl:value-of select="normalize-space(//tei:availability/tei:p)"/>
                      </span>
                    </li>
                    <li>
                      <span class="fml-label">Revisione</span>
                      <span class="fml-val">
                        <xsl:value-of select="//tei:revisionDesc/tei:change/@when"/>
                      </span>
                    </li>
                  </ul>
                  <div style="margin-top:.8rem; font-size:.72rem; opacity:.5;">
                    Immagini:
                    <a href="https://iiif.io/" target="_blank">IIIF</a>
                    · Testo:
                    <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank">CC BY 4.0</a>
                  </div>
                </div>
              </div>
              <hr class="footer-divider"/>
              <div class="footer-bottom">
                Edizione digitale realizzata nell'ambito del corso
                <em>Codifica di Testi</em>
                (CNR-ILC, 2024–2025) · Progetto COVerLeSS · Tutti i diritti riservati
              </div>
            </div>
          </footer>
          <!--  Script  -->
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"/>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/image-map-resizer/1.0.10/imageMapResizer.min.js"/>
          <script> window.addEventListener('load', function () { const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]'); popoverTriggerList.forEach(el => { new bootstrap.Popover(el, { trigger: 'hover focus', html: false, container: 'body' }); }); try { imageMapResize(); } catch(e) {} }); </script>
        </body>
      </html>
    </xsl:template>
    <!--  ============================================================
         FACSIMILE
         ============================================================  -->
    <xsl:template match="tei:surface">
      <div class="surface-card">
        <div class="surface-label">
          <i class="bi bi-file-image"/>
          Pagina
          <xsl:value-of select="substring-after(@xml:id, 'pag_')"/>
        </div>
        <xsl:variable name="associatedZone" select="tei:zone[1]/@xml:id"/>
        <a href="#{$associatedZone}" title="Vai al testo di questa pagina">
          <img src="{tei:graphic/@url}" class="facsimile-img" loading="lazy" alt="Facsimile {@xml:id}"/>
        </a>
      </div>
    </xsl:template>
    <!--  ============================================================
         CORPO DEL TESTO
         ============================================================  -->
    <xsl:template match="tei:body">
      <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:div">
      <div class="sezioni">
        <xsl:apply-templates/>
      </div>
    </xsl:template>
    <!--  pb: ancora pagina  -->
    <xsl:template match="tei:pb">
      <div class="column-anchor-target col-marker" id="{substring-after(@facs,'#')}">
        <span class="badge">
          <i class="bi bi-file-text"/>
          Pagina
          <xsl:value-of select="@n"/>
        </span>
      </div>
    </xsl:template>
    <!--  cb: ancora colonna  -->
    <xsl:template match="tei:cb">
      <xsl:variable name="zoneId" select="substring-after(@facs,'#')"/>
      <div class="column-anchor-target col-marker" id="{$zoneId}">
        <span class="badge">
          <i class="bi bi-layout-split"/>
          Colonna
          <xsl:value-of select="@n"/>
        </span>
      </div>
    </xsl:template>
    <!--  fw: numero pagina — discreto  -->
    <xsl:template match="tei:fw"/>
    <!--  head  -->
    <xsl:template match="tei:head[@type='main']">
      <h1 class="article-head-main">
        <xsl:apply-templates/>
      </h1>
    </xsl:template>
    <xsl:template match="tei:head">
      <h2>
        <xsl:apply-templates/>
      </h2>
    </xsl:template>
    <!--  metamark  -->
    <xsl:template match="tei:metamark">
      <hr style="border:none; border-top:1px solid var(--c-mid); margin:.5rem auto; width:50%;"/>
    </xsl:template>
    <!--  paragrafo  -->
    <xsl:template match="tei:p">
      <p>
        <xsl:apply-templates/>
      </p>
    </xsl:template>
    <!--  citazione  -->
    <xsl:template match="tei:quote">
      <blockquote>
        <xsl:apply-templates/>
      </blockquote>
    </xsl:template>
    <!--  q inline  -->
    <xsl:template match="tei:q">
      <span style="font-style:italic;">
        «
        <xsl:apply-templates/>
        »
      </span>
    </xsl:template>
    <!--  trailer  -->
    <xsl:template match="tei:trailer">
      <p style="text-align:center; font-style:italic; color:var(--c-dark); margin-top:1rem;">
        <xsl:apply-templates/>
      </p>
    </xsl:template>
    <!--  testo: unisce i trattini a fine riga  -->
    <xsl:template match="text()">
      <xsl:value-of select="replace(., '-\s+', '')"/>
    </xsl:template>
    <!--  ── Entità semantiche ──  -->
    <xsl:template match="tei:persName">
      <xsl:variable name="id" select="substring-after(@ref,'#')"/>
      <xsl:variable name="doc" select="document('coverlessListPerson.xml')"/>
      <xsl:variable name="person" select="$doc//tei:person[@xml:id=$id]"/>
      <xsl:variable name="note" select="normalize-space($person/tei:note[1])"/>
      <xsl:variable name="name">
        <xsl:value-of select="normalize-space($person/tei:persName/tei:forename)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space($person/tei:persName/tei:surname)"/>
      </xsl:variable>
      <span class="rif_persona" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-title="{normalize-space($name)}" data-bs-content="{$note}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <xsl:template match="tei:name[@ref]">
      <xsl:variable name="id" select="substring-after(@ref,'#')"/>
      <xsl:variable name="doc" select="document('coverlessListPerson.xml')"/>
      <xsl:variable name="person" select="$doc//tei:person[@xml:id=$id]"/>
      <xsl:variable name="note" select="normalize-space($person/tei:note[1])"/>
      <span class="rif_persona" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{$note}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <xsl:template match="tei:name">
      <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:placeName">
      <xsl:variable name="id" select="substring-after(@ref,'#')"/>
      <xsl:variable name="doc" select="document('coverlessListPlace.xml')"/>
      <xsl:variable name="place" select="$doc//tei:place[@xml:id=$id]"/>
      <xsl:variable name="note" select="normalize-space($place/tei:note)"/>
      <span class="rif_luogo" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-title="{normalize-space($place/tei:placeName[1])}" data-bs-content="{$note}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <xsl:template match="tei:orgName">
      <xsl:variable name="id" select="substring-after(@ref,'#')"/>
      <xsl:variable name="doc" select="document('coverlessListOrganisation.xml')"/>
      <xsl:variable name="org" select="$doc//tei:org[@xml:id=$id]"/>
      <span class="rif_organizzazione" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{normalize-space($org/tei:note)}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <xsl:template match="tei:title">
      <xsl:variable name="id" select="substring-after(@ref,'#')"/>
      <xsl:variable name="doc" select="document('coverlessListWork.xml')"/>
      <xsl:variable name="work" select="$doc//tei:biblStruct[@xml:id=$id]"/>
      <span class="rif_opera" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-placement="top" data-bs-content="{normalize-space($work/tei:note)}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <!--  choice: mostra orig, sopprimi reg  -->
    <xsl:template match="tei:choice">
      <span class="choice">
        <xsl:apply-templates select="tei:orig"/>
      </span>
    </xsl:template>
    <xsl:template match="tei:orig">
    <span class="distinct">
      <xsl:apply-templates/>
    </span>
    </xsl:template>
    <xsl:template match="tei:reg"/>
    <!--  term  -->
    <xsl:template match="tei:term">
      <span class="termine">
        <xsl:apply-templates/>
      </span>
      
    </xsl:template>
  <xsl:template match="tei:distinct">
    <span class="distinct">
      <xsl:apply-templates/>
    </span>
    
  </xsl:template>
    <!--  hi  -->
    <xsl:template match="tei:hi[@rend='italic']">
      <em>
        <xsl:apply-templates/>
      </em>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='initial-cap' or @rend='capital_letter']">
      <span style="float:left; font-size:3rem; line-height:1; margin:.05em .1em 0 0; font-family:'IM Fell English',serif; color:var(--c-dark);">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <xsl:template match="tei:hi">
      <xsl:apply-templates/>
    </xsl:template>
    <!--  foreign / distinct / supplied / unclear  -->
    <xsl:template match="tei:foreign">
      <em lang="{@xml:lang}">
        <xsl:apply-templates/>
      </em>
    </xsl:template>
    <xsl:template match="tei:supplied">
      <span style="color:#888;">
        [
        <xsl:apply-templates/>
        ]
      </span>
    </xsl:template>
    <xsl:template match="tei:unclear">
      <span style="text-decoration:underline dotted #aaa;" title="Lettura incerta">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <!--  add (annotazioni a matita)  -->
    <xsl:template match="tei:add">
      <sup style="font-size:.7rem; color:#999;">
        [
        <xsl:apply-templates/>
        ]
      </sup>
    </xsl:template>
    <!--  rs, ref: pass-through  -->
    <xsl:template match="tei:rs | tei:ref">
      <xsl:apply-templates/>
    </xsl:template>
    <!--  date  -->
    <xsl:template match="tei:date">
      <span title="{@when}{@from}{@to}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <!--  ptr: rimando a nota  -->
    <xsl:template match="tei:ptr">
      <sup style="font-size:.72rem; color:var(--c-accent);">
        <a href="#{substring-after(@target,'#')}" style="color:inherit;">
          <xsl:choose>
            <xsl:when test="@n">
              <xsl:value-of select="@n"/>
            </xsl:when>
            <xsl:otherwise>*</xsl:otherwise>
          </xsl:choose>
        </a>
      </sup>
    </xsl:template>
    <!--  note footnote  -->
    <xsl:template match="tei:note[@type='footnote']">
      <span style="display:block; font-size:.82rem; color:#666; border-left:2px solid var(--c-mid); padding-left:.6rem; margin:.5rem 0 .5rem 1rem; font-style:italic;">
        <xsl:if test="@n">
          <strong>
            <xsl:value-of select="@n"/>
            
          </strong>
        </xsl:if>
        <xsl:apply-templates/>
      </span>
    </xsl:template>
    <!--  seg  -->
    <xsl:template match="tei:seg">
      <xsl:apply-templates/>
    </xsl:template>
    <!--  back: note editoriali  -->
    <xsl:template match="tei:back">
      <div style="margin-top:2.5rem; border-top:2px solid var(--c-mid); padding-top:1rem;">
        <h6 style="font-variant:small-caps; letter-spacing:.06em; color:var(--c-dark);">Note editoriali</h6>
        <xsl:for-each select=".//tei:item[tei:note]">
          <div style="font-size:.85rem; margin-bottom:.7rem; line-height:1.6;">
            <strong style="color:var(--c-accent);">
              <xsl:value-of select="tei:note/@n"/>
              
            </strong>
            <xsl:apply-templates select="tei:note/tei:ab"/>
          </div>
        </xsl:for-each>
      </div>
    </xsl:template>
    <!--  ab  -->
    <xsl:template match="tei:ab">
      <p>
        <xsl:apply-templates/>
      </p>
    </xsl:template>
  </xsl:stylesheet>