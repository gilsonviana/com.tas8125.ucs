import React, { useState, useEffect } from 'react';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL ?? 'http://localhost:8080';

interface Vaga {
  id: number;
  titulo: string;
  empresa: string;
  setor_id: number;
  cidade: string;
  descricao: string;
  requisitos: string | null;
  ativa: 0 | 1;
  publicado_em: string;
  atualizado_em: string;
}

function App(): React.JSX.Element {
  const [items, setVagas] = useState<Vaga[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(`${API_URL}/vagas`)
      .then((res) => {
        if (!res.ok) {
          throw new Error(`HTTP error ${res.status}`);
        }
        return res.json() as Promise<Vaga[]>;
      })
      .then((data) => {
        setVagas(data);
        setLoading(false);
      })
      .catch((err: unknown) => {
        setError(err instanceof Error ? err.message : 'Unknown error');
        setLoading(false);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>React + PHP App</h1>
        <p className="App-subtitle">Connected to the backend API</p>
      </header>

      <main className="App-main">
        <h2>Vagas</h2>

        {loading && <p className="App-loading">Loading items...</p>}

        {error && (
          <p className="App-error">Error fetching items: {error}</p>
        )}

        {!loading && !error && items.length === 0 && (
          <p className="App-empty">No items found.</p>
        )}

        {!loading && !error && items.length > 0 && (
          <ul className="App-list">
            {items.map((item) => (
              <li key={item.id} className="App-list-item">
                <strong>{item.titulo}</strong>
                <span>{item.empresa} — {item.cidade}</span>
                <p>{item.descricao}</p>
                {item.requisitos && <p><em>Requisitos: {item.requisitos}</em></p>}
                <small>
                  {item.ativa ? 'Ativa' : 'Inativa'} · Publicada em {item.publicado_em}
                </small>
              </li>
            ))}
          </ul>
        )}
      </main>
    </div>
  );
}

export default App;
