$(document).ready ->
  $("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  window.setTimeout (->
    $(".alert").alert "close"
    $("span.help-inline").addClass 'fade'
  ), 5500
  
  $(".sidebar-offcanvas, .application-frame").height ($(".container.perimeter").height()) + "px"
  $(".panel-border-light, .panel-right-inner").height $(".sidebar-offcanvas").height() - 115 + "px"
  $(window).resize ->
    $(".sidebar-offcanvas, .application-frame").height ($(".container.perimeter").height()) + "px"
    $(".panel-border-light, .panel-right-inner").height $(".sidebar-offcanvas").height() - 115 + "px"
    return

