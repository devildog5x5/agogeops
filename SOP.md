# SOP

Permanent standards for the Agoge Ops site.

## Main menu

Every page shows the same main menu. The menu links to every page and every section. There are no dead ends.

This is Robert's standard. A new service page uses this header. It does not get a shorter menu, a different menu, or links that only work on the homepage.

- The header nav is the same list on every page. The mobile menu is that same list, not a subset.
- A link uses a path that resolves from every page, such as `index.html#practice`, `it-operations.html`, or `security-operations.html#architecture`. A bare `#practice` link is a dead end on any page that does not contain that section.
- Every HTML page is in the menu. Every section with an `id` is in the menu. Do not add a page or a section id without adding its menu link in the same change.
- Do not add a menu link whose target is missing.
- Contact stays in the menu. From every page, the menu can reach the rest of the site.
- When a page is added, list it in `sitemap.xml` and in `build_site_zip.ps1` in that same change.

## Footer

Every page ends with the same compact line, under the contact block:

`Agoge Ops vX.Y.Z · © 2026 Robert Foster · Text 801-319-1061 for support`

- The number is an `sms:+18013191061` link. The site does not publish a support email.
- The line is centered, 12.5px, with light padding. It stays one line on a desktop and wraps at the separators on a phone.
- The color is the theme muted color, on light and dark themes, and it meets WCAG AA.
- The contact block and the main menu stay as they are. Do not add a second copyright, brand, or version line.
- The line does not link to GitHub, source code, or a zip.

## Live site

Never link to or serve source code or release zips from the live site.

This is Robert's standard.

- Pages, the menu, the footer, the sitemap, and structured data do not link to GitHub, the repository, source code, a zip download, or a release.
- The Hostinger zip contains only public site files: the HTML pages, `robots.txt`, `sitemap.xml`, `site.webmanifest`, `.htaccess`, the IndexNow key, `assets/`, `LICENSE`, and a verification file when one has been added. It does not contain `installers/`, other zips, scripts, or `.git`.
- `.htaccess` denies `*.zip`, `*.ps1`, and the same kind of archive and script (`7z`, `rar`, `tar`, `gz`, `tgz`, `bz2`, `xz`, `psm1`, `psd1`, `sh`, `bash`, `bat`, `cmd`, `py`, `md`). It also blocks `.git`, `installers/`, and `build/`.
- `README.md` and `SOP.md` stay in the repository. They are not part of the public zip.
