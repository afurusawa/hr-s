<?php
    
    // Helper method to send a HTTP response code/message
    function sendResponse($body = '')
    {
        echo $body;
    }
    
    $host='rapidcon.startlogicmysql.com'; // Host name 
    
    $currentDay = $_POST["currentDay"];
    $job = $_POST["job"];
    
    // Connect to server and select databse.
    mysql_connect($host, "mdbuser", "welcome45")or die("cannot connect");
    mysql_select_db("mobiledb") or die( "Unable to select database");

    $sql="SELECT * FROM HR_Jobs";
    $result=mysql_query($sql) or die(mysql_error());
    
    $resultData = "";
    while($row = mysql_fetch_array($result)) {
        $resultData = $resultData . $row['jobNumber'] ."=". $row['jobName'] .";";
    }
    
    echo $resultData;

?>