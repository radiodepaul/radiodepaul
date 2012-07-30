# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(".ajax-save").click (event) ->
  event.preventDefault()
  setting = $(this).parent().siblings()[0]
  setting = $(setting).children()[0]
  setting = $(setting).attr('href')
  console.log(setting)
  $.ajax
    url: setting
    type: "PUT"
    contentType: "application/json"
    data: JSON.stringify(value: "SQ2012")
    dataType: "json"
    beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
    success: (data) ->
      console.log data
