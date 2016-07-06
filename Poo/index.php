<?php

if(isset($_POST['submit']) && $_POST['submit'] != ''){
    $searchString   = $_POST['searchString'];
    $correctString  = str_replace(" ","+",$searchString);
    $youtubeUrl = "https://www.youtube.com/results?search_query=". $correctString;
    $getHTML        = file_get_contents($youtubeUrl);
    $pattern        = '/<a href="\/watch\?v=(.*?)"/i';

    if(preg_match($pattern, $getHTML, $match)){
            $videoID    = $match[1];
    } else {
            echo "Something went wrong!";
            exit;
    }

    echo '<iframe style="width:230px;height:60px;border:0;overflow:hidden;" scrolling="no" src="//www.youtubeinmp3.com/widget/button/?video=https://www.youtube.com/watch?v='. $videoID .'"&color=c91818>';
    }

?>


<!DOCTYPE HTML>
<html>
    <head>
            <title>Sukeesh || Music Streamer</title>
    <link href="//www.w3resource.com/includes/bootstrap.css" rel="stylesheet">  
    
    <style type="text/css">  
        body{margin-top: 50px; margin-left: 50px}  
    </style> 
    
    </head>
    <body>
            <form method="post" action="index.php" accept-charset="utf-8">
                    Enter Song name : <input type="text" name="searchString" />
                    <input type="submit" name="submit" value="Search" />
            </form>
    </body>
</html>