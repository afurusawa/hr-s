<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $currentDay = $_POST["currentDay"];
    $currentDate = $_POST["currentDate"];
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    //find by day
    $exists = "SELECT * FROM HR_Timesheet WHERE employeeID='" .$currentUser. "' AND date='" .$currentDate. "' AND day='" .$currentDay. "'";
    $results = mysql_query($exists) or die("does not exist");
    $count = mysql_num_rows($results);
    
    while($row = mysql_fetch_array($results)) {
        if($row['jobIndex'] == "1") {
            $result1 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "2") {
            $result2 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "3") {
            $result3 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "4") {
            $result4 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "5") {
            $result5 = $row['job'] ."=". $row['hours'] .";";
        }            
    }
    
    echo $result1 . $result2 . $result3 . $result4 . $result5;
    
?>