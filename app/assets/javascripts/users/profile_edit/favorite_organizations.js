'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    clean_ranks();
    $(".fav-org__buttons__up").click(up_button);
    $(".fav-org__buttons__down").click(down_button);
  });

  let clean_ranks = () => {
    $(".fav-org__rank").each((index, rank) => {
      $(rank).val(index.toString());
    });
  }

  let up_button = e => {
    let organization_div = $(e.target).closest(".fav-org");
    organization_div.insertBefore(organization_div.prev());
    clean_ranks();
  }

  let down_button = e => {
    let organization_div = $(e.target).closest(".fav-org");
    organization_div.insertAfter(organization_div.next());
    clean_ranks();
  }

})();
