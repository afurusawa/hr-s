<?php
    
    // Connect to server and select databse.
    mysql_connect('rapidcon.startlogicmysql.com', "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    $employeeID = $_POST["currentUser"]; //Employee to sign-off on.
    $timestamp = $_POST["currentDate"]; //Current week.
    
    //On denial, value "signed" in HR_Timesheet table is set back to 0.
    mysql_query("UPDATE HR_LeaveRequests SET signed='0' WHERE employeeID='" .$employeeID. "' AND timestamp='" .$timestamp. "'") or die(mysql_error());
    
    echo "denied";
    
?>