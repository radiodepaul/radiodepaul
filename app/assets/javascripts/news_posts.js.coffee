# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require showdown
converter = new Showdown.converter()
$('#news_post_content').change ->
  text = $('#news_post_content').val()
  html = converter.makeHtml(text) 
  $('news_post_preview').val(html)
