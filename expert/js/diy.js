let naver_stock;
let dart_stock;
let company_code;

const option_ko = {"DERatio": "부채비율 (%)", "PER":"   PER   ", "PBR":"   PBR   "};

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


document.querySelector('#search').addEventListener('click', () => {
    const options = document.querySelectorAll('select.diy-option')
    let result = Object.keys(naver_stock);
    options.forEach(option => {
        if (option.classList.contains("under")){
            result = result.filter(i => naver_stock[i][option.name] <= option.value);
        }
        else if (option.classList.contains("over")){
            result = result.filter(i => naver_stock[i][option.name] >= option.value);
        }
    })
    /*
    <tr><!-- 첫번째 줄 시작 -->
										    <td>첫번째 칸</td>
										    <td>두번째 칸</td>
										</tr><!-- 첫번째 줄 끝 -->
										<tr><!-- 두번째 줄 시작 -->
										    <td>첫번째 칸</td>
										    <td>두번째 칸</td>
                                        </tr><!-- 두번째 줄 끝 --> */
    let tbody = document.querySelector('table#result-table > tbody');
    while (tbody.hasChildNodes()){
        tbody.removeChild(tbody.lastChild);
    }
    result.forEach(item => {
        let tr = document.createElement('tr');
        let td_name = document.createElement('td');
        let a = document.createElement('a');
        a.href = "https://finance.naver.com/item/coinfo.nhn?code=".concat(company_code[item]);
        a.target = "_blank";
        a.innerText = item;
        td_name.appendChild(a);
        tr.appendChild(td_name);
        options.forEach(option => {
            let td = document.createElement('td');
            td.innerText = naver_stock[item][option.name];
            tr.appendChild(td);
        });
        tbody.appendChild(tr);
    });
})

window.onload = function(){
    naver_stock = {};
    dart_stock = {};
    company_code = {};
    console.log('hi there?');
    this.readTextFile('./company_code_naver.json', text => {
        console.log(text);
        company_code = JSON.parse(text);
    })
    readTextFile("./stock.json", text => {naver_stock = JSON.parse(text)});
    readTextFile("./new_accounts.txt", text => {
        let lines = text.split('\n');
        lines.forEach(line => {
            const parsed = line.split(' = ');
            if (parsed.length == 2){
                parsed[1].replace(/\'/gi, "hi")
                let tmpValue = parsed[1].replace(/\'/gi, "\"");
                while (tmpValue.match('None')){
                    tmpValue = tmpValue.replace('None', '\"\"');
                }
                dart_stock[parsed[0]] = JSON.parse(tmpValue);
            }
        })
    });
    let thead = document.querySelector('table#result-table > thead');
    let th = document.createElement('th');
    th.classList.add('table-company')
    th.innerText = '기업명';
    thead.appendChild(th);
    document.querySelectorAll('select.diy-option').forEach(option => {
        let th = document.createElement('th');
        th.innerText = option_ko[option.name];
        thead.appendChild(th);
    })
};