(function () {
  var toggle = document.getElementById("nav-toggle");
  var drawer = document.getElementById("nav-drawer");
  var settingsToggle = document.getElementById("settings-toggle");
  var settingsPanel = document.getElementById("settings-panel");
  var themeButtons = document.querySelectorAll(".theme-list button");

  function closeNav() {
    if (!drawer || !toggle) return;
    drawer.hidden = true;
    toggle.setAttribute("aria-expanded", "false");
  }

  function closeSettings() {
    if (!settingsPanel || !settingsToggle) return;
    settingsPanel.hidden = true;
    settingsToggle.setAttribute("aria-expanded", "false");
  }

  function applyTheme(name) {
    document.documentElement.setAttribute("data-theme", name);
    try { localStorage.setItem("agogeops-theme", name); } catch (e) {}
    var themeColor = getComputedStyle(document.documentElement).getPropertyValue("--theme-color").trim();
    var meta = document.querySelector('meta[name="theme-color"]');
    if (meta && themeColor) meta.setAttribute("content", themeColor);
    themeButtons.forEach(function (button) {
      button.setAttribute("aria-checked", button.getAttribute("data-theme") === name ? "true" : "false");
    });
  }

  if (toggle && drawer) {
    toggle.addEventListener("click", function () {
      if (drawer.hidden) {
        closeSettings();
        drawer.hidden = false;
        toggle.setAttribute("aria-expanded", "true");
      } else {
        closeNav();
      }
    });
    drawer.querySelectorAll("a").forEach(function (a) {
      a.addEventListener("click", closeNav);
    });
  }

  if (settingsToggle && settingsPanel) {
    settingsToggle.addEventListener("click", function () {
      if (settingsPanel.hidden) {
        closeNav();
        settingsPanel.hidden = false;
        settingsToggle.setAttribute("aria-expanded", "true");
      } else {
        closeSettings();
      }
    });
    themeButtons.forEach(function (button) {
      button.addEventListener("click", function () {
        applyTheme(button.getAttribute("data-theme"));
      });
    });
  }

  document.addEventListener("click", function (ev) {
    if (!settingsPanel || settingsPanel.hidden) return;
    if (settingsPanel.contains(ev.target) || settingsToggle.contains(ev.target)) return;
    closeSettings();
  });

  document.addEventListener("keydown", function (ev) {
    if (ev.key === "Escape") {
      closeNav();
      closeSettings();
    }
  });

  applyTheme(document.documentElement.getAttribute("data-theme") || "light-green");
})();
