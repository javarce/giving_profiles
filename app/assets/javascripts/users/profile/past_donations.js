'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    $(".past-donations__search").on("input", updateSearch);
    $(document).click(togglePopups);
    $(".past-donations__cards").scroll(togglePopups);
  });

  const updateSearch = e => {
    const query = $(e.target).val().toLowerCase();
    $(".past-donations__cards > .donation-card").each((index, card) => {
      card = $(card);
      const organization = card.find(".donation-card__organization").text().toLowerCase();
      if (organization.includes(query)) {
        card.addClass("d-flex").removeClass("d-none");
      } else {
        card.addClass("d-none").removeClass("d-flex");
      }
    });
  }

  const togglePopups = e => {
    const popup = $(".donation-card__popup");
    popup.addClass("d-none").removeClass("d-flex");
    if ($(e.target).hasClass("donation-card__toggle")) {
      const card = $(e.target).parent().parent()
      card.find(".donation-card__popup").addClass("d-flex").removeClass("d-none");
    }
  }

})();
