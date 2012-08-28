# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('#host_inputs').hide()
$('#application_position_input input').click ->
  if $(this).val() == "Host"
    $('#host_inputs').slideDown()
  else
    $('#host_inputs').slideUp()
