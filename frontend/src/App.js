import React, { useState, useEffect } from 'react';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080';

function App() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch(`${API_URL}/items`)
      .then((res) => {
        if (!res.ok) {
          throw new Error(`HTTP error ${res.status}`);
        }
        return res.json();
      })
      .then((data) => {
        setItems(data);
        setLoading(false);
      })
      .catch((err) => {
        setError(err.message);
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
        <h2>Items</h2>

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
                <strong>{item.name}</strong>
                {item.description && (
                  <span className="App-list-item-desc">{item.description}</span>
                )}
              </li>
            ))}
          </ul>
        )}
      </main>
    </div>
  );
}

export default App;
