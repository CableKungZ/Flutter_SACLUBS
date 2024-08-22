<?php
 $db = mysqli_connect('localhost','root','','userdata');

 $phoneNumber = $_POST['phoneNumber'];
 $password = $_POST['password'];

 $sql = "SELECT * FROM users WHERE phoneNumber = '".$phoneNumber."' AND password = '".$password."'";
 $result = mysqli_query($db,$sql);
 $count = mysqli_num_rows($result);

 if($count == 1){
    echo json_encode("Success");
 } 
 else{
    echo json_encode("Error");
 }
?>