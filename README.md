# FieldSync-Pro

Applicazione mobile (e web) per la gestione degli interventi tecnici sul campo con architettura "offline-first".

## 📱 Panoramica

FieldSync-Pro è progettata per permettere ai tecnici di:
- 📝 Creare e gestire interventi anche senza connessione internet
- 🔄 Sincronizzare i dati automaticamente quando si torna online
- 📊 Visualizzare lo stato e la priorità degli interventi
- 🏷️ Organizzare gli interventi per cliente e stato

## 🛠️ Stack Tecnologico

| Componente | Tecnologia |
|------------|------------|
| Framework | Flutter 3.x |
| Database Locale | Isar (NoSQL) |
| State Management | Riverpod |
| Architettura | Clean Architecture |
| Generazione Codice | build_runner |

## 📁 Struttura del Progetto
lib/
├── main.dart # Entry point
├── src/
│ ├── core/ # Utility e costanti
│ ├── data/ # Implementazioni concrete
│ │ ├── models/ # Modelli Isar (@collection)
│ │ └── repositories/ # Implementazione repository
│ ├── domain/ # Logica di business
│ │ ├── entities/ # Domain Entities
│ │ └── repositories/ # Interfacce repository
│ └── presentation/ # UI e logica di presentazione
│ ├── pages/ # Pagine dell'app
│ ├── providers/ # Riverpod Providers
│ └── widgets/ # Componenti UI riutilizzabili

## 🚀 Getting Started

### Prerequisiti

- Flutter SDK 3.x
- Dart SDK 3.x
- Android Studio / VS Code

### Installazione

```bash
# 1. Clona il repository
git clone https://github.com/yourusername/field_sync_pro.git
cd field_sync_pro

# 2. Installa le dipendenze
flutter pub get

# 3. Genera i file Isar (IMPORTANTE!)
dart run build_runner build --delete-conflicting-outputs

# 4. Esegui l'app
flutter run

# Generazione codice Isar (dopo modifiche ai modelli)
dart run build_runner build --delete-conflicting-outputs

# Generazione in watch mode (automatica)
dart run build_runner watch --delete-conflicting-outputs

# Pulizia e ricostruzione
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Esecuzione su dispositivi specifici
flutter run -d chrome     # Web
flutter run -d android    # Android
flutter run -d ios         # iOS

🎨 UI Design
L'app utilizza un design moderno e pulito con:

Material Design 3

Colorazione dinamica in base alla priorità

Card interattive per gli interventi

Feedback visivo per le azioni

📝 TODO
[ ] Implementare dettaglio intervento

[ ] Modifica interventi esistenti

[ ] Sincronizzazione completa con backend

[ ] Filtri e ricerca

[ ] Notifiche push

[ ] Supporto multiplatform (iOS, Android, Web)

📄 Licenza
Questo progetto è sotto licenza MIT.

👥 Autori
Francesco Borrelli - Sviluppatore principale

Documentazione generata il: 30 Giugno 2026