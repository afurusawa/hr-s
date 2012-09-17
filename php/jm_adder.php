<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 

    $jobName = $_POST["jobName"];   
    $jobName = str_replace("%20", " ", $jobName);
    
    $currentUser = $_POST["currentUser"]; 
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");    
    mysql_select_db("mobiledb") or die( "Unable to select database");
     
    $jobNumber = mysql_query("SELECT jobNumber FROM HR_Jobs WHERE jobName = '" .$jobName. "'") or die(mysql_error());
    
    $jn = "";
    //$count=mysql_num_rows($jobNumber);
    while($row = mysql_fetch_array($jobNumber)) {
        $jn = $row['jobNumber'];
    }
    
    //check if it already exists.
    $sql = "SELECT * FROM HR_JobManagement WHERE employeeID='" .$currentUser. "' AND jobNumber='" .$jn. "'";
    $result = mysql_query($sql) or die(mysql_error());
    $count=mysql_num_rows($result);
    
    if($count >= 1)
    {
        echo "duplicates exist";
    }
    else
    {
        mysql_query("INSERT INTO HR_JobManagement (employeeID, jobNumber) VALUES ('" .$currentUser. "', '" .$jn. "')") or die(mysql_error());
    }
    
    echo "updated";

?>