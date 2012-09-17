<?php

    // Connect to server and select database.
    mysql_connect("rapidcon.startlogicmysql.com", "mdbuser", "welcome45")or die("cannot connect");    
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    //Retrieve POST data.
    $currentUser = $_POST["currentUser"];
    $password = $_POST["password"];
    $date = $_POST["currentDate"];    
    
    //Check if password is a match.
    $pw="SELECT * FROM HR_Users WHERE employeeID='" .$currentUser. "' AND employeePassword= '".$password."'";
    $result=mysql_query($pw) or die(mysql_error());

    // Mysql_num_row is counting the number of results.
    $count=mysql_num_rows($result);
    
    // If one password was found, sign timesheet.
    if($count == 1)
    {
        //When signed, set signed to '1'.
        $sql = "UPDATE HR_Timesheet SET signed='1', timestamp='" . date("F j, Y, g:i a") . "' WHERE employeeID='" .$currentUser. "' AND date='" .$date. "'";
        $result = mysql_query($sql) or die(mysql_error());
    }
    
    // Returns 1 if password was found (passed), 0 if not found (failed).
    echo $count;
    
?>