const fs = require('fs')
fs.readFile("log.log",(err,data) => {
    if(err){
        console.error(err);
        return;
    }
    let benchData = JSON.parse(data);
    let general = benchData["General"];
    let repetitions = general["Repetitions:"];
    let benchmarkTypes = Object.keys(benchData).slice(1);
    let averages = {};
    benchmarkTypes.forEach(type => {
        averages[type] = computeAverage(benchData[type], repetitions);
    })

    fs.writeFile('averages.json', JSON.stringify(averages,null, "\t"), 'utf8', (err) => {
        if(err){
            console.error(err);
            return;
        }
        console.log("Sucessfully saved file");
    });

    
})


function computeAverage(benchmarkdata, repetitions){
    let cleaned = {};
    benchmarkdata.forEach(run => {
        run.forEach(query => {
            if(!cleaned[query["Filename"]]){
                cleaned[query["Filename"]] = {
                    times : [],
                    average : 0,
                    max : 0,
                    min : undefined
                }
            }

            cleaned[query["Filename"]].times.push(query["times"])
        })

    })

    Object.keys(cleaned).forEach(key => {
        cleaned[key].times = cleaned[key].times.map(time => {
            if(time.indexOf(";") != time.lastIndexOf(";")){
                let subtimes = time.split(";");
                subtimes = subtimes.map(sub  => {
                    return sub.trim();
                })
                time = subtimes.reduce((p,c) => {
                    return +p + +c;
                }, 0)
            } else {
                time = time.trim();
                time = time.replace(';','');

                time = +time;
            }
            return time;
        })
    })
    Object.keys(cleaned).forEach(key => {
        cleaned[key].average = cleaned[key].times.reduce((p,c) => {
            if(c >= cleaned[key].max){
                cleaned[key].max = c;
            }

            if(!cleaned[key].min || c <= cleaned[key].min){
                cleaned[key].min = c;
            }

            return p+c;
        }, 0) / repetitions;
        delete cleaned[key].times;
    })



    return cleaned;
}

function buildLatexTable(data, tableName, headerData){
    const tableBegin = "\begin{tabularx}{\linewidth}" + buildColumDefinition(data[Object.keys(data)[0]]) + "\n"
    const header = tableHeader(headerData);
    const body = tableBody(data);
    const tableEnd = "\end{tabularx}\n"

    return tableBegin + header + tableBody + tableEnd;
}

function tableHeader(headerData){
    let header = "";
    headerData.forEach(col => {
        header += col + "&";
    })

    return header.slice(-1) + "\\\n";
}

function tableBody(data){
    let body = "";
    Object.keys(data).forEach(key => {
        let temp = data[key];
        temp["query"] = key;
        body += tableRow(temp);
    })

    return body;
}

function buildColumDefinition(row){
    let columnString = "{x";

    Object.keys(row).forEach(key => {
        columnString += "x";
    })

    columnString += "}";
    return columnString;
}

function tableRow(rowData){
    let rowString = "";

    Object.keys(rowData).forEach(key => {
        rowString += rowData[key] + "&";
    })

    return rowString.slice(-1) + "\\\n";
}