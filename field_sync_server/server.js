const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Database in memoria
let interventi = [
  {
    id: 'server-1',
    titolo: 'Server Intervento 1',
    descrizione: 'Creato dal server Node.js',
    cliente: 'Cliente Server',
    tecnicoAssegnato: 'Tecnico Server',
    dataCreazione: new Date().toISOString(),
    dataScadenza: null,
    stato: 'inCorso',
    priorita: 'alta',
    tags: ['server', 'test'],
    dataUltimaModifica: new Date().toISOString()
  },
  {
    id: 'server-2',
    titolo: 'Server Intervento 2',
    descrizione: 'Secondo intervento di test',
    cliente: 'Cliente Test',
    tecnicoAssegnato: null,
    dataCreazione: new Date().toISOString(),
    dataScadenza: new Date(Date.now() + 86400000 * 5).toISOString(),
    stato: 'daAssegnare',
    priorita: 'media',
    tags: ['urgente'],
    dataUltimaModifica: new Date().toISOString()
  }
];

// === ENDPOINT ===

// GET - Recupera tutti gli interventi
app.get('/interventi', (req, res) => {
  console.log(`📥 GET /interventi - Inviati: ${interventi.length} interventi`);
  res.json(interventi);
});

// GET - Recupera un intervento specifico
app.get('/interventi/:id', (req, res) => {
  const intervento = interventi.find(i => i.id === req.params.id);
  if (!intervento) {
    return res.status(404).json({ error: 'Intervento non trovato' });
  }
  res.json(intervento);
});

// POST - Crea un nuovo intervento
app.post('/interventi', (req, res) => {
  const nuovoIntervento = {
    ...req.body,
    id: 'server-' + Date.now(),
    dataUltimaModifica: new Date().toISOString()
  };
  interventi.push(nuovoIntervento);
  console.log(`📝 POST /interventi - Creato: ${nuovoIntervento.titolo} (ID: ${nuovoIntervento.id})`);
  res.status(201).json(nuovoIntervento);
});

// PUT - Aggiorna un intervento
app.put('/interventi/:id', (req, res) => {
  const index = interventi.findIndex(i => i.id === req.params.id);
  if (index === -1) {
    return res.status(404).json({ error: 'Intervento non trovato' });
  }
  
  interventi[index] = {
    ...interventi[index],
    ...req.body,
    dataUltimaModifica: new Date().toISOString()
  };
  
  console.log(`✏️ PUT /interventi/${req.params.id} - Aggiornato: ${interventi[index].titolo}`);
  res.json(interventi[index]);
});

// DELETE - Elimina un intervento
app.delete('/interventi/:id', (req, res) => {
  const index = interventi.findIndex(i => i.id === req.params.id);
  if (index === -1) {
    return res.status(404).json({ error: 'Intervento non trovato' });
  }
  
  const eliminato = interventi[index];
  interventi.splice(index, 1);
  console.log(`🗑️ DELETE /interventi/${req.params.id} - Eliminato: ${eliminato.titolo}`);
  res.status(204).send();
});

// Health check
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    interventi: interventi.length 
  });
});

// Avvia il server
app.listen(port, '0.0.0.0', () => {
  console.log(`\n🚀 Server in esecuzione su http://localhost:${port}`);
  console.log(`📊 Endpoint: http://localhost:${port}/interventi`);
  console.log(`📋 Interventi iniziali: ${interventi.length}\n`);
  
  // Stampa gli interventi iniziali
  console.log('📋 Interventi disponibili:');
  interventi.forEach(i => {
    console.log(`   - ${i.titolo} (${i.id})`);
  });
  console.log('');
});