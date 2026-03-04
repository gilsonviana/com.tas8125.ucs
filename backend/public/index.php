<?php

declare(strict_types=1);

// ---------------------------------------------------------------------------
// CORS headers — restrict Access-Control-Allow-Origin to specific origins
// in production instead of using the wildcard '*'.
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle pre-flight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// All responses in this API are JSON.
header('Content-Type: application/json; charset=UTF-8');

// ---------------------------------------------------------------------------
// Autoloader  (maps namespace App\ → <root>/src/)
// ---------------------------------------------------------------------------
spl_autoload_register(function (string $class): void {
    $prefix = 'App\\';
    $baseDir = __DIR__ . '/../src/';

    if (strncmp($prefix, $class, strlen($prefix)) !== 0) {
        return;
    }

    $relative = substr($class, strlen($prefix));
    $file = $baseDir . str_replace('\\', '/', $relative) . '.php';

    if (file_exists($file)) {
        require $file;
    }
});

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------
use App\Controllers\ExampleController;

$method = $_SERVER['REQUEST_METHOD'];
$uri    = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Normalise: strip trailing slash (except root)
$uri = rtrim($uri, '/') ?: '/';

$controller = new ExampleController();

// GET /items
if ($method === 'GET' && $uri === '/items') {
    $controller->index();
    exit;
}

// GET /items/{id}
if ($method === 'GET' && preg_match('#^/items/(\d+)$#', $uri, $m)) {
    $controller->show((int) $m[1]);
    exit;
}

// POST /items
if ($method === 'POST' && $uri === '/items') {
    $controller->store();
    exit;
}

// PUT /items/{id}
if ($method === 'PUT' && preg_match('#^/items/(\d+)$#', $uri, $m)) {
    $controller->update((int) $m[1]);
    exit;
}

// DELETE /items/{id}
if ($method === 'DELETE' && preg_match('#^/items/(\d+)$#', $uri, $m)) {
    $controller->destroy((int) $m[1]);
    exit;
}

// 404 fallback
http_response_code(404);
echo json_encode(['error' => 'Route not found']);
