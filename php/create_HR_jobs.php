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
    
    /* Create Timesheet Job Number DB */
    mysql_query("CREATE TABLE HR_Jobs(
                id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id),
                jobNumber INT(10),
                jobName VARCHAR(50),
                totalHours INT(10))
    ")
    or die(mysql_error());
    /* END */

?>