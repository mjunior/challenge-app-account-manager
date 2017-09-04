$(document).ready(function() {
  $('#select_parant_id').hide();
  $('#account_parent_id').attr('disabled','disabled');
  console.log('rodou accounts')
  if($('#branch_type_branch').attr('checked')){
    $('#select_parant_id').show();
    $('#account_parent_id').removeAttr('disabled');
  }

  $('.radio_type_account').change(function() {
    if (this.value == 'Branch') {
      $('#select_parant_id').show();
      $('#account_parent_id').removeAttr('disabled');
    }else{
      $('#select_parant_id').hide();
      $('#account_parent_id').attr('disabled','disabled');
    }
  });
});