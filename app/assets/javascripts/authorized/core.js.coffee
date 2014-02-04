$(document).ready ->
  $("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  window.setTimeout (->
    $(".alert").alert "close"
  ), 3500
