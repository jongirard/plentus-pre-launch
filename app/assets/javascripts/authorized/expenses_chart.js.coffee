$ ->
  $("#expense-chart").highcharts if $("div.main-panel").hasClass("trends") == true
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false

    title: false

    tooltip:
      pointFormat: "{series.name}: <b>{point.percentage:.1f}%</b>"

    credits: false

    plotOptions:
      pie:
        allowPointSelect: true
        cursor: "pointer"
        dataLabels:
          enabled: true
          color: "#000000"
          connectorColor: "#000000"
          format: "<b>{point.name}</b>: {point.percentage:.1f} %"

    series: [
      type: "pie"
      name: "Amount"
      data: 
          gon.expenses
      
    ]
