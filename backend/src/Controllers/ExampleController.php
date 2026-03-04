<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\ExampleModel;

class ExampleController
{
    private ExampleModel $model;

    public function __construct()
    {
        $this->model = new ExampleModel();
    }

    /** GET /items */
    public function index(): void
    {
        $items = $this->model->getAll();
        http_response_code(200);
        echo json_encode($items);
    }

    /** GET /items/{id} */
    public function show(int $id): void
    {
        $item = $this->model->getById($id);

        if ($item === null) {
            http_response_code(404);
            echo json_encode(['error' => 'Item not found']);
            return;
        }

        http_response_code(200);
        echo json_encode($item);
    }

    /** POST /items */
    public function store(): void
    {
        $data = $this->parseJsonBody();

        if (empty($data['name'])) {
            http_response_code(422);
            echo json_encode(['error' => 'Field "name" is required']);
            return;
        }

        $item = $this->model->create($data);
        http_response_code(201);
        echo json_encode($item);
    }

    /** PUT /items/{id} */
    public function update(int $id): void
    {
        $existing = $this->model->getById($id);

        if ($existing === null) {
            http_response_code(404);
            echo json_encode(['error' => 'Item not found']);
            return;
        }

        $data = $this->parseJsonBody();
        $item = $this->model->update($id, $data);
        http_response_code(200);
        echo json_encode($item);
    }

    /** DELETE /items/{id} */
    public function destroy(int $id): void
    {
        $existing = $this->model->getById($id);

        if ($existing === null) {
            http_response_code(404);
            echo json_encode(['error' => 'Item not found']);
            return;
        }

        $this->model->delete($id);
        http_response_code(200);
        echo json_encode(['message' => 'Item deleted successfully']);
    }

    // -----------------------------------------------------------------------

    private function parseJsonBody(): array
    {
        $raw  = file_get_contents('php://input');
        $data = json_decode($raw ?: '{}', true);
        return is_array($data) ? $data : [];
    }
}
