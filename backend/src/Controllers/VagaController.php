<?php

namespace App\Controllers;

use App\Models\VagaModel;

class VagaController
{
    private VagaModel $model;

    public function __construct()
    {
        $this->model = new VagaModel();
    }

    public function index(): void
    {
        $vagas = $this->model->getAll();
        echo json_encode($vagas);
    }

    public function show(int $id): void
    {
        $vaga = $this->model->getById($id);
        echo json_encode($vaga);
    }
}
