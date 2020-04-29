'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".alert-success").delay(2200).slideUp(1000);
  });
})();
