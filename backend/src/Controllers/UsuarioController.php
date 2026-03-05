<?php

namespace App\Controllers;

use App\Models\UsuarioModel;

class UsuarioController
{
    private UsuarioModel $model;

    public function __construct()
    {
        $this->model = new UsuarioModel();
    }

    public function index(): void
    {
        $usuarios = $this->model->getAll();
        echo json_encode($usuarios);
    }

    public function show(int $id): void
    {
        $usuario = $this->model->getById($id);
        echo json_encode($usuario);
    }

    // Add store, update, destroy methods as needed
}
