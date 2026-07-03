<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:g="http://www.google.com/update2/response">
  <xsl:output method="html" indent="yes" encoding="UTF-8" />

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Chrome Extension Update Manifest</title>
        <style>
          :root {
            --bg-0: #f4f7fb;
            --bg-1: #d9e4f3;
            --card: #ffffff;
            --text: #122033;
            --muted: #4f647d;
            --line: #dbe5f0;
            --accent: #0e5db2;
            --code-bg: #f2f6fb;
            --shadow: 0 10px 32px rgba(15, 35, 65, 0.14);
          }
          * {
            box-sizing: border-box;
          }
          html,
          body {
            margin: 0;
            padding: 0;
          }
          body {
            min-height: 100vh;
            font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
            color: var(--text);
            background:
              radial-gradient(circle at 10% 0%, rgba(14, 93, 178, 0.18), transparent 45%),
              radial-gradient(circle at 95% 10%, rgba(38, 121, 203, 0.14), transparent 40%),
              linear-gradient(180deg, var(--bg-0) 0%, var(--bg-1) 100%);
            padding: 20px;
          }
          .shell {
            width: min(980px, 100%);
            margin: 0 auto;
          }
          .card {
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: var(--shadow);
          }
          .head {
            padding: 24px 24px 14px;
            border-bottom: 1px solid var(--line);
            background: linear-gradient(180deg, #ffffff 0%, #f6faff 100%);
          }
          h1 {
            margin: 0;
            font-size: clamp(1.05rem, 2.3vw, 1.45rem);
            line-height: 1.25;
            letter-spacing: 0.01em;
          }
          .sub {
            margin: 8px 0 0;
            font-size: clamp(0.9rem, 1.7vw, 1rem);
            color: var(--muted);
          }
          .grid {
            display: grid;
            grid-template-columns: minmax(140px, 190px) minmax(0, 1fr);
          }
          .cell {
            padding: 14px 16px;
            border-bottom: 1px solid var(--line);
            min-width: 0;
          }
          .k {
            color: #344c69;
            font-weight: 600;
            background: #f9fbfe;
          }
          .v {
            color: #1f2f42;
            min-width: 0;
          }
          .footer {
            padding: 12px 16px 16px;
            font-size: 0.84rem;
            color: var(--muted);
          }
          code {
            display: block;
            width: 100%;
            max-width: 100%;
            padding: 6px 8px;
            border-radius: 8px;
            background: var(--code-bg);
            border: 1px solid #d6e3f1;
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.85rem;
            line-height: 1.35;
            white-space: normal;
            overflow-wrap: anywhere;
            word-break: break-word;
          }
          @media (max-width: 720px) {
            body {
              padding: 12px;
            }
            .head {
              padding: 18px 16px 12px;
            }
            .grid {
              grid-template-columns: 1fr;
            }
            .k {
              border-bottom: 0;
              padding-bottom: 8px;
            }
            .v {
              padding-top: 0;
              padding-bottom: 14px;
            }
          }
        </style>
      </head>
      <body>
        <div class="shell">
          <div class="card">
            <div class="head">
              <h1>Extension Update Manifest</h1>
              <p class="sub">Human-readable view for policy and update verification.</p>
            </div>
            <div class="grid">
              <div class="cell k">App ID</div>
              <div class="cell v"><code><xsl:value-of select="g:gupdate/g:app/@appid" /></code></div>

              <div class="cell k">Codebase URL</div>
              <div class="cell v"><code><xsl:value-of select="g:gupdate/g:app/g:updatecheck/@codebase" /></code></div>

              <div class="cell k">Version</div>
              <div class="cell v"><code><xsl:value-of select="g:gupdate/g:app/g:updatecheck/@version" /></code></div>
            </div>
            <div class="footer">This styling is only for browser display. The XML data remains standard for extension update checks.</div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
