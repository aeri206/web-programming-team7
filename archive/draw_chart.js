function readTextFile(file, callback) {
    const rawFile = new XMLHttpRequest();
    rawFile.overrideMimeType("application/json");
    rawFile.open("GET", file, true);
    rawFile.onreadystatechange = function() {
        if (rawFile.readyState === 4 && rawFile.status == "200") {
            callback(rawFile.responseText);
        }
    }
    rawFile.send(null);
}


window.onload = function(){
    
    let ctx = document.querySelector('#myChart');
    let myChart = new Chart(ctx, {
        type: 'horizontalBar',
        // type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: 'Fluctuation rate',
                data: [],
                backgroundColor: 'rgb(2, 2, 85)',
                borderColor: 'rgb(2, 2, 85)',
                borderWidth: 10,
                barThickness : 6,
                minBarLength : 10
            }]
        },
        options: {
            title:{
                display:true,
                text: 'Closing Price Fluctuation rate'
            },
            tooltips:{
                callbacks:{
                    label: (tooltipItem, data) => Math.round(tooltipItem.value * 10000) / 10000 + " %"
                }
            },
            maintainAspectRatio: false
        }
    });
    readTextFile("./sample_data/foreign_abc.json", function(text){
        const data = JSON.parse(text);
        for (let [key, value] of Object.entries(data)) {
            myChart.data.labels.push(key);
            myChart.data.datasets.forEach(dataset => {
                dataset.data.push(value)
            }); 
          }
          myChart.update();
    });
    myChart.height = 1200;
    myChart.update();
    myChart.resize();
}