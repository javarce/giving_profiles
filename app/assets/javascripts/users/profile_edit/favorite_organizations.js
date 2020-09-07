'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    clean_ranks();
    $(".fav-org__buttons__up").click(up_button);
    $(".fav-org__buttons__down").click(down_button);
  });

  const clean_ranks = () => {
    $(".fav-org__rank").each((index, rank) => {
      $(rank).val(index.toString());
    });
  }

  const up_button = e => {
    const organization_div = $(e.target).closest(".fav-org");
    organization_div.insertBefore(organization_div.prev());
    clean_ranks();
  }

  const down_button = e => {
    const organization_div = $(e.target).closest(".fav-org");
    organization_div.insertAfter(organization_div.next());
    clean_ranks();
  }

})();
