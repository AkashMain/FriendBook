  $(document).on('ready turbolinks:load', function() {
    if ($('#infinite-scrolling').length) {
      $(window).scroll(function() {
        var url;
        url = $('.pagination .next_page').attr('href');
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          $('.pagination').text("Fetching more posts...");
          return $.getScript(url);
        }
      });
      return $(window).scroll();
    }
  });