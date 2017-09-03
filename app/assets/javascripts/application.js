// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require maskedinput
//= require notifyjs
//= require bootbox
//= require bootstrap_sb_admin_base_v2
//= require_tree .

$(document).ready(function(){
  $(".br_date_format").mask("99/99/9999",{placeholder:"dd/mm/yyyy"});
  $(".br_cpf_format").mask("999.999.999-99",{placeholder:"000.000.000-00"});
  $(".br_cnpj_format").mask("99.999.999/9999-99",{placeholder:"00.000.000/0000-00"});
});