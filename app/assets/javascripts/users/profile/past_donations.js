'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".past-donations__search").on("input", updateSearch);
    $(document).click(togglePopups);
    $(".past-donations__cards").scroll(togglePopups);
  });

  let updateSearch = e => {
    let query = $(e.target).val().toLowerCase();
    $(".past-donations__cards > .donation-card").each((index, card) => {
      card = $(card);
      let organization = card.find(".donation-card__organization").text().toLowerCase();
      if (organization.includes(query)) {
        card.addClass("d-flex").removeClass("d-none");
      } else {
        card.addClass("d-none").removeClass("d-flex");
      }
    });
  }

  let togglePopups = e => {
    let popup = $(".donation-card__popup");
    popup.addClass("d-none").removeClass("d-flex");
    if ($(e.target).hasClass("donation-card__toggle")) {
      let card = $(e.target).parent().parent()
      card.find(".donation-card__popup").addClass("d-flex").removeClass("d-none");
    }
  }

})();
