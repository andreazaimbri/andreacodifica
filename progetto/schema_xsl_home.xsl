<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0" exclude-result-prefixes="tei">
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
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
        <link rel="preconnect" href="https://fonts.gstatic.com"/>
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
            </div>
          <nav class="desktop-nav">
            <ul class="header-sub">
              <li> <a href="homepage.html" class="nav link text-light">Homepage</a> </li>
              <li> <a href="bibliografia.html" class="nav link text-light">Bibliografia e metadati</a> </li>
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
          </header>
          <!--  ════════════════ LEGENDA ════════════════  -->
          
          <!--  ════════════════ CORPO ════════════════  -->
        <main>
          <h1 class="titoli-presentazione">Progetto di edizione digitale</h1>
          <h2 class="titoli-presentazione">Corso di Codifica di Testi — Università di Pisa</h2>
          
          <div class="main-layout">
            
            <div>
              <p class="paragrafo-presentazione">
                Questo sito raccoglie i risultati di un progetto di edizione digitale realizzato 
                nell'ambito del corso di Codifica di Testi per la laurea in Informatica Umanistica 
                presso l'Università di Pisa. Il testo oggetto della codifica è un articolo pubblicato 
                sul periodico illustrato <em>La Farfalla</em> nel 1879, intitolato 
                <em>Emilio Zola. Romanziere, Commediografo, Critico</em>, nel quale si offre al 
                pubblico italiano un ritratto critico dell'opera e della poetica del grande scrittore 
                naturalista francese.
              </p>
              <p class="paragrafo-presentazione">
                Il testo è stato codificato secondo lo standard <strong>TEI P5</strong> 
                (<em>Text Encoding Initiative</em>), adottato a livello internazionale per l'edizione 
                digitale di documenti di interesse storico, letterario e umanistico. La codifica è 
                realizzata nell'ambito del progetto PRIN PNRR 
                <a href="http://chroma.cnr.it/progetti/" target="_blank">COVerLeSS</a> e ha 
                privilegiato la marcatura delle entità nominate — persone, luoghi, organizzazioni 
                e opere — con distinzione tra personaggi reali e fittizi, la conservazione della 
                struttura originale in pagine e colonne, e la gestione delle varianti grafiche 
                ottocentesche.
              </p>
            </div>
            
            <div>
              <div style="background:var(--c-note); border:1px solid var(--c-mid); 
                          border-top:5px solid var(--c-accent); border-radius:var(--radius); 
                          padding:1.2rem 1.5rem; margin: 0 5%;">
                <h3 style="font-family:'IM Fell English',serif; color:var(--c-accent); 
                           margin-top:0; font-size:1.3rem;">Émile Zola</h3>
                <p style="text-indent:0; margin-bottom:.6rem;">
                  Romanziere francese (1840–1902), considerato il massimo esponente del 
                  <strong>naturalismo</strong> letterario. È noto principalmente per il ciclo 
                  dei <em>Rougon-Macquart</em>, venti romanzi che ritraggono la società francese 
                  sotto il Secondo Impero attraverso la storia di una famiglia su quattro generazioni.
                </p>
                <p style="text-indent:0; margin-bottom:.6rem;">
                  Al momento della pubblicazione di questo articolo su <em>La Farfalla</em> 
                  (1879), Zola aveva già ottenuto un clamoroso successo con 
                  <em>L'Assommoir</em> (1877) ed era al centro del dibattito letterario europeo.
                </p>
                <p style="text-indent:0; margin-bottom:0;">
                  Gli ultimi anni della sua vita furono segnati dall'impegno civile nell'
                  <a href="https://it.wikipedia.org/wiki/Affare_Dreyfus" target="_blank">Affare Dreyfus</a>, 
                  culminato nella pubblicazione del celebre articolo <em>J'Accuse…!</em> (1898).
                </p>
              </div>
            </div>
            
          </div>
        </main>
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
                  <h2>Documento</h2>
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
                  <h3>Standard e accesso</h3>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                crossorigin="anonymous"/>
        <script>
          document.addEventListener('DOMContentLoaded', function () {
          document.querySelectorAll('[data-bs-toggle="popover"]').forEach(el => {
          new bootstrap.Popover(el, {
          trigger: 'hover focus',
          html: false,
          container: 'body'
          });
          });
          });
        </script>
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
</xsl:stylesheet>