# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#send_welcome_email = (ids) ->
#  console.log(ids)
#$('#send_welcome_email').click (e) ->
#  e.preventDefault()
#  person_ids = []
#  $("input[id=person_ids_]:checked").each ->
#    person_ids.push $(this).val()
#  console.log('send_welcome_email clicked')
#  data_send =
#    person_ids: person_ids
#  $.get "/people/send_welcome", data_send, (data) =>
#    alert("Data Loaded: " + data)
