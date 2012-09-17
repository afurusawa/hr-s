<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $currentDate = $_POST["currentDate"];

    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    $total_hours_week = 0;
    
    //Return #totalHours=#totalProjects;...; #totalweekhours;
    
    //Monday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Monday' AND employeeID='" .$currentUser. "'";
    $mon=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($mon)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";
    
    
    //Tuesday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Tuesday' AND employeeID='" .$currentUser. "'";
    $tue=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($tue)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";
    
    
    //Wednesday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Wednesday' AND employeeID='" .$currentUser. "'";
    $wed=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($wed)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";
    
    
    //Thursday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Thursday' AND employeeID='" .$currentUser. "'";
    $thu=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($thu)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";
    
    
    //Friday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Friday' AND employeeID='" .$currentUser. "'";
    $fri=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($fri)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";
    
    
    //Saturday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Saturday' AND employeeID='" .$currentUser. "'";
    $sat=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($sat)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";    
    
    //Sunday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Sunday' AND employeeID='" .$currentUser. "'";
    $sun=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    while($row = mysql_fetch_array($sun)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
        }
    }
    echo $hours ."=". $projects .";";
    
    echo $total_hours_week ."=0;";
    ?>