<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $currentDate = $_POST["currentDate"];
    
    //echo $currentDate;

    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
//
//    $sql="SELECT * FROM HR_LeaveRequests WHERE employeeID='" .$currentUser. "'";
//    $results=mysql_query($sql) or die(mysql_error());
//    
//    while($row = mysql_fetch_array($results)) {
//        $pieces = explode(", ", $row['timestamp']); 
//        
//        //pieces[0] = month dd (e.g. August 1)
//        $date = explode(" ", $pieces[0]);
//        //$date[0]; = month
//        //$date[1] = day
//        //$pieces[1] = year
//        if($pieces[0]=== "January") {
//            $date[0] = "1";
//        }
//        else if($pieces[0]=== "February") {
//            $date[0] = "2";
//        }
//        else if($pieces[0]=== "March") {
//            $date[0] = "3";
//        }
//        else if($pieces[0]=== "April") {
//            $date[0] = "4";
//        }
//        else if($pieces[0]=== "May") {
//            $date[0] = "5";
//        }
//        else if($pieces[0]=== "June") {
//            $date[0] = "6";
//        }
//        else if($pieces[0]=== "July") {
//            $date[0] = "7";
//        }
//        else if($pieces[0]=== "August") {
//            $date[0] = "8";
//        }
//        else if($pieces[0]=== "September") {
//            $date[0] = "9";
//        }
//        else if($pieces[0]=== "October") {
//            $date[0] = "10";
//        }
//        else if($pieces[0]=== "November") {
//            $date[0] = "11";
//        }
//        else if($pieces[0]=== "December") {
//            $date[0] = "12";
//        }
//        $newDate = $date[0] ."/".  $date[1]  ."/". $pieces[1] . ";";
//        echo $newDate;
//        
//    }
//    
//    
    
    $total_hours_week = 0;
    $signed = "0";
    //Return #totalHours=#totalProjects;...; #totalweekhours;

    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND employeeID='" .$currentUser. "'";
    $res=mysql_query($sql) or die(mysql_error());
    
    echo $sql;
    
    while($row = mysql_fetch_array($res)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        
        if($row['signed'] === "0") {
            $signed = "0";
        }
        else {
            $signed = $row['signed'];
        }
    }
    
    
    echo $signed .";". $total_hours_week;
    
    
    
?>