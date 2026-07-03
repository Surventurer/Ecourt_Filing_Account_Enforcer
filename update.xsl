<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:g="http://www.google.com/update2/response">
  <xsl:output method="html" indent="yes" encoding="UTF-8" />

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <title>Chrome Extension Update Manifest</title>
        <style>
          body {
            margin: 0;
            padding: 24px;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif;
            background: #f7f9fc;
            color: #1f2937;
          }
          .card {
            max-width: 820px;
            margin: 0 auto;
            background: #ffffff;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 18px rgba(23, 38, 66, 0.08);
          }
          h1 {
            margin: 0 0 8px;
            font-size: 20px;
          }
          p {
            margin: 0 0 16px;
            color: #4b5563;
          }
          table {
            width: 100%;
            border-collapse: collapse;
          }
          th, td {
            text-align: left;
            padding: 10px;
            border-bottom: 1px solid #eef2f7;
            vertical-align: top;
          }
          th {
            width: 180px;
            color: #374151;
          }
          code {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            background: #f3f4f6;
            padding: 2px 6px;
            border-radius: 6px;
          }
        </style>
      </head>
      <body>
        <div class="card">
          <h1>Chrome Extension Update Manifest</h1>
          <p>This page is for browser policy/update checks. Values are shown for readability.</p>
          <table>
            <tr>
              <th>App ID</th>
              <td><code><xsl:value-of select="g:gupdate/g:app/@appid" /></code></td>
            </tr>
            <tr>
              <th>Codebase</th>
              <td><code><xsl:value-of select="g:gupdate/g:app/g:updatecheck/@codebase" /></code></td>
            </tr>
            <tr>
              <th>Version</th>
              <td><code><xsl:value-of select="g:gupdate/g:app/g:updatecheck/@version" /></code></td>
            </tr>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
