# Agoge Ops

Operations, security operations, and infrastructure consulting. Shoulder to shoulder. Shield to shield.

**Site:** [agogeops.com](https://agogeops.com). Open `index.html` locally. On Hostinger, upload the zip contents into `public_html`.

**Hostinger zip:** Build with `powershell -File .\build_site_zip.ps1`. The script reads `VERSION` and writes `installers/agogeops-v<version>.zip` (currently `agogeops-v1.1.2.zip`). Unzip into `public_html` so the pages, `robots.txt`, `sitemap.xml`, `site.webmanifest`, `.htaccess`, the IndexNow key file, `assets/`, and `LICENSE` sit in that folder. Do not commit `installers/`. This README stays in the repository and is not part of that zip.

The zip already published on GitHub Releases is [agogeops-v1.1.2.zip](https://github.com/devildog5x5/agogeops/releases/download/v1.1.2/agogeops-v1.1.2.zip).

**Menu:** Every page uses the same header menu. The standard is [SOP.md](SOP.md).

**Contact:** rmf@SpartanPhalanx.com · 801.319.1061

## Search engines

After the zip contents are in `public_html`:

- [https://agogeops.com/robots.txt](https://agogeops.com/robots.txt)
- [https://agogeops.com/sitemap.xml](https://agogeops.com/sitemap.xml)
- IndexNow key: [https://agogeops.com/3d3950baf93a87fc110ed15fddaeae16.txt](https://agogeops.com/3d3950baf93a87fc110ed15fddaeae16.txt)

### Google Search Console

1. Open [Google Search Console](https://search.google.com/search-console) and add the property `https://agogeops.com`.
2. Verify with the file or the meta tag Google gives you. Do not invent a token.
   - **File:** Download the HTML file Google provides. The name looks like `googleXXXXXXXXXXXXXXXX.html`. Put that file in the repo root, next to `index.html`. Rebuild the zip. The build script copies `google*.html` into the zip root. Upload the new contents to `public_html`. The file must open at `https://agogeops.com/` plus that file name.
   - **Meta tag:** Put the tag in the `<head>` of every page, then rebuild and upload. It looks like `<meta name="google-site-verification" content="TOKEN" />`.
3. Submit the sitemap `https://agogeops.com/sitemap.xml`.

### Bing Webmaster Tools

1. Open [Bing Webmaster Tools](https://www.bing.com/webmasters) and add `https://agogeops.com`. A site already verified in Google Search Console can be imported from there.
2. Verify with the file or the meta tag Bing gives you.
   - **File:** Save `BingSiteAuth.xml` in the repo root. The build script copies it into the zip root. After upload it must open at `https://agogeops.com/BingSiteAuth.xml`.
   - **Meta tag:** Put `<meta name="msvalidate.01" content="TOKEN" />` in the `<head>` of every page, then rebuild and upload.
3. Submit the sitemap `https://agogeops.com/sitemap.xml`.

### IndexNow

The key file in the site root contains `3d3950baf93a87fc110ed15fddaeae16`. After a page changes, and after that file is live, notify IndexNow with the changed URL:

`https://api.indexnow.org/indexnow?url=https://agogeops.com/&key=3d3950baf93a87fc110ed15fddaeae16`

Bing accepts IndexNow.

Copyright © 2026 Robert Foster · Agoge Ops. All rights reserved.
