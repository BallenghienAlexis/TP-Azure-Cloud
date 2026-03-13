<template>
  <div id="app" class="container">
    <header class="header">
      <h1>📊 Cloud Lab - Enregistreur de Requêtes GET</h1>
      <p class="subtitle">Application de TP pour enregistrer les requêtes GET avec l'IP du client</p>
    </header>

    <main class="main">
      <!-- Section de contrôle -->
      <section class="control-panel">
        <h2>Contrôles</h2>
        <div class="button-group">
          <button @click="fetchLogs" class="btn btn-primary">
            🔄 Rafraîchir les logs
          </button>
          <button @click="clearLogs" class="btn btn-danger">
            🗑️ Effacer les logs
          </button>
          <button @click="makeTestRequest" class="btn btn-secondary">
            📨 Requête de test
          </button>
        </div>
        <p class="info">
          Total de requêtes GET enregistrées: <strong>{{ logs.length }}</strong>
        </p>
      </section>

      <!-- Section des logs -->
      <section class="logs-section">
        <h2>Logs des Requêtes GET</h2>

        <div v-if="logs.length === 0" class="no-logs">
          <p>Aucune requête enregistrée pour le moment...</p>
        </div>

        <div v-else class="logs-container">
          <div class="logs-info">
            Affichage des {{ displayedLogs.length }} dernières requêtes
          </div>

          <table class="logs-table">
            <thead>
              <tr>
                <th>Heure</th>
                <th>Chemin</th>
                <th>Adresse IP</th>
                <th>User-Agent</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(log, index) in displayedLogs" :key="index" class="log-row">
                <td class="timestamp">{{ formatTime(log.timestamp) }}</td>
                <td class="path"><code>{{ log.path }}</code></td>
                <td class="ip"><span class="ip-badge">{{ log.ip }}</span></td>
                <td class="user-agent">{{ truncate(log.userAgent, 50) }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <!-- Section statistiques -->
      <section class="stats-section" v-if="logs.length > 0">
        <h2>Statistiques</h2>
        <div class="stats-grid">
          <div class="stat-card">
            <h3>IPs Uniques</h3>
            <p class="stat-value">{{ uniqueIPs.length }}</p>
          </div>
          <div class="stat-card">
            <h3>Chemins Uniques</h3>
            <p class="stat-value">{{ uniquePaths.length }}</p>
          </div>
          <div class="stat-card">
            <h3>Total des Requêtes</h3>
            <p class="stat-value">{{ logs.length }}</p>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const logs = ref([])
const maxDisplayLogs = ref(20)

const displayedLogs = computed(() => {
  return logs.value.slice(-maxDisplayLogs.value)
})

const uniqueIPs = computed(() => {
  const ips = new Set(logs.value.map(log => log.ip))
  return Array.from(ips)
})

const uniquePaths = computed(() => {
  const paths = new Set(logs.value.map(log => log.path))
  return Array.from(paths)
})

const fetchLogs = async () => {
  try {
    const response = await fetch('/api/logs')
    logs.value = await response.json()
  } catch (error) {
    console.error('Erreur lors de la récupération des logs:', error)
    alert('Erreur: ' + error.message)
  }
}

const clearLogs = async () => {
  if (confirm('Êtes-vous sûr de vouloir effacer tous les logs?')) {
    try {
      const response = await fetch('/api/logs/clear', { method: 'POST' })
      logs.value = []
      alert('Logs effacés avec succès!')
    } catch (error) {
      console.error('Erreur lors de l\'effacement des logs:', error)
      alert('Erreur: ' + error.message)
    }
  }
}

const makeTestRequest = async () => {
  try {
    await fetch('/api/test-request?test=true')
    await new Promise(resolve => setTimeout(resolve, 500))
    await fetchLogs()
  } catch (error) {
    console.error('Erreur lors de la requête de test:', error)
  }
}

const formatTime = (timestamp) => {
  const date = new Date(timestamp)
  return date.toLocaleTimeString('fr-FR', {
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  })
}

const truncate = (text, length) => {
  return text.length > length ? text.substring(0, length) + '...' : text
}

onMounted(() => {
  fetchLogs()
  // Rafraîchir automatiquement les logs toutes les 3 secondes
  setInterval(fetchLogs, 3000)
})
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#app {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 2rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
}

.header {
  text-align: center;
  color: white;
  margin-bottom: 3rem;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  backdrop-filter: blur(10px);
}

.header h1 {
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
}

.subtitle {
  font-size: 1.1rem;
  opacity: 0.9;
}

.main {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

section {
  background: white;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

section h2 {
  color: #333;
  margin-bottom: 1.5rem;
  font-size: 1.5rem;
  border-bottom: 2px solid #667eea;
  padding-bottom: 0.5rem;
}

.control-panel {
  background: white;
}

.button-group {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}

.btn {
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 1rem;
  font-weight: 600;
  transition: all 0.3s ease;
}

.btn-primary {
  background: #667eea;
  color: white;
}

.btn-primary:hover {
  background: #5568d3;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
  background: #48bb78;
  color: white;
}

.btn-secondary:hover {
  background: #38a169;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(72, 187, 120, 0.4);
}

.btn-danger {
  background: #f56565;
  color: white;
}

.btn-danger:hover {
  background: #e53e3e;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(245, 101, 101, 0.4);
}

.info {
  color: #666;
  font-size: 1rem;
  margin-top: 1rem;
}

.info strong {
  color: #667eea;
  font-size: 1.1rem;
}

.logs-section {
  background: white;
}

.no-logs {
  text-align: center;
  padding: 2rem;
  color: #999;
  font-size: 1.1rem;
}

.logs-container {
  overflow-x: auto;
}

.logs-info {
  margin-bottom: 1rem;
  color: #666;
  font-size: 0.9rem;
}

.logs-table {
  width: 100%;
  border-collapse: collapse;
}

.logs-table thead {
  background: #f7fafc;
}

.logs-table th {
  padding: 1rem;
  text-align: left;
  font-weight: 600;
  color: #333;
  border-bottom: 2px solid #e2e8f0;
}

.log-row {
  border-bottom: 1px solid #e2e8f0;
  transition: background 0.2s ease;
}

.log-row:hover {
  background: #f7fafc;
}

.logs-table td {
  padding: 1rem;
  color: #555;
}

.timestamp {
  font-weight: 600;
  color: #667eea;
  white-space: nowrap;
}

.path code {
  background: #f0f4ff;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-family: 'Courier New', monospace;
  color: #764ba2;
}

.ip-badge {
  background: #e6fffa;
  color: #234e52;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-weight: 600;
  font-family: 'Courier New', monospace;
}

.user-agent {
  color: #888;
  font-size: 0.85rem;
  font-family: 'Courier New', monospace;
}

.stats-section {
  background: white;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
}

.stat-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 1.5rem;
  border-radius: 8px;
  text-align: center;
}

.stat-card h3 {
  font-size: 0.9rem;
  opacity: 0.9;
  margin-bottom: 0.5rem;
}

.stat-value {
  font-size: 2.5rem;
  font-weight: bold;
}

@media (max-width: 768px) {
  .header h1 {
    font-size: 1.8rem;
  }

  .button-group {
    flex-direction: column;
  }

  .btn {
    width: 100%;
  }

  .logs-table {
    font-size: 0.85rem;
  }

  .logs-table th,
  .logs-table td {
    padding: 0.75rem 0.5rem;
  }
}
</style>
