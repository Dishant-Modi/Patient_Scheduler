<?php

    // Real DB credentials live in config.local.php, which is gitignored and
    // uploaded straight to the host via FTP -- never committed to this repo.
    // Falls back to local XAMPP/WAMP defaults when that file doesn't exist.
    $db_host = 'localhost';
    $db_user = 'root';
    $db_pass = '';
    $db_name = 'edoc';

    if (file_exists(__DIR__ . '/config.local.php')) {
        require __DIR__ . '/config.local.php';
    }

    $database = new mysqli($db_host, $db_user, $db_pass, $db_name);
    if ($database->connect_error){
        die("Connection failed:  ".$database->connect_error);
    }

?>