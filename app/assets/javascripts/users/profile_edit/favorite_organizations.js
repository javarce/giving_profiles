'use strict';

(() => {
  $(document).on("turbolinks:load", () => {
    clean_ranks();
    clean_select();
    $(".fav-org__buttons__up").click(up_button);
    $(".fav-org__buttons__down").click(down_button);
    $(".new-fav-org__submit").click(add_org);
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

  const clean_select = () => {
    const favoriteOrgs = [];
    $(".fav-org").each((index, org) => {
      favoriteOrgs.push($(org).data("org").toString());
    });
    $(".new-fav-org__select > option").each((index, option) => {
      option = $(option);
      if (favoriteOrgs.includes(option.val())) {
        option.hide();
      }
    });
  }

  const add_org = e => {
    const org = $(e.target).prev().val();
    if (org != 0) {
      console.log(org);
      // add new favorite org
      clean_select();
    }
  }

})();
