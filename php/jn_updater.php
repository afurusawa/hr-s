<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $jobIndex = $_POST["jobIndex"];
    $jobName = $_POST["jobName"];
    
    $currentUser = $_POST["currentUser"];
    $currentDate = $_POST["currentDate"];
    $currentDay = $_POST["currentDay"];

    $jobName = str_replace("%20", " ", $jobName);

    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");    
    
    mysql_select_db("mobiledb") or die( "Unable to select database");

    $sql = "UPDATE HR_Timesheet SET job='" .$jobName. "' WHERE employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "' AND jobIndex='" .$jobIndex. "'";
    $result = mysql_query($sql) or die(mysql_error());
        
    echo "updated";

?>