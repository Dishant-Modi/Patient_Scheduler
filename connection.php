<?php

    // Local XAMPP/WAMP defaults, used when nothing else overrides them.
    $db_host = 'localhost';
    $db_port = 3306;
    $db_user = 'root';
    $db_pass = '';
    $db_name = 'edoc';

    // Environment variables (set via the host's dashboard, e.g. Render) take
    // priority -- this is how the production deployment supplies real creds.
    if (getenv('DB_HOST')) $db_host = getenv('DB_HOST');
    if (getenv('DB_PORT')) $db_port = (int) getenv('DB_PORT');
    if (getenv('DB_USER')) $db_user = getenv('DB_USER');
    if (getenv('DB_PASS')) $db_pass = getenv('DB_PASS');
    if (getenv('DB_NAME')) $db_name = getenv('DB_NAME');

    // config.local.php is gitignored and uploaded directly via FTP -- kept for
    // shared-hosting-style deployments (e.g. InfinityFree) that don't expose
    // environment variables the way a container platform does.
    if (file_exists(__DIR__ . '/config.local.php')) {
        require __DIR__ . '/config.local.php';
    }

    $database = new mysqli($db_host, $db_user, $db_pass, $db_name, $db_port);
    if ($database->connect_error){
        die("Connection failed:  ".$database->connect_error);
    }

?>