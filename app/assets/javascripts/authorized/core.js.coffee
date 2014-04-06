$(document).ready ->
  $("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  window.setTimeout (->
    $(".alert").slideUp()
    $("span.help-inline").addClass 'fade'
  ), 5500

  $(".sidebar-offcanvas, .application-frame").height ($(".container.perimeter").height()) + "px"
  $(".panel-border-light, .panel-right-inner").height $(".sidebar-offcanvas").height() - 115 + "px"
  $(window).resize ->
    $(".sidebar-offcanvas, .application-frame").height ($(".container.perimeter").height()) + "px"
    $(".panel-border-light, .panel-right-inner").height $(".sidebar-offcanvas").height() - 115 + "px"

  $("body").on 'ajax:beforeSend', '#new_expense', (event,xhr,status) ->  
    $('#expense_name').val('')
    $('#expense_flexible_amount').val('')

jQuery ->
  if $(".main-panel").hasClass("taxes")
    income = gon.income unless gon.income == 0
    $("input#tax_flexible_income").val(income) unless $("input#tax_flexible_income").val()

  $("#first_expense").click ->
    $(".dropdown-toggle").dropdown('toggle')