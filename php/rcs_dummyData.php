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

    
    // Insert a row of information into the table "example"
    mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, job, jobIndex, hours) VALUES('07/02/2012', 'Monday', '1', 'Overhead', '1', '5')") or die(mysql_error());
    mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, job, jobIndex, hours) VALUES('07/02/2012', 'Monday', '1', 'iOS development', '2', '3')") or die(mysql_error());
    mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, job, jobIndex, hours) VALUES('07/02/2012', 'Tuesday', '1', 'iOS development', '1', '4')") or die(mysql_error());
//    
//    mysql_query("INSERT INTO HR_Jobs (jobNumber, jobName) VALUES(100, 'Overhead')") or die(mysql_error());
//    mysql_query("INSERT INTO HR_Jobs (jobNumber, jobName) VALUES(110, 'iOS internal')") or die(mysql_error());
//    mysql_query("INSERT INTO HR_Jobs (jobNumber, jobName) VALUES(120, 'Android internal')") or die(mysql_error());
//    mysql_query("INSERT INTO HR_Jobs (jobNumber, jobName) VALUES(150, 'external project1')") or die(mysql_error());
//    
//    mysql_query("INSERT INTO HR_Users (employeeName, managerName) VALUES('John Doe', 'Rick Roll')") or die(mysql_error());
//    mysql_query("INSERT INTO HR_Users (employeeName, managerName) VALUES('user', 'Billy Boss')") or die(mysql_error());
?>