<?php
//Connect To Database
$hostname='ebizdeal.db.4247188.hostedresource.com:3306';
$username='ebizdeal';
$password='Hona1%%';
$dbname='ebizdeal';
$usertable='State';
$yourfield = 'code';

mysql_connect($hostname,$username, $password) OR DIE ('Unable to connect to database! Please try again later.');
mysql_select_db($dbname);

$query = 'SELECT * FROM $usertable';
$result = mysql_query($query);
if($result) {
    while($row = mysql_fetch_array($result)){
        $name = $row['$yourfield'];
        echo 'Name: '.$name;
    }
}
?>


<body>

test
</body>
</html>