# FieldSync Pro

Soluzione cross-platform (Mobile + Web) per la gestione di interventi tecnici in mobilità.

## Il Problema
Le aziende di manutenzione e gli artigiani perdono ore a digitalizzare rapporti cartacei o faticano a coordinare i tecnici in zone senza copertura internet, perdendo tracciabilità e precisione nei dati.

## La Soluzione
Un'applicazione Flutter progettata per il lavoro sul campo:
- **Offline-First:** Funziona perfettamente senza internet, salvando i dati localmente.
- **Sincronizzazione Intelligente:** Sincronizza i dati con il server non appena viene rilevata una connessione.
- **Toolbox Completa:** Gestione commesse, firma digitale del cliente in app e generazione automatica di report in formato PDF pronti da inviare.

## Tech Stack
- **Framework:** Flutter (Android/iOS/Web)
- **State Management:** Riverpod
- **Local Database:** Isar (Performance elevate per query offline)
- **Backend:** Supabase (Auth + Realtime Database)
- **PDF Generation:** `pdf` package

## Struttura della Repo
- `/lib/src/features`: Logica divisa per feature (auth, interventi, sincronizzazione).
- `/lib/src/services`: Gestione Database locale e API.
- `/test`: Unit test per la logica di sincronizzazione.

## Obiettivo Portfolio
Dimostrare la capacità di gestire sincronizzazione dati complessa, gestione dello stato in ambienti offline e generazione di documenti professionali lato client.