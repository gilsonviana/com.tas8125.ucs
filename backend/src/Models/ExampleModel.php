<?php

declare(strict_types=1);

namespace App\Models;

use App\Config\Database;
use PDO;

class ExampleModel
{
    public ?int    $id          = null;
    public string  $name        = '';
    public ?string $description = null;
    public ?string $created_at  = null;

    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /** Return all items ordered by newest first. */
    public function getAll(): array
    {
        $stmt = $this->db->query('SELECT * FROM items ORDER BY created_at DESC');
        return $stmt->fetchAll();
    }

    /** Return a single item by primary key, or null if not found. */
    public function getById(int $id): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM items WHERE id = :id LIMIT 1');
        $stmt->execute([':id' => $id]);
        $row = $stmt->fetch();
        return $row !== false ? $row : null;
    }

    /** Insert a new item and return the created row. */
    public function create(array $data): array
    {
        $stmt = $this->db->prepare(
            'INSERT INTO items (name, description) VALUES (:name, :description)'
        );
        $stmt->execute([
            ':name'        => $data['name'],
            ':description' => $data['description'] ?? null,
        ]);

        $id = (int) $this->db->lastInsertId();
        return $this->getById($id) ?? [];
    }

    /** Update an existing item and return the updated row. */
    public function update(int $id, array $data): array
    {
        $fields = [];
        $params = [':id' => $id];

        if (isset($data['name'])) {
            $fields[]         = 'name = :name';
            $params[':name']  = $data['name'];
        }

        if (array_key_exists('description', $data)) {
            $fields[]                = 'description = :description';
            $params[':description']  = $data['description'];
        }

        if (!empty($fields)) {
            $sql  = 'UPDATE items SET ' . implode(', ', $fields) . ' WHERE id = :id';
            $stmt = $this->db->prepare($sql);
            $stmt->execute($params);
        }

        return $this->getById($id) ?? [];
    }

    /** Delete an item by primary key. */
    public function delete(int $id): void
    {
        $stmt = $this->db->prepare('DELETE FROM items WHERE id = :id');
        $stmt->execute([':id' => $id]);
    }
}
