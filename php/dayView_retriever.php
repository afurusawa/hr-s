<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $currentDay = $_POST["currentDay"];
    $currentDate = $_POST["currentDate"];
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    

    $exists = "SELECT * FROM HR_Timesheet WHERE employeeID='" .$currentUser. "' AND date='" .$currentDate. "' AND day='" .$currentDay. "'";
    $results = mysql_query($exists) or die("does not exist");
    $count = mysql_num_rows($results);
    

    // If no entries for the given day was found, insert five entries.
    if($count == 0) {
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '1', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '2', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '3', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '4', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '5', '0')") or die(mysql_error());
        
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '6', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '7', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '8', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '9', '0')") or die(mysql_error());
        mysql_query("INSERT INTO HR_Timesheet (date, day, employeeID, jobIndex, hours) VALUES('" .$currentDate. "', '" .$currentDay. "', '" .$currentUser. "', '10', '0')") or die(mysql_error());
    }
    
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
        
        else if($row['jobIndex'] == "6") {
            $result6 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "7") {
            $result7 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "8") {
            $result8 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "9") {
            $result9 = $row['job'] ."=". $row['hours'] .";";
        }
        else if($row['jobIndex'] == "10") {
            $result10 = $row['job'] ."=". $row['hours'] .";";
        }
    }
    
    echo $result1 . $result2 . $result3 . $result4 . $result5 . $result6 . $result7 . $result8 . $result9 . $result10;
    
?>