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
          
          blockquote {
          background-color: var(--warm-mid);
          }
          
          html {
          scroll-behavior: smooth;
          }
          
          body {
          background: var(--warm-bg);
          color: var(--ink);
          font-family: 'EB Garamond', Georgia, serif;
          font-size: 1.1rem;
          }
          
          .surface-container {
          background: #fff;
          border: 1px solid var(--warm-mid);
          padding: 10px;
          margin-bottom: 30px;
          border-radius: 4px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.05);
          }
          
          .bibl-card {
          background: #fff;
          border-left: 4px solid var(--warm-mid);
          padding: 15px;
          margin-bottom: 20px;
          border-radius: 0 4px 4px 0;
          box-shadow: 0 1px 3px rgba(0,0,0,0.05);
          }
        </style>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/image-map-resizer/1.0.10/imageMapResizer.min.js"></script>
        
        <script>
          window.addEventListener('load', function () {
          const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
          popoverTriggerList.forEach(el => {
          new bootstrap.Popover(el, { trigger: 'hover focus' });
          });
          
          try {
          imageMapResize();
          } catch(err) {
          console.log("Image map non presenti o disattivate.");
          }
          });
        </script>
      </head>
      <body>
        <div class="container my-5">
          <div class="row">
            <div class="col-lg-8 mx-auto text">
              <h1 class="mb-4 border-bottom pb-2">Bibliografia delle Opere</h1>
              <xsl:apply-templates select="//tei:back//tei:biblStruct"/>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct">
    <div class="bibl-card">
      <h4 class="text-dark">
        <xsl:value-of select=".//tei:title"/>
      </h4>
      <p class="mb-1">
        <xsl:if test=".//tei:author and .//tei:author != ''">
          <p class="mb-0">
            <strong>Autore:</strong> <xsl:value-of select=".//tei:author"/>
          </p>
        </xsl:if>
      </p>
      <p class="mb-1">
        <strong>Data di pubblicazione:</strong> <xsl:value-of select=".//tei:date"/>
      </p>
      <p class="mb-0">
        <xsl:if test=".//tei:pubPlace and .//tei:pubPlace != ''">
          <p class="mb-0">
            <strong>Luogo di pubblicazione:</strong> <xsl:value-of select=".//tei:pubPlace"/>
          </p>
        </xsl:if>
      </p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>