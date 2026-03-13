import express from 'express';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const PORT = process.env.PORT || 3000;

// Stockage des logs en mémoire (simple pour le TP)
const logs = [];

// Middleware pour parser JSON
app.use(express.json());

// Servir les fichiers statiques (frontend Vue)
app.use(express.static('dist'));

// Middleware pour logger les requêtes GET avec l'IP du client
app.use((req, res, next) => {
  if (req.method === 'GET') {
    // Récupérer l'IP du client
    const ip = req.headers['x-forwarded-for']?.split(',')[0] || 
               req.socket.remoteAddress || 
               req.connection.remoteAddress;
    
    const logEntry = {
      timestamp: new Date().toISOString(),
      method: req.method,
      path: req.path,
      url: req.originalUrl,
      ip: ip,
      userAgent: req.headers['user-agent'] || 'Unknown'
    };
    
    logs.push(logEntry);
    console.log(`[${logEntry.timestamp}] GET ${req.path} - IP: ${ip}`);
  }
  next();
});

// API : obtenir tous les logs
app.get('/api/logs', (req, res) => {
  res.json(logs);
});

// API : obtenir les derniers N logs
app.get('/api/logs/:limit', (req, res) => {
  const limit = parseInt(req.params.limit) || 10;
  res.json(logs.slice(-limit));
});

// API : effacer les logs
app.post('/api/logs/clear', (req, res) => {
  logs.length = 0;
  res.json({ message: 'Logs cleared', count: 0 });
});

// Servir l'application Vue depuis l'index
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/dist/index.html');
});

// Fallback pour les routes SPA Vue
app.use((req, res) => {
  res.sendFile(__dirname + '/dist/index.html');
});

// Gestion des erreurs
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});

