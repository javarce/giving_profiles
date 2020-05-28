'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".badge-row > .badge").hover(showDescription, hideDescription);
  });

  let tierMap = {
    1: 10,
    2: 30,
    3: 50,
    4: 70,
    5: 90,
  }

  let showDescription = e => {
    let badge = $(e.target);
    if (badge.is("i")) {
      badge = badge.parent();
    }
    let description = badge.attr("data-description");
    let tier = badge.attr("data-tier");
    let html = `Donated at least ${tierMap[parseInt(tier)]}% ${description}.`;
    if (tier < 5) {
      html += `<br><br>Unlock next tier at ${tierMap[parseInt(tier) + 1]}%.`
    }
    $(".badge-description").html(html);
  }

  let hideDescription = e => {
    $(".badge-description").html("");
  }

})();
