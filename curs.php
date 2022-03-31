<?php
header('Content-Type: text/html; charset=windows-1251');
function isdate($date){
    $dt = DateTime::createFromFormat("d/m/Y", $date);
    return $dt !== false && !array_sum($dt::getLastErrors());
}
//GET
if(isset($_GET['curs'])){
    if(!empty($_GET['curs']) && isdate($_GET['curs'])){
        echo file_get_contents('https://www.cbr.ru/scripts/XML_daily.asp?date_req='.trim($_GET['curs']));
    }
}
else{
//PAGE
    $current_page = $_SERVER['REQUEST_SCHEME']."://".$_SERVER['HTTP_HOST'].$_SERVER["REQUEST_URI"];
?>

<html lang="ru" xml:lang="ru">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<script>
    var app = {
        current_page:'<?=$current_page?>'
    };
</script>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">

                <div class="input-group mb-3">
                    <input type="date" class="form-control" id="date-curs">
                    <button type="button" class="btn btn-primary" onclick="get_curs(document.getElementById('date-curs').value)">Запросить</button>
                </div>
            </div>

            <div class="col-12">
                <div class="alert alert-light alert-place" role="alert">
                    Выбирите дату
                </div>
            </div>
        </div>

    </div>
    <script>
        var curs_ls = 'curs';
        function isempty(v) {
            if(v=='undefined' || v==null ||  v==''){
                return true;
            };
            return false;
        }
        function save_curs(date, value){
            var data = localStorage.getItem(curs_ls);
            if(isempty(data)){
                data = {};
                data[date] = value;
                localStorage.setItem(curs_ls, JSON.stringify(data));
            }else{
                data = JSON.parse(data);
                data[date] = value;
                localStorage.setItem(curs_ls, JSON.stringify(data));
            };

        };
        function load_curs(date) {
            var data = localStorage.getItem(curs_ls);

            if(isempty(data)){return false;};
            data = JSON.parse(data);
            if(data.hasOwnProperty(date)){
                return data[date];
            };
            return false;
        };

        function get_curs(date) {
            if(date=='undefined'){return;};
            if(date.trim()==''){return;};
            var s = date.split('-');
            date = s[2]+'/'+s[1]+'/'+s[0];

            var load = load_curs(date);
            if(load!==false){
                document.getElementsByClassName('alert-place')[0].innerHTML = 'Курс доллара США из базы : '+load;
                return;
            };
            
            var xhr = new XMLHttpRequest();
            xhr.open('GET', app.current_page+'/?curs='+date);
            xhr.send();
            xhr.onload = function() {
                if (xhr.status != 200) {
                    alert(`Ошибка ${xhr.status}: ${xhr.statusText}`);
                } else {
                   // console.log();
                    var dp = new DOMParser();
                    var xml = dp.parseFromString(xhr.response, "application/xml");

                    for(var v=0; v<xml.documentElement.childNodes.length; v++){
                        if(xml.documentElement.childNodes[v].getAttribute('ID')=='R01235'){
                            var valute = xml.documentElement.childNodes[v].childNodes[3].childNodes[0].data;
                            var curs = xml.documentElement.childNodes[v].childNodes[4].childNodes[0].data;
                        };
                    };
                    save_curs(date, curs);
                    document.getElementsByClassName('alert-place')[0].innerHTML = valute+' : '+curs;

                };
            };
            return;
        };





    </script>
</body>
</html>


<?php
}
?>
