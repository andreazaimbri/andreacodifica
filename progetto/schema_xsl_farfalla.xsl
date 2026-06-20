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
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
        <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English:ital@0;1&amp;family=EB+Garamond:ital,wght@0,400;0,600;1,400&amp;display=swap" rel="stylesheet"/>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous"/>
          <link rel="stylesheet" href="style.css"/>
          <style> /* ── Variabili base ── */ :root { --warm-bg: #faf8f4; --warm-mid: #c8b89a; --warm-dark: #5c4a2a; --ink: #2a2017; --accent: #8b3a1a; --note-bg: #f5f0e8; } body { background: var(--warm-bg); color: var(--ink); font-family: 'EB Garamond', Georgia, serif; font-size: 1.05rem; } /* ── Testata ── */ header { background: var(--warm-dark); color: #f0ebe0; text-align: center; padding: 2rem 1rem 1.5rem; } header h1 { font-family: 'IM Fell English', serif; font-size: 1.9rem; letter-spacing: .04em; margin: 0; } .header-label { font-size: .78rem; letter-spacing: .12em; text-transform: uppercase; opacity: .75; margin-bottom: .5rem; } .meta { font-size: .88rem; opacity: .85; margin-top: .6rem; } /* ── Tab bar ── */ nav.tabs { display: flex; gap: .25rem; padding: .5rem 1rem; background: #ede7da; border-bottom: 2px solid var(--warm-mid); } nav.tabs button { background: transparent; border: 1px solid transparent; padding: .35rem .9rem; border-radius: 4px 4px 0 0; font-family: inherit; font-size: .88rem; cursor: pointer; color: var(--warm-dark); } nav.tabs button.active { background: var(--warm-bg); border-color: var(--warm-mid) var(--warm-mid) var(--warm-bg); font-weight: 600; } /* ── Viste ── */ .view { display: none; } .view.active { display: block; } main { max-width: 1100px; margin: 0 auto; padding: 1.5rem 1rem 3rem; } /* ── Toolbar lettura ── */ .reading-toolbar { background: var(--note-bg); border: 1px solid var(--warm-mid); border-radius: 4px; padding: .45rem 1rem; margin-bottom: 1.2rem; font-size: .85rem; display: flex; flex-wrap: wrap; gap: .8rem; align-items: center; } /* ── Vista parallela ── */ .page-block { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2.5rem; border-bottom: 1px dashed var(--warm-mid); padding-bottom: 2rem; } @media (max-width: 768px) { .page-block { grid-template-columns: 1fr; } } .facs-col img { width: 100%; border: 1px solid var(--warm-mid); border-radius: 3px; cursor: zoom-in; } .page-label { font-size: .75rem; text-transform: uppercase; letter-spacing: .1em; color: var(--warm-dark); margin-bottom: .4rem; opacity: .8; } /* ── Articolo ── */ .article-head-main { font-family: 'IM Fell English', serif; font-size: 1.5rem; text-align: center; letter-spacing: .06em; text-transform: uppercase; margin: 1rem 0 .2rem; } .article-head-sub { font-size: .95rem; text-align: center; font-style: italic; margin: .2rem 0; color: var(--warm-dark); } .article-head-fonte { font-size: .82rem; text-align: center; color: var(--warm-dark); font-style: italic; margin: .2rem 0 .8rem; } .section-divider { border: none; border-top: 1px solid var(--warm-mid); margin: .6rem auto; width: 60%; } .div-head-section { font-family: 'IM Fell English', serif; font-size: 1.1rem; text-align: center; text-transform: uppercase; margin: 1.4rem 0 .6rem; letter-spacing: .05em; } .letter-p { text-align: justify; line-height: 1.75; margin-bottom: .7rem; } .firstline-indented { text-indent: 1.5em; } .initial-cap { float: left; font-size: 3.2rem; line-height: 1; margin: .05em .12em 0 0; font-family: 'IM Fell English', serif; color: var(--warm-dark); } /* ── Entità semantiche ── */ .pers-name { border-bottom: 1px dashed var(--accent); cursor: help; color: var(--ink); } .place-name { border-bottom: 1px dotted #5a7a3a; } .title-ref { font-style: italic; } .term-hl { color: var(--warm-dark); font-style: italic; } .foreign-w { font-style: italic; } .distinct-w { color: #6b4c10; } .unclear { text-decoration: underline dotted #999; } .supplied { color: #555; } .supplied::before { content: '['; font-size: .8em; } .supplied::after { content: ']'; font-size: .8em; } /* ── choice orig/reg ── */ .orig { display: none; } body.show-orig .reg { display: none; } body.show-orig .orig { display: inline; color: #7a5020; font-style: italic; } /* ── Citazioni ── */ .quote-block { margin: .8rem 2rem; padding: .5rem 1rem; border-left: 3px solid var(--warm-mid); font-style: italic; color: #3d2e10; } .inline-q { font-style: italic; } .inline-q::before { content: '\00AB\00A0'; } .inline-q::after { content: '\00A0\00BB'; } /* ── Nota editoriale in-testo ── */ .nota-ed-ptr { vertical-align: super; font-size: .72rem; color: var(--accent); font-weight: 600; } /* ── Trailer ── */ .trailer { text-align: center; font-style: italic; margin: 1rem 0; color: var(--warm-dark); } /* ── Back / note a piè di pagina ── */ .back-section { margin-top: 2.5rem; border-top: 2px solid var(--warm-mid); padding-top: 1rem; } .back-section h2 { font-size: 1rem; font-variant: small-caps; letter-spacing: .05em; color: var(--warm-dark); } .footnote-item { font-size: .88rem; margin-bottom: .8rem; line-height: 1.6; } .footnote-label { font-weight: 600; margin-right: .4rem; color: var(--accent); } /* ── Scheda catalografica ── */ .scheda-card { background: #fff; border: 1px solid var(--warm-mid); border-radius: 6px; padding: 1.2rem 1.5rem; margin-bottom: 1.4rem; box-shadow: 0 1px 4px rgba(0,0,0,.06); } .scheda-card h2 { font-size: 1.05rem; font-variant: small-caps; letter-spacing: .06em; color: var(--warm-dark); border-bottom: 1px solid var(--warm-mid); padding-bottom: .35rem; margin-bottom: .8rem; } .scheda-body { display: grid; grid-template-columns: auto 1fr; gap: .3rem .8rem; } .scheda-label { font-weight: 600; font-size: .87rem; color: var(--warm-dark); white-space: nowrap; padding-top: .15rem; } .scheda-val { font-size: .92rem; line-height: 1.5; } .scheda-val.full { grid-column: 1 / -1; } .kw-list { display: flex; flex-wrap: wrap; gap: .35rem; margin: 0; padding: 0; list-style: none; } .kw-pill { background: var(--note-bg); border: 1px solid var(--warm-mid); border-radius: 12px; padding: .15rem .65rem; font-size: .8rem; color: var(--warm-dark); } /* ── Footer ── */ footer { background: var(--warm-dark); color: #d8cfc0; text-align: center; font-size: .8rem; padding: 1rem; } /* ── Lightbox ── */ #lightbox { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.85); z-index: 1000; justify-content: center; align-items: center; } #lightbox.open { display: flex; } #lightbox img { max-width: 90vw; max-height: 90vh; border: 3px solid #fff; border-radius: 3px; } #lightbox-close { position: fixed; top: 1rem; right: 1.5rem; color: #fff; font-size: 2rem; cursor: pointer; } /* ── Tooltip persone ── */ .pers-name[data-bio]:hover::after { content: attr(data-bio); position: absolute; left: 0; top: 1.5em; background: #fff8ee; border: 1px solid var(--warm-mid); padding: .4rem .7rem; border-radius: 4px; font-size: .82rem; max-width: 280px; z-index: 50; color: var(--ink); box-shadow: 0 2px 8px rgba(0,0,0,.15); } .pers-name { position: relative; } </style>
        </head>
      <body>
        <!--  HEADER  -->
        <header>
          <p class="header-label">
            Edizione digitale · Progetto COVerLeSS ·
            <em>La Farfalla</em>
            , Cagliari
          </p>
          <h1>
            <xsl:value-of select="//tei:biblStruct/tei:analytic/tei:title[@level='a']"/>
          </h1>
          <p class="meta">
            <xsl:value-of select="//tei:imprint/tei:pubPlace"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="//tei:imprint/tei:date"/>
            <xsl:if test="//tei:biblScope[@unit='volume']">
              <xsl:text> · vol. </xsl:text>
              <xsl:value-of select="//tei:biblScope[@unit='volume']"/>
              <xsl:text>, n. </xsl:text>
              <xsl:value-of select="//tei:biblScope[@unit='issue']"/>
              <xsl:text>, pp. </xsl:text>
              <xsl:value-of select="//tei:biblScope[@unit='page']"/>
            </xsl:if>
          </p>
        </header>
        <!--  TAB BAR  -->
        <nav class="tabs" role="tablist">
          <button class="active" onclick="switchView('parallel', this)" role="tab">Facsimile + Testo</button>
          <button onclick="switchView('text', this)" role="tab">Solo testo</button>
          <button onclick="switchView('scheda', this)" role="tab">Scheda</button>
        </nav>
        <main>
          <!--  TOOLBAR LETTURA  -->
          <div class="reading-toolbar">
            <span>Opzioni di lettura:</span>
            <label>
              <input type="checkbox" id="toggle-orig" onchange="toggleOrig(this)"/>
              Mostra forme originali (
              <em>orig</em>
              /
              <em>abbr</em>
              )
            </label>
          </div>
          <!--  ==================== VIEW 1: PARALLELA ====================  -->
          <div id="view-parallel" class="view active">
            <xsl:apply-templates select="//tei:facsimile/tei:surface" mode="parallel"/>
          </div>
          <!--  ==================== VIEW 2: SOLO TESTO ====================  -->
          <div id="view-text" class="view">
            <xsl:apply-templates select="//tei:text/tei:body" mode="article"/>
            <xsl:apply-templates select="//tei:text/tei:back" mode="article"/>
          </div>
          <!--  ==================== VIEW 3: SCHEDA ====================  -->
          <div id="view-scheda" class="view">
            <xsl:call-template name="scheda"/>
          </div>
        </main>
        <!--  FOOTER  -->
        <footer>
          Edizione TEI/XSLT · Progetto PRIN PNRR COVerLeSS · File:
          <xsl:value-of select="//tei:idno[@type='fileName']"/>
        </footer>
        <!--  LIGHTBOX  -->
        <div id="lightbox" onclick="closeLightbox()">
          <span id="lightbox-close" onclick="closeLightbox()">×</span>
          <img id="lightbox-img" src="" alt="Facsimile ingrandito"/>
        </div>
        <!--  JAVASCRIPT  -->
        <script> function switchView(id, btn) { document.querySelectorAll('.view').forEach(v => v.classList.remove('active')); document.getElementById('view-' + id).classList.add('active'); document.querySelectorAll('nav.tabs button').forEach(b => b.classList.remove('active')); btn.classList.add('active'); } function toggleOrig(cb) { document.body.classList.toggle('show-orig', cb.checked); } function openLightbox(src) { document.getElementById('lightbox-img').src = src; document.getElementById('lightbox').classList.add('open'); } function closeLightbox() { document.getElementById('lightbox').classList.remove('open'); } document.addEventListener('keydown', e => { if (e.key === 'Escape') closeLightbox(); }); document.querySelectorAll('.facs-col img').forEach(img => { img.addEventListener('click', () => openLightbox(img.src)); }); </script>
      </body>
    </html>
  </xsl:template>
  <!--  ============================================================
       MODE: PARALLEL  — facsimile + testo per pagina
       Strategia: ogni <surface xml:id="pag_N_surface"> corrisponde
       al <pb xml:id="Farfalla_..._N">. Raccogliamo tutti i <div>
       top-level del body che sono compresi tra quel <pb> e il
       successivo, usando i <pb> come separatori di pagina.
       ============================================================  -->
  <!--  ============================================================
       MODE: PARALLEL — facsimile + testo per pagina
       Ogni <surface> ha una o più <zone>; i <cb> puntano alle zone
       tramite @facs="#zone_id". Raccogliamo i cb per zone_id,
       poi per ciascun cb selezioniamo i <p> che appartengono
       a quella colonna tramite preceding::tei:cb[1].
       ============================================================  -->
  <xsl:template match="tei:surface" mode="parallel">
    <xsl:variable name="surfId" select="@xml:id"/>
    <xsl:variable name="imgUrl" select="tei:graphic/@url"/>
    <div class="page-block" id="par-{$surfId}">
      <!--  Colonna sinistra: facsimile  -->
      <div class="facs-col">
        <p class="page-label">Pagina — facsimile</p>
        <xsl:choose>
          <xsl:when test="$imgUrl != ''">
            <img src="{$imgUrl}" alt="Facsimile {$surfId}" loading="lazy"/>
          </xsl:when> 
          <xsl:otherwise>
            <p style="color:#666;font-size:.8rem;margin-top:2rem;">[immagine non disponibile]</p>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <!--  Colonna destra: testo, un blocco per ogni zone/cb  -->
      <div class="text-col">
        <p class="page-label">Pagina — trascrizione</p>
        <!-- 
             Per ogni <zone> di questa surface, cerchiamo il <cb>
             il cui @facs="#zone_xml_id" e lo processiamo.
        -->
        <xsl:for-each select="tei:zone">
          <xsl:variable name="zoneId" select="@xml:id"/>
          <xsl:apply-templates select="//tei:cb[@facs = concat('#', $zoneId)]" mode="parallel-col"/>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>
  <!-- 
       mode="parallel-col": per ogni <cb> stampa i <p> e <head>
       che appartengono alla sua colonna.
       Un nodo appartiene a questo cb se:
       a) contiene il cb al suo interno (paragrafo spezzato dal cambio col.)
       b) il suo preceding::tei:cb[1] — il cb precedente più vicino
       nel documento — è proprio questo cb.
  -->
  <xsl:template match="tei:cb" mode="parallel-col">
    <xsl:variable name="thisCbId" select="generate-id(.)"/>
    <div class="col-block" style="margin-bottom:.6rem;">
      <span style="font-size:.7rem;color:#aaa;display:block;margin-bottom:.25rem;">
        [col.
        <xsl:value-of select="@n"/>
        ]
      </span>
      <!--  head di sezione il cui cb precedente più vicino è questo  -->
      <xsl:for-each select="//tei:body//tei:head[ generate-id(preceding::tei:cb[1]) = $thisCbId ]">
        <xsl:apply-templates select="." mode="article"/>
      </xsl:for-each>
      <!--  paragrafi: contengono il cb, oppure il loro cb precedente è questo  -->
      <xsl:for-each select="//tei:body//tei:p[ .//tei:cb[generate-id(.) = $thisCbId] or generate-id(preceding::tei:cb[1]) = $thisCbId ]">
        <xsl:apply-templates select="." mode="article"/>
      </xsl:for-each>
    </div>
  </xsl:template>
  <!--  ============================================================
       MODE: ARTICLE  — rendering di tutto il body
       ============================================================  -->
  <!--  body: itera i figli principali  -->
  <xsl:template match="tei:body" mode="article">
    <xsl:apply-templates mode="article"/>
  </xsl:template>
  <!--  back: note editoriali  -->
  <xsl:template match="tei:back" mode="article">
    <div class="back-section">
      <h2>Note editoriali</h2>
      <xsl:apply-templates select=".//tei:item[tei:note]" mode="back-note"/>
    </div>
  </xsl:template>
  <xsl:template match="tei:item" mode="back-note">
    <div class="footnote-item">
      <span class="footnote-label">
        <xsl:value-of select="tei:note/@n"/>
      </span>
      <xsl:apply-templates select="tei:note/tei:ab" mode="article"/>
    </div>
  </xsl:template>
  <!--  ── DIV tipologizzati ──  -->
  <!--  intestazione  -->
  <xsl:template match="tei:div[@type='intestazione']" mode="article">
    <div class="article-intestazione" style="margin-bottom:1rem;">
      <xsl:apply-templates mode="article"/>
    </div>
  </xsl:template>
  <!--  abstract  -->
  <xsl:template match="tei:div[@type='abstract']" mode="article">
    <div class="article-abstract" style="margin-bottom:1.2rem;">
      <xsl:apply-templates mode="article"/>
    </div>
  </xsl:template>
  <!--  article / text2 / translation / editorial  -->
  <xsl:template match="tei:div[@type='article' or @type='text2' or @type='translation' or @type='editorial']" mode="article">
    <div class="article-section" style="margin-bottom:1rem;">
      <xsl:apply-templates mode="article"/>
    </div>
  </xsl:template>
  <!--  div generici annidati  -->
  <xsl:template match="tei:div" mode="article">
    <div>
      <xsl:apply-templates mode="article"/>
    </div>
  </xsl:template>
  <!--  ── Testata articolo ──  -->
  <xsl:template match="tei:head[@type='main']" mode="article">
    <h2 class="article-head-main">
      <xsl:apply-templates mode="article"/>
    </h2>
  </xsl:template>
  <xsl:template match="tei:head[@type='subtitle' or @type='title']" mode="article">
    <p class="article-head-sub">
      <xsl:apply-templates mode="article"/>
    </p>
  </xsl:template>
  <xsl:template match="tei:head" mode="article">
    <p class="article-head-sub">
      <xsl:apply-templates mode="article"/>
    </p>
  </xsl:template>
  <!--  metamark separatore  -->
  <xsl:template match="tei:metamark[@function='sectionDivider' or @function='section_divider']" mode="article">
    <hr class="section-divider"/>
  </xsl:template>
  <xsl:template match="tei:metamark" mode="article"/>
  <!--  ── Paragrafi ──  -->
  <xsl:template match="tei:p" mode="article">
    <xsl:variable name="cls">
      <xsl:text>letter-p</xsl:text>
      <xsl:if test="@rend='firstline-indented'"> firstline-indented</xsl:if>
    </xsl:variable>
    <p class="{$cls}">
      <xsl:apply-templates mode="article"/>
    </p>
  </xsl:template>
  <!--  ── fw (numerazione pagina) — soppressa nella vista testo ──  -->
  <xsl:template match="tei:fw" mode="article">
    <span style="font-size:.7rem; color:#bbb; font-style:normal;">
      [
      <xsl:apply-templates mode="article"/>
      ]
    </span>
  </xsl:template>
  <!--  pb e cb: indicatore discreto  -->
  <xsl:template match="tei:pb" mode="article">
    <span style="font-size:.68rem; color:#ccc; display:block; margin:.3rem 0;">
      ⟨p.
      <xsl:value-of select="@n"/>
      ⟩
    </span>
  </xsl:template>
  <xsl:template match="tei:cb" mode="article"/>
  <!--  ── Entità semantiche ──  -->
  <!--  persName con @ref (priorità alta)  -->
  <xsl:template match="tei:persName[@ref]" mode="article" priority="2">
    <span class="pers-name" data-bio="{@ref}">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  persName senza @ref  -->
  <xsl:template match="tei:persName" mode="article" priority="1">
    <span class="pers-name">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  name con @ref (es. <name type="person" ref="..."> o <name type="epithet" ref="...">)  -->
  <xsl:template match="tei:name[@ref]" mode="article" priority="2">
    <span class="pers-name" data-bio="{@ref}">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  name con @type="person" senza @ref  -->
  <xsl:template match="tei:name[@type='person']" mode="article" priority="1">
    <span class="pers-name">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  placeName  -->
  <xsl:template match="tei:placeName" mode="article">
    <span class="place-name">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  orgName  -->
  <xsl:template match="tei:orgName" mode="article">
    <span style="font-variant: small-caps;">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  title  -->
  <xsl:template match="tei:title" mode="article">
    <span class="title-ref">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  term  -->
  <xsl:template match="tei:term" mode="article">
    <span class="term-hl" title="{@type}/{@subtype}">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  foreign  -->
  <xsl:template match="tei:foreign" mode="article">
    <span class="foreign-w" lang="{@xml:lang}">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  distinct (forme marcate)  -->
  <xsl:template match="tei:distinct" mode="article">
    <span class="distinct-w" title="forma distinta">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  orig/reg (choice)  -->
  <xsl:template match="tei:choice[tei:orig or tei:reg]" mode="article">
    <span class="choice-wrap" title="Originale: {tei:orig}">
      <span class="reg">
        <xsl:value-of select="tei:reg"/>
      </span>
      <span class="orig">
        <xsl:value-of select="tei:orig"/>
      </span>
    </span>
  </xsl:template>
  <!--  abbr/expan (choice)  -->
  <xsl:template match="tei:choice[tei:abbr or tei:expan]" mode="article">
    <span class="choice-wrap" title="Abbreviazione: {tei:abbr}">
      <span class="reg">
        <xsl:value-of select="tei:expan"/>
      </span>
      <span class="orig">
        <xsl:value-of select="tei:abbr"/>
      </span>
    </span>
  </xsl:template>
  <!--  orig senza choice  -->
  <xsl:template match="tei:orig[not(parent::tei:choice)]" mode="article">
    <span class="choice-wrap">
      <span class="reg">
        <xsl:apply-templates mode="article"/>
      </span>
      <span class="orig">
        <xsl:apply-templates mode="article"/>
      </span>
    </span>
  </xsl:template>
  <!--  unclear  -->
  <xsl:template match="tei:unclear" mode="article">
    <span class="unclear" title="Lettura incerta">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  supplied  -->
  <xsl:template match="tei:supplied" mode="article">
    <span class="supplied">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  hi  -->
  <xsl:template match="tei:hi" mode="article">
    <xsl:choose>
      <xsl:when test="@rend='italic'">
        <em>
          <xsl:apply-templates mode="article"/>
        </em>
      </xsl:when>
      <xsl:when test="@rend='initial-cap'">
        <span class="initial-cap">
          <xsl:apply-templates mode="article"/>
        </span>
      </xsl:when>
      <xsl:when test="@rend='capital_letter'">
        <span class="initial-cap">
          <xsl:apply-templates mode="article"/>
        </span>
      </xsl:when>
      <xsl:when test="@rend='uppercase'">
        <span style="text-transform:uppercase;">
          <xsl:apply-templates mode="article"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:apply-templates mode="article"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  add (interventi a matita ecc.)  -->
  <xsl:template match="tei:add" mode="article">
    <sup style="font-size:.72rem; color:#888;">
      [
      <xsl:apply-templates mode="article"/>
      ]
    </sup>
  </xsl:template>
  <!--  ── Citazioni ──  -->
  <!--  quote (blocco)  -->
  <xsl:template match="tei:quote" mode="article">
    <blockquote class="quote-block">
      <xsl:apply-templates mode="article"/>
    </blockquote>
  </xsl:template>
  <!--  q (inline)  -->
  <xsl:template match="tei:q" mode="article">
    <span class="inline-q">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  seg (nota editoriale inline)  -->
  <xsl:template match="tei:seg[@type='notaEditoriale']" mode="article">
    <span class="nota-ed">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  ptr (rimando a nota)  -->
  <xsl:template match="tei:ptr" mode="article">
    <xsl:variable name="n" select="@n"/>
    <sup class="nota-ed-ptr">
      <a href="#{substring-after(@target,'#')}" title="Nota {$n}">
        <xsl:choose>
          <xsl:when test="$n != ''">
            <xsl:value-of select="$n"/>
          </xsl:when>
          <xsl:otherwise>*</xsl:otherwise>
        </xsl:choose>
      </a>
    </sup>
  </xsl:template>
  <!--  note a piè di pagina nel testo (type=footnote)  -->
  <xsl:template match="tei:note[@type='footnote']" mode="article">
    <span style="font-size:.78rem; color:#888; font-style:italic; display:block; margin:.5rem 0 .5rem 1.5rem; border-left:2px solid var(--warm-mid); padding-left:.6rem;">
      <xsl:if test="@n">
        <strong>
          <xsl:value-of select="@n"/>
          
        </strong>
      </xsl:if>
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  rs (riferimento a persona)  -->
  <xsl:template match="tei:rs" mode="article">
    <span class="pers-name" data-bio="{@ref}">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  ref generico  -->
  <xsl:template match="tei:ref" mode="article">
    <xsl:apply-templates mode="article"/>
  </xsl:template>
  <!--  date  -->
  <xsl:template match="tei:date" mode="article">
    <span title="{@when}{@from}{@to}">
      <xsl:apply-templates mode="article"/>
    </span>
  </xsl:template>
  <!--  trailer  -->
  <xsl:template match="tei:trailer" mode="article">
    <p class="trailer">
      <xsl:apply-templates mode="article"/>
    </p>
  </xsl:template>
  <!--  ab (blocco generico)  -->
  <xsl:template match="tei:ab" mode="article">
    <p class="letter-p">
      <xsl:apply-templates mode="article"/>
    </p>
  </xsl:template>
  <!--  testo: pass-through  -->
  <xsl:template match="text()" mode="article">
    <xsl:value-of select="."/>
  </xsl:template>
  <!--  testo in parallel-text: stessa logica  -->
  <xsl:template match="text()" mode="parallel-text">
    <xsl:value-of select="."/>
  </xsl:template>
  <!--  wild-card: applica ricorsivamente  -->
  <xsl:template match="*" mode="article">
    <xsl:apply-templates mode="article"/>
  </xsl:template>
  <xsl:template match="*" mode="parallel-text">
    <xsl:apply-templates mode="article"/>
  </xsl:template>
  <!--  ============================================================
       SCHEDA CATALOGRAFICA
       Ricava i dati da: biblStruct, profileDesc, textClass, facsimile
       ============================================================  -->
  <xsl:template name="scheda">
    <xsl:variable name="bib" select="//tei:biblStruct"/>
    <xsl:variable name="prof" select="//tei:profileDesc"/>
    <!--  Identificazione editoriale  -->
    <div class="scheda-card">
      <h2>Identificazione</h2>
      <div class="scheda-body">
        <span class="scheda-label">Identificatore file</span>
        <span class="scheda-val">
          <xsl:value-of select="//tei:idno[@type='fileName']"/>
        </span>
        <span class="scheda-label">Titolo articolo</span>
        <span class="scheda-val">
          <xsl:value-of select="$bib/tei:analytic/tei:title[@level='a']"/>
        </span>
        <span class="scheda-label">Autori</span>
        <span class="scheda-val">
          <xsl:for-each select="$bib/tei:analytic/tei:author">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="position() != last()"> · </xsl:if>
          </xsl:for-each>
        </span>
        <span class="scheda-label">Rivista</span>
        <span class="scheda-val">
          <em>
            <xsl:value-of select="$bib/tei:monogr/tei:title"/>
          </em>
        </span>
        <span class="scheda-label">Fascicolo</span>
        <span class="scheda-val">
          vol.
          <xsl:value-of select="$bib/tei:monogr/tei:biblScope[@unit='volume']"/>
          , n.
          <xsl:value-of select="$bib/tei:monogr/tei:biblScope[@unit='issue']"/>
          , pp.
          <xsl:value-of select="$bib/tei:monogr/tei:biblScope[@unit='page']"/>
        </span>
        <span class="scheda-label">Luogo · Data</span>
        <span class="scheda-val">
          <xsl:value-of select="$bib/tei:monogr/tei:imprint/tei:pubPlace"/>
          <xsl:text>, </xsl:text>
          <xsl:value-of select="$bib/tei:monogr/tei:imprint/tei:date"/>
        </span>
      </div>
    </div>
    <!--  Descrizione del contenuto  -->
    <div class="scheda-card">
      <h2>Contenuto</h2>
      <div class="scheda-body">
        <span class="scheda-label">Abstract</span>
        <span class="scheda-val">
          <xsl:value-of select="normalize-space($prof/tei:abstract/tei:p)"/>
        </span>
        <span class="scheda-label">Tipologia</span>
        <span class="scheda-val">
          <xsl:value-of select="$prof/tei:textClass/tei:keywords/tei:term[@type='text']"/>
        </span>
        <span class="scheda-label">Temi</span>
        <span class="scheda-val">
          <ul class="kw-list">
            <xsl:for-each select="$prof/tei:textClass/tei:keywords[@scheme]/tei:term[@type='themes']">
              <li class="kw-pill">
                <xsl:value-of select="normalize-space(.)"/>
              </li>
            </xsl:for-each>
          </ul>
        </span>
        <span class="scheda-label">Lingue</span>
        <span class="scheda-val">
          <xsl:for-each select="$prof/tei:langUsage/tei:language">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="position() != last()"> · </xsl:if>
          </xsl:for-each>
        </span>
      </div>
    </div>
    <!--  Codifica  -->
    <div class="scheda-card">
      <h2>Codifica digitale</h2>
      <div class="scheda-body">
        <span class="scheda-label">Edizione</span>
        <span class="scheda-val">
          <xsl:value-of select="normalize-space(//tei:editionStmt/tei:edition)"/>
        </span>
        <span class="scheda-label">Curatore</span>
        <span class="scheda-val">
          <xsl:value-of select="//tei:respStmt/tei:name"/>
        </span>
        <span class="scheda-label">Progetto</span>
        <span class="scheda-val">
          <xsl:value-of select="normalize-space(//tei:projectDesc/tei:p)"/>
        </span>
        <span class="scheda-label">Revisione</span>
        <span class="scheda-val">
          <xsl:for-each select="//tei:revisionDesc/tei:change">
            <xsl:value-of select="@when"/>
            <xsl:text> — </xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <br/>
          </xsl:for-each>
        </span>
      </div>
    </div>
    <!--  Facsimile / superfici  -->
    <div class="scheda-card">
      <h2>Facsimile</h2>
      <div class="scheda-body">
        <xsl:for-each select="//tei:facsimile/tei:surface">
          <span class="scheda-label">
            <xsl:value-of select="@xml:id"/>
          </span>
          <span class="scheda-val">
            <xsl:value-of select="tei:graphic/@width"/>
            ×
            <xsl:value-of select="tei:graphic/@height"/>
            px
            <xsl:text> · </xsl:text>
            <a href="{tei:graphic/@url}" target="_blank" style="font-size:.8rem; color:var(--accent);"> apri immagine ↗ </a>
          </span>
        </xsl:for-each>
      </div>
    </div>
    <!--  Persone nominate nel testo (deduplicazione Muenchian)  -->
    <xsl:variable name="persRefs" select="//tei:body//tei:persName[@ref]"/>
    <xsl:variable name="nameRefs" select="//tei:body//tei:name[@ref]"/>
    <xsl:if test="$persRefs or $nameRefs">
      <div class="scheda-card">
        <h2>Persone menzionate nel testo</h2>
        <div class="scheda-body">
          <xsl:for-each select="$persRefs[generate-id() = generate-id(key('byRef', @ref)[1])]">
            <xsl:sort select="@ref"/>
            <span class="scheda-label" style="font-weight:400; font-style:italic;">
              <xsl:value-of select="normalize-space(.)"/>
            </span>
            <span class="scheda-val" style="font-size:.82rem; color:#666;">
              <xsl:value-of select="@ref"/>
            </span>
          </xsl:for-each>
          <xsl:for-each select="$nameRefs[generate-id() = generate-id(key('byRef', @ref)[1])]">
            <xsl:sort select="@ref"/>
            <xsl:if test="not($persRefs[@ref = current()/@ref])">
              <span class="scheda-label" style="font-weight:400; font-style:italic;">
                <xsl:value-of select="normalize-space(.)"/>
              </span>
              <span class="scheda-val" style="font-size:.82rem; color:#666;">
                <xsl:value-of select="@ref"/>
              </span>
            </xsl:if>
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
    <!--  Titoli d'opera citati  -->
    <xsl:variable name="titleRefs" select="//tei:body//tei:title[@ref]"/>
    <xsl:if test="$titleRefs">
      <div class="scheda-card">
        <h2>Opere citate</h2>
        <div class="scheda-body">
          <xsl:for-each select="$titleRefs[generate-id() = generate-id(key('titleByRef', @ref)[1])]">
            <xsl:sort select="normalize-space(.)"/>
            <span class="scheda-label" style="font-weight:400; font-style:italic;">
              <xsl:value-of select="normalize-space(.)"/>
            </span>
            <span class="scheda-val" style="font-size:.82rem; color:#666;">
              <xsl:value-of select="@ref"/>
            </span>
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
  </xsl:template>
  <!--  ── Chiavi per deduplicazione ──  -->
  <xsl:key name="byRef" match="tei:persName[@ref] | tei:name[@ref]" use="@ref"/>
  <xsl:key name="titleByRef" match="tei:title[@ref]" use="@ref"/>
</xsl:stylesheet>