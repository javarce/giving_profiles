'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".donation-distribution > .donation-bar").each((index, bar) => {
      bar = $(bar)
      bar.css("width", bar.data("percent") + "%");

      // This should be given some more thought
      if (bar.data("percent") < 10) {
        bar.find('.donation-bar__cause').hide()
        bar.find('.donation-bar__percent').hide()
      }
    });
  });
})();
