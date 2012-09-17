<?php
    
    // Connect to server and select databse.
    mysql_connect('rapidcon.startlogicmysql.com', "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    
    $currentUser = $_POST["currentUser"];
    //$currentUser = "asuran";
    
    $sql = "SELECT HR_Jobs.jobName FROM HR_JobManagement JOIN HR_Jobs ON HR_JobManagement.jobNumber=HR_Jobs.jobNumber WHERE HR_JobManagement.employeeID = '" .$currentUser. "'";
    $entries = mysql_query($sql) or die(mysql_error());
    
    echo "job;";
    
    while($val = mysql_fetch_array($entries))
    {
        echo $val['jobName'] . ";";
    }
    
    ?>