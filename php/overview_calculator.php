<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentUser = $_POST["currentUser"];
    $currentDate = $_POST["currentDate"];
    
    //$currentUser = "afurusawa";
    //$currentDate = "7/9/2012";
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    
    $total_hours_week = 0;
    
    $total_hours_day = "";
    $total_proj_day = "";

    $monday = "m";
    $tuesday = "t";
    $wednesday = "w";
    $thursday = "th";
    $friday = "f";
    $saturday = "s";
    $sunday = "su";
    
    $pmonday = "m";
    $ptuesday = "t";
    $pwednesday = "w";
    $pthursday = "th";
    $pfriday = "f";
    $psaturday = "s";
    $psunday = "su";
    
    //Monday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Monday' AND employeeID='" .$currentUser. "'";
    $mon=mysql_query($sql) or die(mysql_error());
    
    $hours = 0; //total hours per day
    $projects = 0; //total projects per day
    $job = "0";
    while($row = mysql_fetch_array($mon)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
            $job = $row['job'];
            $monday = $monday .";". $row['hours'];
            $pmonday = $pmonday .";". $job;
        }
        
    }
    $total_hours_day = $hours;
    $total_proj_day = $projects;

    
    
    
    //Tuesday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Tuesday' AND employeeID='" .$currentUser. "'";
    $tue=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    $job = "0";
    while($row = mysql_fetch_array($tue)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
            $job = $row['job'];
            $tuesday = $tuesday .";". $row['hours'];
            $ptuesday = $ptuesday .";". $job;
        }
    }
    $total_hours_day = $total_hours_day .";". $hours;
    $total_proj_day = $total_proj_day .";". $projects;
   
    
    
    
    
    //Wednesday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Wednesday' AND employeeID='" .$currentUser. "'";
    $wed=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    $job = "0";
    while($row = mysql_fetch_array($wed)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
            $job = $row['job'];
            $wednesday = $wednesday .";". $row['hours'];
            $pwednesday = $pwednesday .";". $job;
        }
    }
    $total_hours_day = $total_hours_day .";". $hours;
    $total_proj_day = $total_proj_day .";". $projects;

    
    
    
    
    
    //Thursday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Thursday' AND employeeID='" .$currentUser. "'";
    $thu=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    $job = "0";
    while($row = mysql_fetch_array($thu)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
            $job = $row['job'];
            $thursday = $thursday .";". $row['hours'];
            $pthursday = $pthursday .";". $job;
        }
    }
    $total_hours_day = $total_hours_day .";". $hours;
    $total_proj_day = $total_proj_day .";". $projects;

    
    
    
    
    
    //Friday
    $sql="SELECT * FROM HR_Timesheet WHERE date='" .$currentDate. "' AND day='Friday' AND employeeID='" .$currentUser. "'";
    $fri=mysql_query($sql) or die(mysql_error());
    
    $hours = 0;
    $projects = 0;
    $job = "0";
    while($row = mysql_fetch_array($fri)) {
        $total_hours_week = $total_hours_week + intval($row['hours']);
        $hours = $hours + intval($row['hours']);
        
        if(!empty($row['job']))
        {
            $projects = $projects + 1;
            $job = $row['job'];
            $friday = $friday .";". $row['hours'];
            $pfriday = $pfriday .";". $job;
        }

    }
    $total_hours_day = $total_hours_day .";". $hours;
    $total_proj_day = $total_proj_day .";". $projects;

    
    
    
    
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
            $job = $row['job'];
            $saturday = $saturday .";". $row['hours'];
            $psaturday = $psaturday .";". $job;
        }

    }
    $total_hours_day = $total_hours_day .";". $hours;
    $total_proj_day = $total_proj_day .";". $projects;

    
    
    
    
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
            $job = $row['job'];
            $psunday = $psunday .";". $job;
            $sunday = $sunday .";". $row['hours'];
        }

    }
    
    $total_hours_day = $total_hours_day .";". $hours;
    $total_proj_day = $total_proj_day .";". $projects;
    
    
//    echo "<br />" . $total_hours_day;
//    echo "<br />" . $total_proj_day;
//
//    echo "<br />";
//    
//    echo "<br />" . $monday.":";
//    echo "<br />" . $tuesday.":";
//    echo "<br />" . $wednesday.":";
//    echo "<br />" . $thursday.":";
//    echo "<br />" . $friday.":";
//    echo "<br />" . $saturday.":";
//    echo "<br />" . $sunday.":";
//    
//    echo "<br />";    
//
//    echo "<br />" . $pmonday .":";
//    echo "<br />" . $ptuesday.":";
//    echo "<br />" . $pwednesday.":";
//    echo "<br />" . $pthursday.":";
//    echo "<br />" . $pfriday.":";
//    echo "<br />" . $psaturday.":";
//    echo "<br />" . $psunday.":";
//    
//    echo "<br />";    
//    
//    echo "<br />" . $total_hours_week;
    
    echo $total_hours_day . "/" . $total_proj_day . "/" . $monday.":" . $tuesday.":" . $wednesday.":" . $thursday.":" . $friday.":" . $saturday.":" . $sunday."/" . $pmonday .":" . $ptuesday.":" . $pwednesday.":" . $pthursday.":" . $pfriday.":" . $psaturday.":" . $psunday."/" . $total_hours_week;
?>




