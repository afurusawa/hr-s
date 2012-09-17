<?php

// Helper method to send a HTTP response code/message
function sendResponse($body = '')
{
    echo $body;
}

$host='rapidcon.startlogicmysql.com'; // Host name 
    $username = $_POST["username"]; //value to send
    $password = $_POST["password"]; //value to send 

// Connect to server and select databse.
mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
mysql_select_db("mobiledb") or die( "Unable to select database");

$sql="SELECT * FROM HR_Users WHERE employeeID= '".$username."'";
$result=mysql_query($sql) or die(mysql_error());


while($row = mysql_fetch_array($result)) {}

// Mysql_num_row is counting table row
$count=mysql_num_rows($result);

// If result matched $myusername and $mypassword, table row must be 1 row
if($count==1){
	sendResponse("true");
	return true;
}else
{
	sendResponse($username);
	return false;
}
?>