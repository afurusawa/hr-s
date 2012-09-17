<?php
    if(date("l") == "Monday") {
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //monday
        echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+1, date("Y"))); //tuesday
        echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+2, date("Y"))); //wednesday
        echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+3, date("Y"))); //thursday
        echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+4, date("Y"))); //friday
        echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+5, date("Y"))); //saturday
        echo " to ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")+6, date("Y"))); //sunday
    }
    
    if(date("l") == "Tuesday") {
        //echo "tuesday ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))); //mo
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //tu
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+1, date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+2, date("Y"))); //th
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+3, date("Y"))); //fr
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+4, date("Y"))); //sa
        echo " to ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")+5, date("Y"))); //su
    }
    if(date("l") == "Wednesday") {
        //echo "wednesday ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")-2, date("Y"))); //mo
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))); //tu
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+1, date("Y"))); //th
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+2, date("Y"))); //fr
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+3, date("Y"))); //sa
        echo " to ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")+4, date("Y"))); //su
    }
    if(date("l") == "Thursday") {
        //echo "thursday ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")-3, date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-2, date("Y"))); //tu
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //th
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+1, date("Y"))); //fr
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+2, date("Y"))); //sa
        echo " to ";
        echo date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")+3, date("Y"))); //su
        
    }
    if(date("l") == "Friday") {
        //echo "friday ";
        $week = date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")-4, date("Y"))); //mo
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-3, date("Y"))); //tu
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-2, date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))); //th
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //fr
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+1, date("Y"))); //sa
        $week = $week . " to " . date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")+2, date("Y"))); //su
    }
    if(date("l") == "Saturday") {
        //echo "saturday ";
        $week = date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")-5, date("Y"))); //mo
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-4, date("Y"))); //tu
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-3, date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-2, date("Y"))); //th
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))); //fr
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //sa
        $week = $week . " to " . date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")+1, date("Y"))); //su
    }
    if(date("l") == "Sunday") {
        //echo "sunday ";
        $week = date("m/d/Y", mktime(0, 0, 0, date("m"), date("d")-6, date("Y"))); //mo
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-5, date("Y"))); //tu
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-4, date("Y"))); //we
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-3, date("Y"))); //th
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-2, date("Y"))); //fr
        //echo date("m/d/Y;", mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))); //sa
        $week = $week . " to " . date("m/d/Y", mktime(0, 0, 0, date("m"), date("d"), date("Y"))); //su
        echo 
    }
?>