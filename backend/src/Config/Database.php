<?php

declare(strict_types=1);

namespace App\Config;

use PDO;
use PDOException;

class Database
{
    private static ?PDO $connection = null;

    public static function getConnection(): PDO
    {
        if (self::$connection === null) {
            $host     = getenv('DB_HOST')     ?: 'localhost';
            $dbName   = getenv('DB_NAME')     ?: 'appdb';
            $user     = getenv('DB_USER')     ?: 'appuser';
            $password = getenv('DB_PASSWORD') ?: 'apppassword';

            $dsn = "mysql:host={$host};dbname={$dbName};charset=utf8mb4";

            try {
                self::$connection = new PDO($dsn, $user, $password, [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ]);
            } catch (PDOException $e) {
                http_response_code(500);
                echo json_encode(['error' => 'Database connection failed']);
                exit;
            }
        }

        return self::$connection;
    }
}
