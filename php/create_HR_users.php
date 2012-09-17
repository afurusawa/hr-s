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
    mysql_query("CREATE TABLE HR_Users(
                employeeID INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(employeeID),
                employeeName VARCHAR(50),
                managerName VARCHAR(50))
    ")
    or die(mysql_error());
    /* END */
    
    ?>