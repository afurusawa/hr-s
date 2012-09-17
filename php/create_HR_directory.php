<?php

/************************* Connection Sequence START *************************/
//Connection Information
$mysql_host = "rapidcon.startlogicmysql.com";
$mysql_database = "mobiledb";
$mysql_user = "mdbuser";
$mysql_password = "welcome45";

//Connect to server
mysql_connect($mysql_host, $mysql_user, $mysql_password) 
or die('Could not connect: ' . mysql_error());

//Select db
mysql_select_db($mysql_database) 
or die(mysql_error());
/************************** Connection Sequence END **************************/

/* Create Directory DB */
mysql_query("CREATE TABLE HR_Directory(
	id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id),
	picture VARCHAR(100),
	firstName VARCHAR(50),
	department VARCHAR(50),
    manager VARCHAR(50),
	position VARCHAR(50),
	location VARCHAR(100),
	phone VARCHAR(10),
	email VARCHAR(50))
")
or die(mysql_error());
/* END */

?>