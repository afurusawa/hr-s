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

    
    /* Create Timesheet DB */
    mysql_query("CREATE TABLE HR_Timesheet(
                id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id),
                date VARCHAR(30),
                day VARCHAR(30),
                employeeID VARCHAR(50),
                job VARCHAR(50),
                jobIndex INT(5),
                hours INT(5),
                signed INT(5))
    ")
    or die(mysql_error());
    /* END */
    
?>