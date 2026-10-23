# FieldSync Pro

App Flutter (mobile e web) per gestire gli **interventi tecnici sul campo** con architettura **offline-first**: i tecnici lavorano anche senza connessione e i dati si sincronizzano da soli quando torna la rete.

> Caso studio completo: [borrellifrancesco.dev/casi-studio/fieldsync-pro](https://borrellifrancesco.dev/casi-studio/fieldsync-pro)

## Funzionalità

- Creazione, modifica ed eliminazione degli interventi, **anche offline**
- Sincronizzazione push/pull con il server e pull-to-refresh, con feedback visivo
- Priorità (bassa, media, alta, urgente) e stato (da assegnare, assegnato, in corso, completato, sospeso, annullato) con colori dinamici
- Assegnazione del tecnico, data di scadenza e avanzamento
- Tag, ricerca e filtri per cliente e stato
- Eliminazione con swipe e conferma
- Material Design 3

## Stack

| Componente | Tecnologia |
| --- | --- |
| Framework | Flutter 3.x |
| Database locale | Isar 3.0.5 (NoSQL) |
| State management | Riverpod |
| Architettura | Clean Architecture (domain / data / presentation) |
| Generazione codice | build_runner |
| Server di test | Node.js + Express |

## Struttura

```
field_sync_pro/lib/
├── main.dart
└── src/
    ├── core/           # servizi (sync), tema
    ├── data/           # modelli Isar, API REST, repository
    ├── domain/         # entità e interfacce dei repository
    └── presentation/   # pagine, provider Riverpod, widget
field_sync_server/      # server Node.js di test per la sincronizzazione
```

## Come provarla

Prerequisiti: Flutter SDK 3.x.

```sh
cd field_sync_pro
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # genera i file Isar
flutter run                                                # parte con dati mock
```

Per impostazione predefinita l'app usa **dati mock**, quindi si può provare senza server.

### Con il server di test

```sh
cd field_sync_server
npm install
npm start               # http://localhost:3000
```

Poi avvia l'app indicando l'indirizzo del server:

```sh
flutter run --dart-define=USE_MOCK=false --dart-define=API_BASE_URL=http://<ip-del-tuo-pc>:3000
```

Su un dispositivo fisico usa l'IP del computer nella rete locale; sull'emulatore Android usa `http://10.0.2.2:3000`.

### API del server

| Metodo | Endpoint | Descrizione |
| --- | --- | --- |
| GET | `/interventi` | Elenco degli interventi |
| POST | `/interventi` | Crea un intervento |
| PUT | `/interventi/:id` | Aggiorna un intervento |
| DELETE | `/interventi/:id` | Elimina un intervento |
| GET | `/health` | Controllo dello stato |

## Modello dati

| Campo | Tipo | Descrizione |
| --- | --- | --- |
| `id` | String | UUID |
| `titolo` | String | Titolo |
| `descrizione` | String | Descrizione |
| `cliente` | String | Cliente |
| `tecnicoAssegnato` | String? | Tecnico incaricato |
| `dataCreazione` | DateTime | Creazione |
| `dataScadenza` | DateTime? | Scadenza |
| `stato` | enum | Stato corrente |
| `priorita` | enum | Priorità |
| `tags` | List\<String\> | Tag |

## Risoluzione problemi

- **"Outdated generated code" / errori di Isar**: rigenera i file.
  ```sh
  flutter clean && flutter pub get
  dart run build_runner build --delete-conflicting-outputs
  ```
- **"Namespace not specified" su Android**: aggiungi `namespace` in `android/app/build.gradle.kts`.
- Il generatore Isar richiede le stesse versioni di `isar`, `isar_flutter_libs` e `isar_generator` (qui 3.0.5).

## Roadmap

- [ ] Notifiche push per scadenze e aggiornamenti
- [ ] Gestione avanzata dei conflitti di sincronizzazione
- [ ] Report e statistiche con grafici
- [ ] Export/import in JSON e CSV
- [ ] Test automatici e CI/CD con GitHub Actions
- [ ] Documentazione delle API

## Licenza

[MIT](LICENSE)

## Autore

**Francesco Borrelli**, sviluppatore Flutter freelance, [borrellifrancesco.dev](https://borrellifrancesco.dev).
