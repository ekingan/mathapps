//= require active_admin/base

jQuery(document).ready(function($) {
  $('body').append($('<div class="overlay">'));

  utility_nav = $('#utility_nav').detach();
  $('#footer').append(utility_nav);

  $('.delete_link').html($('<i>').addClass('fa fa-trash'));
  $('.edit_link'  ).html($('<i>').addClass('fa fa-pencil'));
  $('.view_link'  ).html($('<i>').addClass('fa fa-eye'));

  if ($("#filters_sidebar_section").length > 0) {
    $("#main_content").prepend(
      $('<div class="bloc">').append(
        $('<a>').text('Filter').attr({
          href: '#value', id:'diplay-filter'
        })
      )
    );
  }else{
    $("#main_content").addClass('with_side');
  };

  $(document).on('click', '#diplay-filter', function(event) {
    event.preventDefault();
    $('.overlay').show();
    $("#filters_sidebar_section").addClass('animated slideInUp').show();
  });

  $('.overlay').click(function(event) {
    event.preventDefault();
    $("#filters_sidebar_section").hide();
    $(this).hide();
  });

  $('.has_nested').each(function(index, el) {
    $(this).click(function(event) {
      $siblings = $(this).siblings('.has_nested').find('.slided_down');
      $siblings.slideUp().removeClass('slided_down');
      $(this).find('ul').slideToggle().toggleClass('slided_down');
    });
  });

  $(".btn-add-spouse" ).click(function(event) {
    event.preventDefault();
    $("#spouse-form").toggle();
    if (this.textContent == 'Hide Spouse') {
      $(this).text("Add Spouse")
    } else {
      $(this).text("Hide Spouse")
    }
  });

  $( ".btn-add-address" ).click(function(event) {
    event.preventDefault();
    $("#address-form").toggle();
    if (this.textContent == 'Hide Address') {
      $(this).text("Add Address")
    } else {
      $(this).text("Hide Address")
    }
  });
});