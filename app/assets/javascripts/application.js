// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require rails.validations
//= require jquery_nested_form
//= require_tree .
$('.datatable').dataTable({
  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
  "sPaginationType": "bootstrap",
  "iDisplayLength": 50,
});
$('#login_as_id').change(function() {
  window.location.href = "/people/become?id=" + $('#login_as_id option:selected').val() ;
});
$('#reset_password_for_id').change(function() {
  window.location.href = "/people/reset_password?id=" + $('#reset_password_for_id option:selected').val() ;
});
$('#send_welcome_to_id').change(function() {
  window.location.href = "/people/send_welcome?id=" + $('#send_welcome_to_id option:selected').val() ;
});
$.fn.toggleCheckbox = function() {
    this.attr('checked', !this.attr('checked'));
}
 $('.dropdown input, .dropdown label').click(function(e) {
  e.stopPropagation();
});
$('#tabs').tabs()
$('.sort_on_desc').click().click()
$('.sort_on_asc').click()
