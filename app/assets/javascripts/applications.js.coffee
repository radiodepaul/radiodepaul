# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require jquery.maskedinput-1.3.min

$('#talk_host_inputs').hide()
$('#talk_podcast_show_inputs').hide()
$('#application_position_other_input').hide()
$('#application_position_input input').click ->
  if $(this).val() == "Host"
    $('#host_inputs').slideDown()
    $('#application_position_other_input').slideUp()
  else if $(this).val() == "Other"
    $('#host_inputs').slideUp()
    $('#application_position_other_input').slideDown()
  else
    $('#host_inputs').slideUp()
    $('#application_position_other_input').slideUp()
$('#application_host_type_input input').click ->
  if $(this).val() == "Music"
    $('#music_show_inputs').slideDown()
    $('#talk_podcast_show_inputs').slideUp()
  else
    $('#talk_podcast_show_inputs').slideDown()
    $('#music_show_inputs').slideUp()
$('#application_phone').mask("(999) 999-9999")
