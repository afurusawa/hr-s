<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $type = $_POST["leaveType"];
    $startDate = $_POST["startDate"];
    $endDate = $_POST["endDate"];
    $reason = $_POST["reason"];
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    
    $sql = "SELECT * FROM HR_LeaveRequests WHERE employeeID='" .$currentUser. "' AND startDate='" .$startDate. "' AND endDate='" .$endDate ."'" ;
    $result = mysql_query($sql) or die(mysql_error());
    $count=mysql_num_rows($result);
    
    if($count >= 1)
    {
        echo "duplicates exist";
    }
    else
    {
        
        mysql_query("INSERT INTO HR_LeaveRequests (employeeID, type, startDate, endDate, reason, signed, timestamp) VALUES('" 
                    .$currentUser. "', '" 
                    .$type. "', '" 
                    .$startDate. "', '" 
                    .$endDate. "', '" 
                    .$reason. "', "
                    ."'1', '"
                    . date("F j, Y, g:ia")
                    ."')") or die(mysql_error());
    }
    
    echo "signed";
    
?>