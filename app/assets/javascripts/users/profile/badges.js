'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".badge-row > .badge").hover(showDescription, hideDescription);
  });

  const tierMap = {
    1: 10,
    2: 30,
    3: 50,
    4: 70,
    5: 90,
  }

  const showDescription = e => {
    let badge = $(e.target);
    if (badge.is("i")) {
      badge = badge.parent();
    }
    const description = badge.data("description");
    const tier = badge.data("tier");
    let html = description.replace("#{PERCENTAGE}", tierMap[parseInt(tier)]);
    if (tier < 5) {
      html += `<br>Next tier unlocks at ${tierMap[parseInt(tier) + 1]}%.`
    }
    $(".badge-description").html(html);
  }

  const hideDescription = e => {
    $(".badge-description").html("");
  }

})();
