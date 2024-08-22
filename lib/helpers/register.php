<?php
$db = mysqli_connect('localhost','root','','userdata');
if(!$db)
{
    echo "Database connection failed";
}
$email = $_POST['email'];
$password = $_POST['password'];
$phoneNumber = $_POST['phoneNumber'];
$studentId = $_POST['studentId'];
$isAdmin = false;

$sql = "SELECT username FROM users WHERE username = '".$username."'";
$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);

if($count == 1){
    echo json_encode("Error");
}else{
    $insert = "INSERT INTO users(email,password,phoneNumber,studentId,isAdmin) VALUES ('".$email."','".$password."','".$phoneNumber."','".$studentId."','".$isAdmin."')";
        $query = mysqli_query($db,$insert);
        if($query){
            echo json_encode("Success");
        }
}
?>