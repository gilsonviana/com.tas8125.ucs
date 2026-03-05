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
    $baseDir = __DIR__ . '/src/';

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
use App\Controllers\UsuarioController;
use App\Controllers\VagaController;

$method = $_SERVER['REQUEST_METHOD'];
$uri    = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = rtrim($uri, '/') ?: '/';

// UsuarioController (usuarios)
if ($method === 'GET' && $uri === '/usuarios') {
    (new UsuarioController())->index(); exit;
}
if ($method === 'GET' && preg_match('#^/usuarios/(\d+)$#', $uri, $m)) {
    (new UsuarioController())->show((int)$m[1]); exit;
}
// Add POST, PUT, DELETE as needed

// VagaController (vagas)
if ($method === 'GET' && $uri === '/vagas') {
    (new VagaController())->index(); exit;
}
if ($method === 'GET' && preg_match('#^/vagas/(\d+)$#', $uri, $m)) {
    (new VagaController())->show((int)$m[1]); exit;
}
// Add POST, PUT, DELETE as needed

// 404 fallback
http_response_code(404);
echo json_encode(['error' => 'Route not found']);
