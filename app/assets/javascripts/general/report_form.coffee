$ () -> run() if document.getElementById( 'report-form' )


observeNewOptions = ( $select, $otherDiv ) ->
  $select.on( 'change', () -> handleSelection( $select, $otherDiv ) )

handleSelection = ( $select, $otherDiv ) ->
  if otherIsSelected( $select )
    show( $otherDiv )
    $otherDiv.find( 'input' ).focus()
  else
    hide( $otherDiv )

otherIsSelected = ( $select ) ->
  values = $select.val()
  reduce = () ->
    values.reduce(
      ( acc, curr ) -> true if curr.toLowerCase().trim() == 'other'
    , false )

  if Array.isArray( values ) then reduce() else values.toLowerCase().trim() == 'other'

show = ( $node ) -> $node.removeClass( 'hide-fields' )

hide = ( $node ) ->
  $node.addClass( 'hide-fields' )
  $node.find( 'input' ).val('')

getNextOtherField = ( $node ) -> $node.closest( '.input-field' ).next( '.input-field.other' )

handleSubmitReportFormInsideIFrame = ( iframe  ) ->
  iframeTop = iframe.offsetTop

  document.getElementById( 'report-form' ).addEventListener( 'submit', (e) ->
    parent.scrollTo( 0, iframeTop )
  )

run = () ->
  $type_incident_select = $( 'select.type-incident' )
  $type_location_select = $( 'select.type-location' )
  $town_input = $( 'input.town' )
  iframe = parent.document.querySelector( 'iframe#iSW-report-form' )

  [ $type_incident_select, $type_location_select ].forEach ( $select ) ->
    $otherDiv = getNextOtherField( $select )
    show( $otherDiv ) if otherIsSelected( $select )
    observeNewOptions( $select, $otherDiv )

  if $town_input.val() or $town_input.hasClass( 'error' ) then show( $('.location') )

  if iframe then handleSubmitReportFormInsideIFrame( iframe )
