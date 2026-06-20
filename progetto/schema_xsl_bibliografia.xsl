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
        <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English:ital@0;1&amp;family=EB+Garamond:ital,wght@0,400;0,600;1,400&amp;display=swap" rel="stylesheet"/>
        <style> /* ── Token system ── */ :root { --c-bg: #faf8f4; --c-surface: #ffffff; --c-mid: #c8b89a; --c-dark: #5c4a2a; --c-ink: #2a2017; --c-accent: #8b3a1a; --c-note: #f5f0e8; /* Colori per categoria */ --c-pers: #c97d3a; --c-pers-bg: #fdf0e3; --c-pers-brd: #e8c49a; --c-place: #4a7c59; --c-place-bg: #eaf3ed; --c-place-brd:#b8d9c4; --c-opera: #6b3fa0; --c-opera-bg: #f2ecfa; --c-opera-brd:#d0bcee; --c-org: #2d6a8f; --c-org-bg: #e6f2f9; --c-org-brd: #aad4ee; } html { scroll-behavior: smooth; } body { background: var(--c-bg); color: var(--c-ink); font-family: 'EB Garamond', Georgia, serif; font-size: 1.05rem; } /* ── HEADER ── */ .site-header { background: var(--c-dark); color: #f0ebe0; border-bottom: 3px solid var(--c-accent); } .site-header .header-inner { display: grid; grid-template-columns: auto 1fr auto; align-items: center; gap: 1.5rem; padding: 1rem 2rem; } .project-badge { font-size: .72rem; letter-spacing: .14em; text-transform: uppercase; opacity: .65; font-family: 'EB Garamond', serif; } .project-badge strong { display: block; color: var(--c-mid); font-size: .9em; } .doc-title { font-family: 'IM Fell English', serif; font-size: 1.5rem; font-weight: 400; margin: 0; text-align: center; letter-spacing: .02em; } .doc-meta { font-size: .76rem; opacity: .65; text-align: right; } .doc-meta span { display: block; } .header-sub { background: #3d2e10; padding: .4rem 2rem; font-size: .76rem; color: #b8a888; display: flex; flex-wrap: wrap; gap: 1rem; align-items: center; } /* ── NAV PILLS (tab sezioni) ── */ .section-nav { background: var(--c-note); border-bottom: 2px solid var(--c-mid); padding: .6rem 2rem; position: sticky; top: 0; z-index: 100; display: flex; flex-wrap: wrap; gap: .5rem; align-items: center; } .section-nav .nav-label { font-size: .72rem; text-transform: uppercase; letter-spacing: .1em; color: var(--c-dark); margin-right: .5rem; opacity: .7; } .sec-btn { display: inline-flex; align-items: center; gap: .35rem; padding: .3rem .85rem; border-radius: 20px; font-size: .82rem; text-decoration: none; font-family: 'EB Garamond', serif; border: 1.5px solid; transition: all .18s; } .sec-btn.pers { color:var(--c-pers); background:var(--c-pers-bg); border-color:var(--c-pers-brd); } .sec-btn.place { color:var(--c-place); background:var(--c-place-bg); border-color:var(--c-place-brd); } .sec-btn.opera { color:var(--c-opera); background:var(--c-opera-bg); border-color:var(--c-opera-brd); } .sec-btn.org { color:var(--c-org); background:var(--c-org-bg); border-color:var(--c-org-brd); } .sec-btn:hover { filter: brightness(.92); } .sec-btn .badge-count { background: currentColor; color: #fff; border-radius: 10px; padding: .05rem .4rem; font-size: .7rem; } /* ── SEZIONI ── */ .entity-section { padding: 2.5rem 2rem 1rem; scroll-margin-top: 56px; } .section-header { display: flex; align-items: center; gap: .8rem; margin-bottom: 1.5rem; padding-bottom: .6rem; border-bottom: 2px solid; } .section-header h2 { font-family: 'IM Fell English', serif; font-size: 1.5rem; font-weight: 400; margin: 0; } .section-header .section-icon { width: 2.2rem; height: 2.2rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1rem; flex-shrink: 0; } /* colori per sezione */ .sec-pers .section-header { border-color: var(--c-pers-brd); } .sec-pers .section-header h2 { color: var(--c-pers); } .sec-pers .section-header .section-icon { background:var(--c-pers-bg); color:var(--c-pers); } .sec-place .section-header { border-color: var(--c-place-brd); } .sec-place .section-header h2 { color: var(--c-place); } .sec-place .section-header .section-icon { background:var(--c-place-bg); color:var(--c-place); } .sec-opera .section-header { border-color: var(--c-opera-brd); } .sec-opera .section-header h2 { color: var(--c-opera); } .sec-opera .section-header .section-icon { background:var(--c-opera-bg); color:var(--c-opera); } .sec-org .section-header { border-color: var(--c-org-brd); } .sec-org .section-header h2 { color: var(--c-org); } .sec-org .section-header .section-icon { background:var(--c-org-bg); color:var(--c-org); } /* ── GRIGLIA CARD ── */ .entity-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1rem; } /* ── CARD GENERICA ── */ .entity-card { background: var(--c-surface); border-radius: 6px; box-shadow: 0 1px 4px rgba(0,0,0,.06); border-top: 3px solid; overflow: hidden; display: flex; flex-direction: column; transition: box-shadow .18s, transform .18s; } .entity-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,.11); transform: translateY(-2px); } .entity-card.pers { border-color: var(--c-pers); } .entity-card.place { border-color: var(--c-place); } .entity-card.opera { border-color: var(--c-opera); } .entity-card.org { border-color: var(--c-org); } .card-body-inner { padding: 1rem 1.1rem; flex: 1; } .card-name { font-family: 'IM Fell English', serif; font-size: 1.1rem; margin: 0 0 .35rem; line-height: 1.25; } .card-name.pers { color: var(--c-pers); } .card-name.place { color: var(--c-place); } .card-name.opera { color: var(--c-opera); font-style: italic; } .card-name.org { color: var(--c-org); } .card-dates { font-size: .78rem; color: #888; margin-bottom: .5rem; } .card-note { font-size: .88rem; color: var(--c-ink); line-height: 1.55; opacity: .85; } .card-footer-inner { padding: .5rem 1.1rem; background: var(--c-note); border-top: 1px solid #ede7da; font-size: .76rem; color: #888; display: flex; flex-wrap: wrap; gap: .4rem; } .card-tag { background: #fff; border: 1px solid var(--c-mid); border-radius: 10px; padding: .05rem .5rem; font-size: .72rem; } .wikidata-link { margin-left: auto; color: #888; text-decoration: none; font-size: .72rem; } .wikidata-link:hover { color: var(--c-accent); } /* ── Separatore sezione ── */ .section-sep { border: none; border-top: 1px dashed var(--c-mid); margin: 0 2rem; opacity: .5; } /* ── FOOTER ── */ .site-footer { background: var(--c-dark); color: #a89878; border-top: 3px solid var(--c-accent); padding: 2rem 0 1rem; font-size: .8rem; margin-top: 2rem; } .site-footer .footer-logo { font-family: 'IM Fell English', serif; font-size: 1.1rem; color: #e8e0d0; margin-bottom: .3rem; } .site-footer h6 { color: #c8b89a; font-size: .72rem; letter-spacing: .1em; text-transform: uppercase; margin-bottom: .6rem; } .site-footer a { color: #a89878; text-decoration: none; } .site-footer a:hover { color: #e8d8b8; } .footer-divider { border-color: #3d2e10; margin: 1rem 0 .6rem; } .footer-bottom { font-size: .72rem; opacity: .45; text-align: center; } </style>
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