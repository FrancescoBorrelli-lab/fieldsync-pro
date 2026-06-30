# FieldSync-Pro

Applicazione mobile (e web) per la gestione degli interventi tecnici sul campo con architettura "offline-first".

## 📱 Panoramica

FieldSync-Pro è progettata per permettere ai tecnici di:

📝 Creare e gestire interventi anche senza connessione internet

🔄 Sincronizzare i dati automaticamente quando si torna online

📊 Visualizzare lo stato e la priorità degli interventi

🏷️ Organizzare gli interventi per cliente e stato

👤 Assegnare tecnici agli interventi

📅 Gestire le date di scadenza

---

## 🛠️ Stack Tecnologico
Componente	Tecnologia
Framework	Flutter 3.x
Database Locale	Isar (NoSQL)
State Management	Riverpod
Architettura	Clean Architecture
Generazione Codice	build_runner

---

## 📁 Struttura del Progetto
```
lib/
├── main.dart                      # Entry point
└── src/
    ├── core/                      # Utility e costanti
    │   └── theme/
    │       └── app_theme.dart     # Tema globale
    ├── data/                      # Implementazioni concrete
    │   ├── models/                # Modelli Isar (@collection)
    │   │   └── intervento_isar.dart
    │   └── repositories/          # Implementazione repository
    │       └── intervento_repository_impl.dart
    ├── domain/                    # Logica di business
    │   ├── entities/              # Domain Entities
    │   │   └── intervento.dart
    │   └── repositories/          # Interfacce repository
    │       └── intervento_repository.dart
    └── presentation/              # UI e logica di presentazione
        ├── pages/                 # Pagine dell'app
        │   ├── home_page.dart
        │   ├── crea_intervento_page.dart
        │   ├── dettaglio_intervento_page.dart
        │   └── modifica_intervento_page.dart
        ├── providers/             # Riverpod Providers
        │   └── intervento_providers.dart
        └── widgets/               # Componenti UI riutilizzabili
            └── intervento_card.dart
```

---

## 🚀 Getting Started

Prerequisiti
* Flutter SDK 3.x
* Dart SDK 3.x
* Android Studio / VS Code
* Installazione

### 1. Clona il repository
```
git clone https://github.com/yourusername/field_sync_pro.git
cd field_sync_pro
```

### 2. Installa le dipendenze
```
flutter pub get
```

### 3. Genera i file Isar (IMPORTANTE!)
```
dart run build_runner build --delete-conflicting-outputs
```

### 4. Esegui l'app
```
flutter run
```

---

## Comandi Utili
### Generazione codice Isar (dopo modifiche ai modelli)
```
dart run build_runner build --delete-conflicting-outputs
```

### Generazione in watch mode (automatica)
```
dart run build_runner watch --delete-conflicting-outputs
```

### Pulizia e ricostruzione
```
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Esecuzione su dispositivi specifici
```
flutter run -d chrome      # Web
flutter run -d android     # Android
flutter run -d ios         # iOS
```

---

## ✅ Features Implementate
Feature | Stato 
| :---: | :---: |
Configurazione base del progetto | ✅
Clean Architecture (Domain, Data, Presentation) | ✅
Integrazione Isar (Database offline-first) | ✅
State Management con Riverpod | ✅
CRUD completo degli interventi | ✅
HomePage con lista interventi | ✅
Creazione nuovi interventi | ✅
Modifica interventi esistenti | ✅
Dettaglio intervento | ✅
Eliminazione interventi | ✅
Campo Tecnico Assegnato | ✅
Data Scadenza intervento | ✅
Sincronizzazione (base) | ✅
Tema globale e styling omogeneo | ✅
Card intervento informativa | ✅
Priorità e Stato con colori dinamici | ✅
Progresso avanzamento intervento | ✅

---

##  🎨 UI Design
L'app utilizza un design moderno e pulito con:

* Material Design 3

* Colorazione dinamica in base alla priorità e stato

* Card interattive per gli interventi con informazioni complete

* Feedback visivo per le azioni (SnackBar colorate)

* Bottoni stilizzati coerenti in tutta l'app

Palette | Colori
| :---: | :---: |
Elemento | Colore
Primary |	#1976D2 (Blu)
Secondary |	#42A5F5 (Blu chiaro)
Success |	#4CAF50 (Verde)
Warning |	#FF9800 (Arancione)
Error |	#E53935 (Rosso)

Priorità
Priorità |	Colore
| :---: | :---: |
Bassa |	🟢 Verde
Media |	🟠 Arancione
Alta |	🔴 Rosso
Urgente |	🟣 Viola
Stati | Intervento
Stato |	Colore
Da Assegnare |	⚪ Grigio
Assegnato |	🔵 Blu
In Corso |	🟠 Arancione
Completato |	🟢 Verde
Sospeso |	🔴 Rosso
Annullato |	⚫ Grigio scuro

---

## 📊 Modello Dati
Intervento
Campo |	Tipo |	Descrizione
| :---: | :---: | :---: |
id |	String |	UUID univoco
titolo |	String |	Titolo dell'intervento
descrizione |	String |	Descrizione dettagliata
cliente |	String |	Nome del cliente
tecnicoAssegnato |	String? |	Tecnico incaricato
dataCreazione |	DateTime |	Data di creazione
dataScadenza |	DateTime? |	Data di scadenza
stato |	InterventoStato |	Stato corrente
priorita |	Priorita |	Livello di priorità
tags |	List<String> |	Tag per categorizzazione

---

## 📝 TODO List
- [ ] Sincronizzazione completa con backend

- [ ] Filtri e ricerca interventi

- [ ] Notifiche push

- [ ] Supporto multiplatform (iOS, Android, Web)

- [ ] Export/Import dati

- [ ] Report e statistiche

---

## 🔧 Risoluzione Problemi

❌ Build error: "Namespace not specified"
Aggiungi al file android/app/build.gradle:
```
gradle
android {
    namespace "com.example.field_sync_pro"
    ndkVersion = "27.0.12077973"
    // ...
}
```

❌ Build error: "Outdated generated code"
```
flutter clean
Remove-Item lib/src/data/models/*.g.dart   # Windows
# rm -rf lib/src/data/models/*.g.dart     # Mac/Linux
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

❌ Isar generator error
Assicurati di avere le dipendenze corrette nel pubspec.yaml:

yaml
```
dependencies:
  isar: 3.1.0
  isar_flutter_libs: 3.1.0

dev_dependencies:
  build_runner: ^2.4.5
  isar_generator: 3.1.0
```

---

## 🤝 Contributi
Le contribuzioni sono benvenute! Per favore:
* Fai il fork del progetto
* Crea un branch per la tua feature (git checkout -b feature/AmazingFeature)
* Fai il commit delle tue modifiche (git commit -m 'Add some AmazingFeature')
* Fai il push del branch (git push origin feature/AmazingFeature)
* Apri una Pull Request

---

## 📄 Licenza
Questo progetto è sotto licenza MIT. Vedi il file LICENSE per maggiori dettagli.

---

## 👥 Autori
Francesco Borrelli - Sviluppatore principale

---

## 🙏 Ringraziamenti
* Flutter Team per il framework
* Isar Database per il database offline-first
* Riverpod per lo state management

---

## 📅 Documentazione
Versione: 1.0.0
Data: 30 Giugno 2026
Stato: 🟢 Stabile

Made with ❤️ in Italy