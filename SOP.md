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
