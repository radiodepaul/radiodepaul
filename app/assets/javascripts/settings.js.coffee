# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(".ajax-save").click (event) ->
  event.preventDefault()
  setting = $(this).parent().siblings()[0]
  value = $(this).parent().siblings()[1]
  setting = $(setting).children()[0]
  value = $(value).children()[0]
  console.log(setting)
  console.log(value)
  $.ajax
    url: $(setting).attr('href')
    type: "PUT"
    contentType: "application/json"
    data: JSON.stringify(value: $(value).attr('value'))
    dataType: "json"
    beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
    success: (data) ->
      $(value).attr('disabled', 'disabled')
$(".ajax-edit").click (event) ->
  event.preventDefault()
  setting = $(this).parent().siblings()[1]
  setting = $(setting).children()[0]
  $(setting).removeAttr('disabled')
  $(setting).focus()
