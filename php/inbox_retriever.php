<?php
    
    // Connect to server and select databse.
    mysql_connect("rapidcon.startlogicmysql.com", "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    
    $currentUser = $_POST["currentUser"];
    
    $sql = "SELECT HR_Timesheet.employeeID, HR_Timesheet.date, HR_Timesheet.timestamp FROM HR_Timesheet JOIN HR_Users ON HR_Timesheet.employeeID=HR_Users.employeeID WHERE HR_Timesheet.signed='1' AND HR_Users.manager = '" .$currentUser. "'";
    $entries = mysql_query($sql) or die(mysql_error());
    
    //echo $sql;
    
    $stack = array("0");
    while($val = mysql_fetch_array($entries))
    {
        array_push($stack, $val['date'] ."=". $val['employeeID'] ."=". $val['timestamp'] .";");
    }

    for($i = 1; $i < sizeof($stack); $i++)
    {
        if(!($stack[$i] === $stack[$i-1]))
        {
            echo $stack[$i];
        }
    }
?>