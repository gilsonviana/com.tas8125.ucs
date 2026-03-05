SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

-- -------------------------------------------------------------
--  Usuários
--  Senhas geradas com password_hash() do PHP (bcrypt)
--  admin@vagacity.com  → senha: admin123
--  Candidatos          → senha: senha123
-- -------------------------------------------------------------
INSERT INTO usuarios (nome, email, senha, tipo) VALUES
    ('Administrador',   'admin@vagacity.com',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
    ('Ana Paula Lima',  'ana@email.com',        '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'candidato'),
    ('Bruno Martins',   'bruno@email.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'candidato'),
    ('Carla Souza',     'carla@email.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'candidato'),
    ('Diego Ferreira',  'diego@email.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'candidato');

INSERT INTO perfis (usuario_id, escolaridade, competencias, cidade) VALUES
    (2, 'Graduação',    'Excel, Power BI, Atendimento ao cliente, Comunicação', 'Caxias do Sul'),
    (3, 'Técnico',      'PHP, MySQL, JavaScript, Git, Linux',                  'Caxias do Sul'),
    (4, 'Pós-graduação','Contabilidade fiscal, SPED, Excel avançado, SAP',     'Farroupilha'),
    (5, 'Ensino Médio', 'Vendas, Atendimento ao cliente, Caixa, Estoque',      'Bento Gonçalves');

INSERT INTO setores (nome) VALUES
    ('Tecnologia'),
    ('Contabilidade'),
    ('Administração'),
    ('Varejo'),
    ('Saúde'),
    ('Educação'),
    ('Logística'),
    ('Recursos Humanos'),
    ('Marketing'),
    ('Jurídico');

INSERT INTO perfis_setores (perfil_id, setor_id, anos_experiencia) VALUES
    (1, 3,  3),   -- Ana:   Administração, 3 anos
    (1, 8,  1),   -- Ana:   RH, 1 ano
    (2, 1,  2),   -- Bruno: Tecnologia, 2 anos
    (3, 2,  5),   -- Carla: Contabilidade, 5 anos
    (4, 4,  0),   -- Diego: Varejo, menos de 1 ano
    (4, 9,  1);   -- Diego: Marketing, 1 ano

INSERT INTO vagas (titulo, empresa, setor_id, cidade, descricao, requisitos, ativa) VALUES
    (
        'Desenvolvedor PHP Júnior',
        'Soluções TI Ltda.',
        1, -- Tecnologia
        'Caxias do Sul',
        'Desenvolvimento e manutenção de sistemas web utilizando PHP e MySQL. Atuação em projetos internos e para clientes da região.',
        'PHP, MySQL, HTML, CSS, JavaScript. Desejável: Git, noções de REST.',
        1
    ),
    (
        'Analista de Contabilidade',
        'Contábil Serra Gaúcha',
        2, -- Contabilidade
        'Caxias do Sul',
        'Responsável pela escrituração fiscal e contábil, apuração de tributos e elaboração de relatórios gerenciais.',
        'Graduação em Ciências Contábeis. Conhecimento em SPED e rotinas fiscais. Experiência mínima de 2 anos.',
        1
    ),
    (
        'Assistente Administrativo',
        'Grupo Pioneiro',
        3, -- Administração
        'Farroupilha',
        'Suporte às rotinas administrativas, controle de documentos, atendimento a fornecedores e apoio ao setor financeiro.',
        'Ensino médio completo. Pacote Office. Experiência na função será diferencial.',
        1
    ),
    (
        'Vendedor Externo',
        'Redes Sul Comércio',
        4, -- Varejo
        'Bento Gonçalves',
        'Prospecção e atendimento de clientes na região da Serra Gaúcha. Venda de produtos de linha doméstica.',
        'Experiência em vendas externas. CNH categoria B. Habilidade de negociação.',
        1
    ),
    (
        'Analista de Marketing Digital',
        'Agência Conecta',
        9, -- Marketing
        'Caxias do Sul',
        'Planejamento e execução de campanhas em mídias sociais, criação de conteúdo e análise de métricas de desempenho.',
        'Graduação em Marketing, Publicidade ou área afim. Experiência com Meta Ads e Google Ads.',
        1
    ),
    (
        'Auxiliar de Logística',
        'TransSerra Transportes',
        7, -- Logística
        'Caxias do Sul',
        'Organização e controle de estoque, separação de pedidos, apoio na conferência de cargas e emissão de notas fiscais.',
        'Ensino médio completo. Experiência com rotinas de almoxarifado será considerada.',
        1
    ),
    (
        'Estágio em Tecnologia da Informação',
        'Soluções TI Ltda.',
        1, -- Tecnologia
        'Caxias do Sul',
        'Apoio no desenvolvimento de sistemas internos e suporte técnico aos usuários. Horário flexível compatível com grade curricular.',
        'Cursando Análise e Desenvolvimento de Sistemas ou área afim a partir do 3º semestre.',
        1
    ),
    (
        'Analista de RH',
        'Grupo Pioneiro',
        8, -- Recursos Humanos
        'Farroupilha',
        'Condução de processos seletivos, integração de novos colaboradores, controle de ponto e apoio ao DP.',
        'Graduação em Psicologia, Administração ou RH. Conhecimento em legislação trabalhista.',
        0  -- vaga inativa (encerrada)
    );

INSERT INTO candidaturas (usuario_id, vaga_id) VALUES
    (2, 3),   -- Ana        Assistente Administrativo
    (2, 5),   -- Ana        Analista de Marketing Digital
    (3, 1),   -- Bruno      Desenvolvedor PHP Júnior
    (3, 7),   -- Bruno      Estágio em TI
    (4, 2),   -- Carla      Analista de Contabilidade
    (5, 4),   -- Diego      Vendedor Externo
    (5, 5);   -- Diego      Analista de Marketing Digital
