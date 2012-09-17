<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $currentDate = $_POST["currentDate"];

    //echo $currentUser . "<br/>";
    //echo $currentDate;
    //$currentUser = "afurusawa";
    //$currentDate = "July 31, 2012, 8:33pm";
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    $sql="SELECT * FROM HR_Users WHERE employeeID='" .$currentUser. "'";
    $name=mysql_query($sql) or die(mysql_error());
    while($row = mysql_fetch_array($name)) {
        echo $row['employeeName'] .";";
    }

    
    $sql="SELECT * FROM HR_LeaveRequests WHERE employeeID='" .$currentUser. "' AND timestamp='" .$currentDate. "'";
    $result=mysql_query($sql) or die(mysql_error());

    //echo $sql;
    
    while($row = mysql_fetch_array($result)) {
        $resultData = $row['startDate'] .";". $row['endDate'] .";". $row['type'] .";". $row['reason'];
    }
    
    echo $resultData;
?>
