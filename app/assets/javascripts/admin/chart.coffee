$ () -> buildCharts() if document.querySelector( 'canvas' )

getDateFormat = ( unit ) ->
  switch unit
    when 'day' then "Do MMM YYYY"
    when 'month' then "MMM YYYY"
    when 'year' then "YYYY"
    else "Do MMMM YYYY"

getPointColours = ( values ) ->
  values.map ( value ) ->
    if value == 0 then 'rgba(175,175,175,1)' else 'rgba(239,70,45,1)'

data = ( labels, values ) ->
  pointColours = getPointColours( values )

  {
    labels: labels,
    datasets: [{
      label: " Incidents",
      fill: false,
      lineTension: 0.1,
      backgroundColor: "rgba(243,243,243,0.4)",
      borderColor: "rgba(80,182,172,1)",
      borderCapStyle: 'butt',
      pointBorderColor: pointColours,
      pointBackgroundColor: "#fff",
      pointBorderWidth: 5,
      pointHoverRadius: 7,
      pointHoverBackgroundColor: pointColours,
      pointHoverBorderColor: "rgba(243,243,243,1)",
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: values,
      spanGaps: false
    }]
  }

options = ( ctx ) ->
  {
    responsive: true,
    maintainAspectRatio: false,
    title: {
      display: true,
      text: ('Incident Count By ' + ctx.dataset.timeUnit).toUpperCase(),
      fontSize: 16,
      fontFamily: "'Roboto', 'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
    },
    layout: { padding: 10 },
    legend: { display: false },
    scales: {
      xAxes: [{
        display: true,
        type: 'time',
        time: {
          unit: ctx.dataset.timeUnit,
          tooltipFormat: getDateFormat( ctx.dataset.timeUnit )
        },
        ticks: {
          autoSkip: true,
          autoSkipPadding: 30
        }
      }],
      yAxes: [{
        ticks: {
          beginAtZero: true,
          callback: (value) ->
            if Math.floor( value ) == value then value
        }
      }]
    }
  }

showIncidentsOverTime = () ->
  ctx = document.getElementById( 'incident-count-over-time' )

  # { 2015-06-18 00:00:00 UTC: 1 ... }
  dateCountObj = JSON.parse( ctx.dataset.data )
  dates = Object.keys( dateCountObj )
  values = dates.map( (key) -> dateCountObj[key] )

  chart = new Chart(ctx, {
    type: 'line',
    data: data( dates, values ),
    options: options( ctx )
  });

buildCharts = () ->
  showIncidentsOverTime()