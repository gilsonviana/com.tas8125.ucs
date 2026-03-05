SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS usuarios (
    id         INT                        NOT NULL AUTO_INCREMENT,
    nome       VARCHAR(100)               NOT NULL,
    email      VARCHAR(100)               NOT NULL,
    senha      VARCHAR(255)               NOT NULL,
    tipo       ENUM('candidato','admin')  NOT NULL  DEFAULT 'candidato',
    criado_em  DATETIME                   NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_usuario_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS perfis (
    id           INT                                                                                          NOT NULL AUTO_INCREMENT,
    usuario_id   INT                                                                                          NOT NULL,
    escolaridade ENUM('Ensino Fundamental','Ensino Médio','Técnico','Graduação','Pós-graduação','Mestrado','Doutorado') DEFAULT NULL,
    competencias TEXT COMMENT 'Lista separada por vírgula. Ex: Excel, Git, Atendimento ao cliente',
    telefone     VARCHAR(20)                DEFAULT NULL,
    cidade       VARCHAR(100)               NOT NULL,
    atualizado_em DATETIME                                                                                    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_perfil_usuario (usuario_id),
    CONSTRAINT fk_perfil_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS setores (
    id            INT          NOT NULL AUTO_INCREMENT,
    nome          VARCHAR(100) NOT NULL,
    atualizado_em DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_setor_nome (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS perfis_setores (
    id                INT      NOT NULL AUTO_INCREMENT,
    perfil_id         INT      NOT NULL,
    setor_id          INT      NOT NULL,
    anos_experiencia  TINYINT  NOT NULL DEFAULT 0 COMMENT '0 = menos de 1 ano',
    atualizado_em     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_perfil_setor (perfil_id, setor_id),
    INDEX idx_ps_setor (setor_id),
    CONSTRAINT fk_ps_perfil FOREIGN KEY (perfil_id) REFERENCES perfis  (id) ON DELETE CASCADE,
    CONSTRAINT fk_ps_setor  FOREIGN KEY (setor_id)  REFERENCES setores (id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS vagas (
    id            INT          NOT NULL AUTO_INCREMENT,
    titulo        VARCHAR(100) NOT NULL,
    empresa       VARCHAR(100) NOT NULL,
    setor_id      INT          NOT NULL,
    cidade        VARCHAR(100) NOT NULL,
    descricao     TEXT         NOT NULL,
    requisitos    TEXT                  DEFAULT NULL,
    ativa         TINYINT(1)   NOT NULL DEFAULT 1,
    publicado_em  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    INDEX idx_vaga_setor (setor_id),
    CONSTRAINT fk_vaga_setor FOREIGN KEY (setor_id) REFERENCES setores (id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS candidaturas (
    id               INT      NOT NULL AUTO_INCREMENT,
    usuario_id       INT      NOT NULL,
    vaga_id          INT      NOT NULL,
    data_candidatura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_candidatura (usuario_id, vaga_id),
    INDEX idx_cand_vaga (vaga_id),
    CONSTRAINT fk_cand_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    CONSTRAINT fk_cand_vaga    FOREIGN KEY (vaga_id)    REFERENCES vagas    (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
