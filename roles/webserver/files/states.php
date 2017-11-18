<!DOCTYPE html>
<html>
<head>
<title>United States</title>
</head>
<body>
<main>
Here is a list of the states in the USA and their abbreviations:
<ul>
<?php
$server = "db01";
$user = "app";
$pass = "AppSecretPass";
$db = "USA";

$conn = new mysqli($server, $user, $pass, $db);
if ($conn->connect_error) {
    die("It's dead, Jim: " . $conn->connect_error);
}

$sql = "SELECT abbv, name from STATES order by abbv";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<li>" . $row["abbv"] . " - " . $row["name"] . "</li>";
    }
}
else {
    echo "<li>Meteors have become crashed into us.</li>";
}
$conn->close();
?>
</ul>
</main>
</body>
</html>
