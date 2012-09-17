<?
<?php
    
    // Connect to server and select databse.
    mysql_connect("rapidcon.startlogicmysql.com", "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    
    $currentUser = $_POST["currentUser"];
    //$currentUser = "asuran";
    
    $sql = "SELECT HR_Timesheet.date, HR_LeaveRequests.timestamp FROM HR_LeaveRequests JOIN HR_Users ON HR_LeaveRequests.employeeID=HR_Users.employeeID WHERE HR_LeaveRequests.signed='1' AND HR_Users.manager = '" .$currentUser. "'";
    $entries = mysql_query($sql) or die(mysql_error());
    
    while($val = mysql_fetch_array($entries))
    {
        echo $val['timestamp'] ."=". $val['employeeID'] .";";
    }
    
    ?>