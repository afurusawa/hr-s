<?php

    // Connect to server and select databse.
    mysql_connect('rapidcon.startlogicmysql.com', "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");
    
    
    $currentUser = $_POST["currentUser"];

    //Get all workers under user (manager).
    $exists = "SELECT * FROM HR_Users WHERE manager='" .$currentUser. "'";
    $results = mysql_query($exists) or die($currentUser);    
    
    echo "worker;";
    //Concatenate a string of workers under current user.
    while($row = mysql_fetch_array($results)) {
        echo $row['employeeID'] .";"; //data is returned as user1;user2;...userN;
    }
    
?>