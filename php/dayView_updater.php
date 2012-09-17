<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 

    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    $currentUser = $_POST["currentUser"];
    $currentDay = $_POST["currentDay"];
    $currentDate = $_POST["currentDate"];
    
    $hrs1 = $_POST["hrs1"];
    $hrs2 = $_POST["hrs2"];
    $hrs3 = $_POST["hrs3"];
    $hrs4 = $_POST["hrs4"];
    $hrs5 = $_POST["hrs5"];
    $hrs6 = $_POST["hrs6"];
    $hrs7 = $_POST["hrs7"];
    $hrs8 = $_POST["hrs8"];
    $hrs9 = $_POST["hrs9"];
    $hrs10 = $_POST["hrs10"];
    
    $sql1 = "UPDATE HR_Timesheet SET hours='" .$hrs1. "' WHERE jobIndex='1' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql1) or die(mysql_error());

    //echo $sql1;
    
    $sql2 = "UPDATE HR_Timesheet SET hours='" .$hrs2. "' WHERE jobIndex='2' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql2) or die(mysql_error());
    
    $sql3 = "UPDATE HR_Timesheet SET hours='" .$hrs3. "' WHERE jobIndex='3' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql3) or die(mysql_error());
    
    $sql4 = "UPDATE HR_Timesheet SET hours='" .$hrs4. "' WHERE jobIndex='4' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql4) or die(mysql_error());
    
    $sql5 = "UPDATE HR_Timesheet SET hours='" .$hrs5. "' WHERE jobIndex='5' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql5) or die(mysql_error());
   
    
    $sql6 = "UPDATE HR_Timesheet SET hours='" .$hrs6. "' WHERE jobIndex='6' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql1) or die(mysql_error());
    
    $sql7 = "UPDATE HR_Timesheet SET hours='" .$hrs7. "' WHERE jobIndex='7' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql2) or die(mysql_error());
    
    $sql8 = "UPDATE HR_Timesheet SET hours='" .$hrs8. "' WHERE jobIndex='8' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql3) or die(mysql_error());
    
    $sql9 = "UPDATE HR_Timesheet SET hours='" .$hrs9. "' WHERE jobIndex='9' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql4) or die(mysql_error());
    
    $sql10 = "UPDATE HR_Timesheet SET hours='" .$hrs10. "' WHERE jobIndex='10' AND employeeID='" .$currentUser. "' AND day='" .$currentDay. "' AND date='" .$currentDate. "'";
    mysql_query($sql5) or die(mysql_error());

    
?>