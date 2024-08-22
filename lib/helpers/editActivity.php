<?php
// Connect to the database
$db = mysqli_connect('localhost', 'root', '', 'userdata');

// Check connection
if (!$db) {
    echo json_encode("Database connection failed");
    exit();
}

// Retrieve POST data
$id = $_POST['id'];
$title = $_POST['title'];
$description = $_POST['description'];
$scoreType = $_POST['scoreType'];
$score = $_POST['score'];

// Check if the record exists
$sql = "SELECT id FROM activity WHERE id = ?";
$stmt = mysqli_prepare($db, $sql);
mysqli_stmt_bind_param($stmt, 'i', $id);
mysqli_stmt_execute($stmt);
mysqli_stmt_store_result($stmt);

if (mysqli_stmt_num_rows($stmt) == 1) {
    // Record exists, update it
    $edit = "UPDATE activity SET title = ?, description = ?, scoreType = ?, score = ? WHERE id = ?";
    $stmt = mysqli_prepare($db, $edit);
    mysqli_stmt_bind_param($stmt, 'ssssi', $title, $description, $scoreType, $score, $id);
    if (mysqli_stmt_execute($stmt)) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error updating record");
    }
} else {
    // Record does not exist
    echo json_encode("Error: Record not found");
}

// Close statement and connection
mysqli_stmt_close($stmt);
mysqli_close($db);
?>
