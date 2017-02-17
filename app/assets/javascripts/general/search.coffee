$ () -> run() if document.querySelector( '.search .btn.filters' )

handleClicks = ( $btn ) ->
  $btn.on( 'click', () -> toggleFiltersView() )

toggleFiltersView = () ->
  console.log "clicked"
  $( '.filter-opts' ).slideToggle( 200 )

run = () ->
  handleClicks( $( '.search .btn.filters' ) )