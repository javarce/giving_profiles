'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    clean_ranks();
    clean_select();
    $(".fav-cause__buttons__up").click(up_button);
    $(".fav-cause__buttons__down").click(down_button);
    $(".new-fav-cause__submit").click(add_cause);
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

  const clean_select = () => {
    const favoriteCauses = [];
    $(".fav-cause").each((index, cause) => {
      favoriteCauses.push($(cause).data("cause"));
    });
    $(".new-fav-cause__select > option").each((index, option) => {
      option = $(option);
      if (option.val() == "unknown" || favoriteCauses.includes(option.val())) {
        option.hide();
      }
    });
  }

  const add_cause = e => {
    const cause = $(e.target).prev().val();
    if (cause != 0) {
      console.log(cause);
      // add new favorite cause
      clean_select();
    }
  }

})();
