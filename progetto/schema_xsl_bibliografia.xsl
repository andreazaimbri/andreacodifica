<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0" exclude-result-prefixes="tei">
<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>
<!--  ============================================================
     VARIABILI GLOBALI: carica i file authority una volta sola
     ============================================================  -->
<xsl:variable name="persons" select="document('coverlessListPerson.xml')//tei:person"/>
<xsl:variable name="places" select="document('coverlessListPlace.xml')//tei:place"/>
<xsl:variable name="works" select="document('coverlessListWork.xml')//tei:biblStruct"/>
<xsl:variable name="orgs" select="document('coverlessListOrganisation.xml')//tei:org"/>
<!--  ============================================================
     ROOT
     ============================================================  -->
<xsl:template match="/">
  <html lang="it">
    <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Indice delle entità — COVerLeSS</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
      <link rel="preconnect" href="https://fonts.googleapis.com"/>
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
      <link rel="stylesheet" href="styles.css"/>
      <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English:ital@0;1&amp;family=EB+Garamond:ital,wght@0,400;0,600;1,400&amp;display=swap" rel="stylesheet"/>
     </head>
      <body>
        <!--  ════════ HEADER ════════  -->
        <header class="site-header">
          <div class="header-inner">
            <div class="project-badge">
              Progetto PRIN PNRR
              <strong>COVerLeSS</strong>
            </div>
            <h1 class="doc-title">Indice delle entità</h1>
            <div class="doc-meta">
              <span>
                <i class="bi bi-journal-text"/>
                
                <em>La Farfalla</em>
                , Cagliari 1879
              </span>
              <span style="margin-top:.2rem;">Edizione digitale TEI/XSLT</span>
            </div>
          </div>
          <nav class="desktop-nav">
            <ul class="header-sub">
              <li> <a href="homepage.html" class="nav link text-light">Homepage</a> </li>
              <li> <a href="bibliografia.html" class="nav link text-light">Bibliografia e metedati</a> </li>
              <li> <a href="articolo1.html" class="nav link text-light">Zola: Romanziere e Commediografo</a> </li>
              <li> <a href="articolo2.html" class="nav link text-light">Zola: Critico</a> </li>
            </ul>
          </nav>
          <nav class="mobile-nav">
            <ul class="header-mobile">
              <li> <a href="homepage.html" class="nav text-light">Homepage</a> </li>
              <li> <a href="bibliografia.html" class="nav text-light">Bibliografia e metadati</a> </li>
              <li> <a href="articolo1.html" class="nav text-light">Zola: Romanziere e Commediografo</a> </li>
              <li> <a href="articolo2.html" class="nav text-light">Zola: Critico</a> </li>
            </ul>
          </nav>
          <div class="header-sub">
            <span>
              <i class="bi bi-person-fill"/>
              Persone:
              <strong>
                <xsl:value-of select="count($persons)"/>
              </strong>
            </span>
            <span>
              <i class="bi bi-geo-alt-fill"/>
              Luoghi:
              <strong>
                <xsl:value-of select="count($places)"/>
              </strong>
            </span>
            <span>
              <i class="bi bi-book-fill"/>
              Opere:
              <strong>
                <xsl:value-of select="count($works)"/>
              </strong>
            </span>
            <span>
              <i class="bi bi-building"/>
              Organizzazioni:
              <strong>
                <xsl:value-of select="count($orgs)"/>
              </strong>
            </span>
            <span style="margin-left:auto; opacity:.5;">
              File:
              <xsl:value-of select="//tei:idno[@type='fileName']"/>
            </span>
          </div>
        </header>
        <!--  ════════ NAV SEZIONI ════════  -->
        <nav class="section-nav" aria-label="Sezioni">
          <span class="nav-label">Vai a</span>
          <a href="#sec-persone" class="sec-btn pers">
            <i class="bi bi-person"/>
            Persone
            <span class="badge-count">
              <xsl:value-of select="count($persons)"/>
            </span>
          </a>
          <a href="#sec-luoghi" class="sec-btn place">
            <i class="bi bi-geo-alt"/>
            Luoghi
            <span class="badge-count">
              <xsl:value-of select="count($places)"/>
            </span>
          </a>
          <a href="#sec-opere" class="sec-btn opera">
            <i class="bi bi-book"/>
            Opere
            <span class="badge-count">
              <xsl:value-of select="count($works)"/>
            </span>
          </a>
          <xsl:if test="count($orgs) > 0">
            <a href="#sec-org" class="sec-btn org">
              <i class="bi bi-building"/>
              Organizzazioni
              <span class="badge-count">
                <xsl:value-of select="count($orgs)"/>
              </span>
            </a>
          </xsl:if>
        </nav>
        <main>
          <!--  ════════ SEZIONE PERSONE ════════  -->
          <section class="entity-section sec-pers" id="sec-persone">
            <div class="section-header">
              <div class="section-icon">
                <i class="bi bi-person-fill"/>
              </div>
              <h2>Persone</h2>
              <span style="font-size:.82rem; color:#aaa; margin-left:.5rem;">
                <xsl:value-of select="count($persons)"/>
                voci
              </span>
            </div>
            <div class="entity-grid">
              <xsl:for-each select="$persons">
                <xsl:sort select="tei:persName/tei:surname"/>
                <xsl:call-template name="card-persona"/>
              </xsl:for-each>
            </div>
          </section>
          <hr class="section-sep"/>
          <!--  ════════ SEZIONE LUOGHI ════════  -->
          <section class="entity-section sec-place" id="sec-luoghi">
            <div class="section-header">
              <div class="section-icon">
                <i class="bi bi-geo-alt-fill"/>
              </div>
              <h2>Luoghi</h2>
              <span style="font-size:.82rem; color:#aaa; margin-left:.5rem;">
                <xsl:value-of select="count($places)"/>
                voci
              </span>
            </div>
            <div class="entity-grid">
              <xsl:for-each select="$places">
                <xsl:sort select="tei:placeName[1]"/>
                <xsl:call-template name="card-luogo"/>
              </xsl:for-each>
            </div>
          </section>
          <hr class="section-sep"/>
          <!--  ════════ SEZIONE OPERE ════════  -->
          <section class="entity-section sec-opera" id="sec-opere">
            <div class="section-header">
              <div class="section-icon">
                <i class="bi bi-book-fill"/>
              </div>
              <h2>Opere</h2>
              <span style="font-size:.82rem; color:#aaa; margin-left:.5rem;">
                <xsl:value-of select="count($works)"/>
                voci
              </span>
            </div>
            <div class="entity-grid">
              <xsl:for-each select="$works">
                <xsl:sort select="(.//tei:title[@level='a'] | .//tei:title[@level='m'] | .//tei:title[@level='j'] | .//tei:title)[1]"/>
                <xsl:call-template name="card-opera"/>
              </xsl:for-each>
            </div>
          </section>
          <!--  ════════ SEZIONE ORGANIZZAZIONI (se presenti) ════════  -->
          <xsl:if test="count($orgs) > 0">
            <hr class="section-sep"/>
            <section class="entity-section sec-org" id="sec-org">
              <div class="section-header">
                <div class="section-icon">
                  <i class="bi bi-building"/>
                </div>
                <h2>Organizzazioni</h2>
                <span style="font-size:.82rem; color:#aaa; margin-left:.5rem;">
                  <xsl:value-of select="count($orgs)"/>
                  voci
                </span>
              </div>
              <div class="entity-grid">
                <xsl:for-each select="$orgs">
                  <xsl:sort select="tei:orgName[1]"/>
                  <xsl:call-template name="card-org"/>
                </xsl:for-each>
              </div>
            </section>
          </xsl:if>
        </main>
        <!--  ════════ FOOTER ════════  -->
        <footer class="site-footer">
          <div class="container-fluid px-4">
            <div class="row g-4">
              <div class="col-md-4">
                <div class="footer-logo">COVerLeSS</div>
                <div style="font-size:.76rem; opacity:.7; line-height:1.5; max-width:280px;"> Progetto PRIN PNRR di codifica digitale di testi della letteratura italiana ottocentesca. Edizioni TEI/XML realizzate presso il CNR-ILC. </div>
                <div style="margin-top:.7rem;">
                  <a href="http://chroma.cnr.it/progetti/" target="_blank">
                    <i class="bi bi-box-arrow-up-right"/>
                    Sito del progetto
                  </a>
                </div>
              </div>
              <div class="col-md-4">
                <h6>File authority utilizzati</h6>
                <ul style="list-style:none; padding:0; margin:0; font-size:.8rem; line-height:2;">
                  <li>
                    <i class="bi bi-person" style="color:var(--c-mid);"/>
                    coverlessListPerson.xml
                  </li>
                  <li>
                    <i class="bi bi-geo-alt" style="color:var(--c-mid);"/>
                    coverlessListPlace.xml
                  </li>
                  <li>
                    <i class="bi bi-book" style="color:var(--c-mid);"/>
                    coverlessListWork.xml
                  </li>
                  <li>
                    <i class="bi bi-building" style="color:var(--c-mid);"/>
                    coverlessListOrganisation.xml
                  </li>
                </ul>
              </div>
              <div class="col-md-4">
                <h6>Standard</h6>
                <ul style="list-style:none; padding:0; margin:0; font-size:.8rem; line-height:2;">
                  <li>
                    <i class="bi bi-filetype-xml" style="color:var(--c-mid);"/>
                    TEI P5
                  </li>
                  <li>
                    <i class="bi bi-code-slash" style="color:var(--c-mid);"/>
                    XSLT 2.0 / Saxon HE
                  </li>
                  <li>
                    <i class="bi bi-link-45deg" style="color:var(--c-mid);"/>
                    
                    <a href="https://www.wikidata.org/" target="_blank">Wikidata</a>
                  </li>
                </ul>
              </div>
            </div>
            <hr class="footer-divider"/>
            <div class="footer-bottom">
              Edizione digitale realizzata nell'ambito del corso
              <em>Codifica di Testi</em>
              (CNR-ILC, 2024–2025) · Progetto COVerLeSS · CC BY 4.0
            </div>
          </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"/>
      </body>
    </html>
  </xsl:template>
  <!--  ============================================================
       CARD PERSONA
       Campi attesi in coverlessListPerson.xml:
       <person xml:id="...">
       <persName><forename/><surname/></persName>
       <birth when="YYYY"/><death when="YYYY"/>
       <note type="biografica">...</note>
       <idno type="wikidata">Qnnn</idno>
       </person>
       ============================================================  -->
      <xsl:template match="tei:title/tei:idno" />
  <xsl:template name="card-persona">
    <div class="entity-card pers">
      <div class="card-body-inner">
        <!--  Nome  -->
        <p class="card-name pers">
          <xsl:value-of select="(tei:persName/tei:forename)"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="(tei:persName/tei:surname)"/>
          <!--  Fallback se mancano forename/surname  -->
          <xsl:if test="not(tei:persName/tei:surname) and not(tei:persName/tei:forename)">
            <xsl:value-of select="(tei:persName)"/>
          </xsl:if>
        </p>
        <!--  Date  -->
        <xsl:if test="tei:birth/@when or tei:death/@when">
          <p class="card-dates">
            <i class="bi bi-calendar3"/>
            
            <xsl:if test="tei:birth/@when">
              <xsl:value-of select="substring(tei:birth/@when,1,4)"/>
            </xsl:if>
            <xsl:if test="tei:birth/@when and tei:death/@when"> – </xsl:if>
            <xsl:if test="tei:death/@when">
              <xsl:value-of select="substring(tei:death/@when,1,4)"/>
            </xsl:if>
          </p>
        </xsl:if>
        <!--  Nota biografica  -->
        <xsl:variable name="nota" select="(tei:note[@type='biografica'])"/>
        <xsl:variable name="nota2" select="(tei:note[1])"/>
        <p class="card-note">
          <xsl:choose>
            <xsl:when test="$nota != ''">
              <xsl:value-of select="$nota"/>
            </xsl:when>
            <xsl:when test="$nota2 != ''">
              <xsl:value-of select="$nota2"/>
            </xsl:when>
            <xsl:otherwise>
              <em style="opacity:.4;">Nessuna nota disponibile.</em>
            </xsl:otherwise>
          </xsl:choose>
        </p>
      </div>
      <!--  Footer card con xml:id e link Wikidata  -->
      <div class="card-footer-inner">
        <span class="card-tag">
          <i class="bi bi-hash"/>
          <xsl:value-of select="@xml:id"/>
        </span>
        <xsl:if test="tei:idno[@type='wikidata'] != ''">
          <a class="wikidata-link" href="https://www.wikidata.org/wiki/{(tei:idno[@type='wikidata'])}" target="_blank" title="Apri su Wikidata">
            <i class="bi bi-box-arrow-up-right"/>
            Wikidata
          </a>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  <!--  ============================================================
       CARD LUOGO
       Campi attesi in coverlessListPlace.xml:
       <place xml:id="...">
       <placeName>...</placeName>
       <location><country/><region/></location>
       <note>...</note>
       <idno type="wikidata">Qnnn</idno>
       </place>
       ============================================================  -->
  <xsl:template name="card-luogo">
    <div class="entity-card place">
      <div class="card-body-inner">
        <p class="card-name place">
          <xsl:value-of select="(tei:placeName[1])"/>
        </p>
        <!--  Localizzazione  -->
        <xsl:if test="tei:location/tei:country or tei:location/tei:region">
          <p class="card-dates">
            <i class="bi bi-globe2"/>
            
            <xsl:if test="tei:location/tei:region">
              <xsl:value-of select="(tei:location/tei:region)"/>
            </xsl:if>
            <xsl:if test="tei:location/tei:region and tei:location/tei:country">, </xsl:if>
            <xsl:if test="tei:location/tei:country">
              <xsl:value-of select="(tei:location/tei:country)"/>
            </xsl:if>
          </p>
        </xsl:if>
        <!--  Coordinate geografiche  -->
        <xsl:if test="tei:location/tei:geo">
          <p class="card-dates">
            <i class="bi bi-pin-map"/>
            
            <xsl:value-of select="(tei:location/tei:geo)"/>
          </p>
        </xsl:if>
        <!--  Nota  -->
        <xsl:variable name="nota" select="(tei:note)"/>
        <xsl:if test="$nota != ''">
          <p class="card-note">
            <xsl:value-of select="$nota"/>
          </p>
        </xsl:if>
      </div>
      <div class="card-footer-inner">
        <span class="card-tag">
          <i class="bi bi-hash"/>
          <xsl:value-of select="@xml:id"/>
        </span>
        <xsl:if test="tei:idno[@type='wikidata'] != ''">
          <a class="wikidata-link" href="https://www.wikidata.org/wiki/{(tei:idno[@type='wikidata'])}" target="_blank">
            <i class="bi bi-box-arrow-up-right"/>
            Wikidata
          </a>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  <!--  ============================================================
       CARD OPERA
       Campi attesi in coverlessListWork.xml:
       <biblStruct xml:id="...">
       <analytic><title level="a"/><author/></analytic>
       <monogr>
       <title level="m" or "j"/>
       <imprint><date/><pubPlace/><publisher/></imprint>
       </monogr>
       <series><title/></series>
       <note>...</note>
       <idno type="wikidata">Qnnn</idno>
       </biblStruct>
       ============================================================  -->
  <xsl:template name="card-opera">
    <!--  Determina il titolo principale da mostrare  -->
    <xsl:variable name="titolo">
      <xsl:choose>
        <xsl:when test=".//tei:title[@level='a']">
          <xsl:value-of select="(.//tei:title[@level='a'][1])"/>
        </xsl:when>
        <xsl:when test=".//tei:title[@level='m']">
          <xsl:value-of select="(.//tei:title[@level='m'][1])"/>
        </xsl:when>
        <xsl:when test=".//tei:title[@level='j']">
          <xsl:value-of select="(.//tei:title[@level='j'][1])"/>
        </xsl:when>
        <xsl:when test=".//tei:title[@level='s']">
          <xsl:value-of select="(.//tei:title[@level='s'][1])"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="(.//tei:title[1])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--  Tipo opera dalla gerarchia present  -->
    <xsl:variable name="tipo">
      <xsl:choose>
        <xsl:when test=".//tei:title[@level='j']">Periodico</xsl:when>
        <xsl:when test=".//tei:title[@level='a']">Articolo</xsl:when>
        <xsl:when test=".//tei:title[@level='s']">Serie</xsl:when>
        <xsl:when test=".//tei:title[@level='m']">Monografia</xsl:when>
        <xsl:otherwise>Opera</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <div class="entity-card opera">
      <div class="card-body-inner">
        <p class="card-name opera">
          <xsl:value-of select="$titolo"/>
        </p>
        <!--  Autore  -->
        <xsl:if test=".//tei:author != ''">
          <p class="card-dates">
            <i class="bi bi-person-lines-fill"/>
            
            <xsl:value-of select="(.//tei:author[1])"/>
          </p>
        </xsl:if>
        <!--  Data e luogo  -->
        <xsl:if test=".//tei:date or .//tei:pubPlace">
          <p class="card-dates">
            <i class="bi bi-calendar3"/>
            
            <xsl:value-of select="(.//tei:pubPlace[1])"/>
            <xsl:if test=".//tei:pubPlace and .//tei:date">, </xsl:if>
            <xsl:value-of select="(.//tei:date[1])"/>
          </p>
        </xsl:if>
        <!--  Titolo della rivista contenitore (per articoli)  -->
        <xsl:if test=".//tei:title[@level='a'] and .//tei:title[@level='j']">
          <p class="card-dates">
            <i class="bi bi-journal"/>
            
            <em>
              <xsl:value-of select="(.//tei:title[@level='j'])"/>
            </em>
          </p>
        </xsl:if>
        <!--  Serie  -->
        <xsl:if test=".//tei:title[@level='s']">
          <p class="card-dates">
            <i class="bi bi-collection"/>
            
            <xsl:value-of select="(.//tei:title[@level='s'])"/>
          </p>
        </xsl:if>
        <!--  Nota  -->
        <xsl:variable name="nota" select="(tei:note)"/>
        <xsl:if test="$nota != ''">
          <p class="card-note">
            <xsl:value-of select="$nota"/>
          </p>
        </xsl:if>
      </div>
      <div class="card-footer-inner">
        <span class="card-tag">
          <i class="bi bi-hash"/>
          <xsl:value-of select="@xml:id"/>
        </span>
        <span class="card-tag" style="font-style:normal;">
          <xsl:value-of select="$tipo"/>
        </span>
        <xsl:if test="tei:idno[@type='wikidata'] != ''">
          <a class="wikidata-link" href="https://www.wikidata.org/wiki/{(tei:idno[@type='wikidata'])}" target="_blank">
            <i class="bi bi-box-arrow-up-right"/>
            Wikidata
          </a>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  <!--  ============================================================
       CARD ORGANIZZAZIONE
       Campi attesi in coverlessListOrganisation.xml:
       <org xml:id="...">
       <orgName>...</orgName>
       <note>...</note>
       <idno type="wikidata">Qnnn</idno>
       </org>
       ============================================================  -->
  <xsl:template name="card-org">
    <div class="entity-card org">
      <div class="card-body-inner">
        <p class="card-name org">
          <xsl:value-of select="(tei:orgName[1])"/>
        </p>
        <xsl:if test="tei:desc or tei:note">
          <p class="card-note">
            <xsl:value-of select="((tei:desc | tei:note)[1])"/>
          </p>
        </xsl:if>
      </div>
      <div class="card-footer-inner">
        <span class="card-tag">
          <i class="bi bi-hash"/>
          <xsl:value-of select="@xml:id"/>
        </span>
        <xsl:if test="tei:idno[@type='wikidata'] != ''">
          <a class="wikidata-link" href="https://www.wikidata.org/wiki/{(tei:idno[@type='wikidata'])}" target="_blank">
            <i class="bi bi-box-arrow-up-right"/>
            Wikidata
          </a>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
 
</xsl:stylesheet>