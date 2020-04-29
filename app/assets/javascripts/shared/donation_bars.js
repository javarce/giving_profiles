'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".donation-distribution > .donation-bar").each((index, value) => {
      $(value).css("width", $(value).data("percent") + "%");
    });
  });
})();
