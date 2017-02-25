$ () -> run() if document.querySelector( 'form' )

addErrorClassToParentInputField = () ->
  $('input.error').each( (i, errorNode) ->
    $( errorNode ).closest( '.input-field' ).addClass( 'error-field' )
  )

run = () ->
  addErrorClassToParentInputField()
