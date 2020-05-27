'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".badge-row > .badge").hover(showDescription, hideDescription);
  });

  let showDescription = e => {
    let badge = $(e.target)
    let description = badge.attr("data-description");
    let tier = badge.attr("data-tier");
    $(".badge-description").html("<em>description:</em> " + description + ", <em>tier:</em> " + tier);
  }

  let hideDescription = e => {
    $(".badge-description").html("");
  }

})();
