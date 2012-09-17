<?php
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    $currentUser = $_POST["currentUser"]; //value to send
    $password = $_POST["password"]; //value to send 
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    $sql="SELECT * FROM HR_Users WHERE manager= '".$currentUser."'";
    $result=mysql_query($sql) or die(mysql_error());
    
    while($row = mysql_fetch_array($result)) {}
    
    // Mysql_num_row is counting table row
    $count=mysql_num_rows($result);

    // If results yield one or more employees managed by the current user, return manager.
    if($count>=1){
        echo "manager";
    }
    else
    {
        echo "user";
    }
?>