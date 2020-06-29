'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    clean_ranks();
    $(".fav-cause__buttons__up").click(up_button);
    $(".fav-cause__buttons__down").click(down_button);
  });

  let clean_ranks = () => {
    $(".fav-cause__rank").each((index, rank) => {
      $(rank).val(index.toString());
    });
  }

  let up_button = e => {
    let cause_div = $(e.target).closest(".fav-cause");
    cause_div.insertBefore(cause_div.prev());
    clean_ranks();
  }

  let down_button = e => {
    let cause_div = $(e.target).closest(".fav-cause");
    cause_div.insertAfter(cause_div.next());
    clean_ranks();
  }

})();
