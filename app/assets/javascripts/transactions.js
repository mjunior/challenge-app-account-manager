$(document).ready(function(){

  $(document).ready(function() {
    $('#transaction_list_table').DataTable({searching: false});
  });

  $('#reversal_transaction').click(function(){
    console.log('Reversal Transaction');
    var transaction_type = $('#transaction_type_confirmation').val();
    var transaction_token = $('#transaction_token_confirmation').val();
    
    if(transaction_type == 'contribution' && transaction_token == ''){
      bootbox.prompt("Para prosseguir. Informe o Cod. de Autorização desta transação", function(result){   
        setTimeout(function() {
          real_token = $('#transaction_token').val();
          if(real_token == result){
            //resend transaction reverse
            $('#transaction_token_confirmation').val(result);
            $('#reversal_transaction').click();
          }else{
            bootbox.alert({
                message: "Código informado é Inválido!",
                size: 'small'
            });
            return false;
          }
        }, 200);
      });
      return false;
    }
  })
})
//Sobrescreve o data-confirm do RAILS
$.rails.allowAction = function(element) {
  var message = element.attr('data-confirm');
  if (!message) { return true; }

  var opts = {
    title: "Confirme sua ação",
    message: message,
    buttons: {
        confirm: {
            label: 'Sim',
            className: 'btn-success'
        },
        cancel: {
            label: 'Não',
            className: 'btn-danger'
        }
    },
    callback: function(result) {
      if (result) {
        element.removeAttr('data-confirm');
        element.trigger('click.rails')
      }
    }
  };

  bootbox.confirm(opts);

  return false;
}