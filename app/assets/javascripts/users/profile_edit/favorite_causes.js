'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    clean_ranks();
    $(".fav-cause__buttons__up").click(up_button);
    $(".fav-cause__buttons__down").click(down_button);
  });

  const clean_ranks = () => {
    $(".fav-cause__rank").each((index, rank) => {
      $(rank).val(index.toString());
    });
  }

  const up_button = e => {
    const cause_div = $(e.target).closest(".fav-cause");
    cause_div.insertBefore(cause_div.prev());
    clean_ranks();
  }

  const down_button = e => {
    const cause_div = $(e.target).closest(".fav-cause");
    cause_div.insertAfter(cause_div.next());
    clean_ranks();
  }

})();
