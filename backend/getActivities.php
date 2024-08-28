<?php
$db = mysqli_connect('localhost', 'root', '', 'users');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

if (!$db) {
    echo json_encode("Error: Database connection failed");
    exit;
}

$sql = "SELECT * FROM activity";
$result = mysqli_query($db, $sql);

$activities = [];

if ($result && mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $activities[] = [
            'id' => $row['id'],
            'title' => $row['title'],
            'imagePath' => $row['imagePath'],
            'description' => $row['description'],
            'isJoinable' => $row['isJoinable'] == '1',
            'category' => $row['scoreType'],
            'score' => $row['score'],
            'datetime' => $row['event_dateTime'],
            'location' => $row['location'],
        ];
    }

    echo json_encode(['status' => 'success', 'activities' => $activities]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'No activities found']);
}
?>
