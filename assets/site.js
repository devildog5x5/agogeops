(function () {
  var toggle = document.getElementById("nav-toggle");
  var drawer = document.getElementById("nav-drawer");
  if (!toggle || !drawer) return;

  function close() {
    drawer.hidden = true;
    toggle.setAttribute("aria-expanded", "false");
  }

  function open() {
    drawer.hidden = false;
    toggle.setAttribute("aria-expanded", "true");
  }

  toggle.addEventListener("click", function () {
    if (drawer.hidden) open();
    else close();
  });

  drawer.querySelectorAll("a").forEach(function (a) {
    a.addEventListener("click", close);
  });

  document.addEventListener("keydown", function (ev) {
    if (ev.key === "Escape") close();
  });
})();
