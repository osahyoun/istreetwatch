$ () -> run() if document.getElementById( 'report-form' )


observeNewOptions = ( $select, $otherDiv ) ->
  $select.on( 'change', () -> handleSelection( $select, $otherDiv ) )

handleSelection = ( $select, $otherDiv ) ->
  if otherIsSelected( $select )
    show( $otherDiv )
    $otherDiv.find( 'input' ).focus()
  else
    hide( $otherDiv )

otherIsSelected = ( $select ) -> $select.val().toLowerCase().trim() == 'other'

show = ( $node ) -> $node.removeClass( 'hide-fields' )

hide = ( $node ) ->
  $node.addClass( 'hide-fields' )
  $node.find( 'input' ).val('')

getNextFormField = ( $node ) -> $node.closest( '.input-field' ).next( '.input-field' )


run = () ->
  $type_incident_select = $( 'select.type-incident' )
  $type_location_select = $( 'select.type-location' )
  $town_input = $( 'input.town' )

  [ $type_incident_select, $type_location_select ].forEach ( $select ) ->
    $otherDiv = getNextFormField( $select )
    show( $otherDiv ) if otherIsSelected( $select )
    observeNewOptions( $select, $otherDiv )

  if $town_input.val() or $town_input.hasClass( 'error' ) then show( $('.location') )