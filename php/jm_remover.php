<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    //$jobIndex = $_POST["jobIndex"];
    $jobName = $_POST["jobName"];
    
    $currentUser = $_POST["currentUser"];
    //$currentDate = $_POST["currentDate"];
    //$currentDay = $_POST["currentDay"];
    
    $jobName = str_replace("%20", " ", $jobName);
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");    
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    $jobNumber = mysql_query("SELECT jobNumber FROM HR_Jobs WHERE jobName = '" .$jobName. "'") or die(mysql_error());
    
    $jn = "";
    //$count=mysql_num_rows($jobNumber);
    while($row = mysql_fetch_array($jobNumber)) {
        $jn = $row['jobNumber'];
    }
    mysql_query("DELETE FROM HR_JobManagement WHERE employeeID = '" .$currentUser. "' AND jobNumber = '" .$jn. "'") or die(mysql_error());
    
    echo "deleted";
    
    ?>