$ () -> run() if document.querySelector( 'canvas' )

showIncidentsOverTime = () ->
  ctx = document.getElementById( 'incident-count-over-time' )

  # { 2015-06-18 00:00:00 UTC: 1 ... }
  dateCountObj = JSON.parse( ctx.dataset.data )
  dates = Object.keys( dateCountObj )
  values = dates.map( (key) -> dateCountObj[key] )

  data = {
    labels: dates,
    datasets: [{
      label: " Incidents",
      fill: false,
      lineTension: 0.1,
      backgroundColor: "rgba(75,192,192,0.4)",
      borderColor: "rgba(75,192,192,1)",
      borderCapStyle: 'butt',
      pointBorderColor: "rgba(75,192,192,1)",
      pointBackgroundColor: "#fff",
      pointBorderWidth: 5,
      pointHoverRadius: 7,
      pointHoverBackgroundColor: "rgba(75,192,192,1)",
      pointHoverBorderColor: "rgba(220,220,220,1)",
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: values,
      spanGaps: false
    }]
  }

  chart = new Chart(ctx, {
      type: 'line',
      data: data,
      options: {
        layout: {
          padding: 10,
        },
        scales: {
          xAxes: [{
            display: false,
            type: "time",
            time: {
              tooltipFormat: "Do MMMM YYYY"
            }
          }],
          yAxes: [{
          }]
        }
      }
  });

run = () ->
  showIncidentsOverTime();