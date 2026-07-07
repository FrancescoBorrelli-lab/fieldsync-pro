import 'package:connectivity_plus/connectivity_plus.dart';
import '../../domain/entities/intervento.dart';
import '../../domain/repositories/intervento_repository.dart';
import '../../data/datasources/api_service.dart';

enum SyncStatus {
  idle,
  syncing,
  success,
  error,
  offline,
}

class SyncService {
  final InterventoRepository repository;
  final ApiService apiService;
  final Connectivity connectivity;

  SyncService({
    required this.repository,
    required this.apiService,
    required this.connectivity,
  });

  Future<bool> hasInternet() async {
    try {
      final result = await connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  Future<SyncResult> sync() async {
    if (!await hasInternet()) {
      return SyncResult(
        success: false,
        message: 'Nessuna connessione internet',
        status: SyncStatus.offline,
      );
    }

    final isApiReachable = await apiService.isConnected();
    if (!isApiReachable) {
      return SyncResult(
        success: false,
        message: 'Backend non raggiungibile',
        status: SyncStatus.error,
      );
    }

    try {
      // 1. PUSH - Invia i cambiamenti locali
      final pushResult = await _pushLocalChanges();
      
      // 2. PULL - Recupera solo i nuovi interventi dal server
      final pullResult = await _pullRemoteChanges();

      // 3. 🔥 MARCIA COME SINCRONIZZATI SOLO DOPO IL PULL
      // (gestito dentro pull)

      return SyncResult(
        success: pushResult.success && pullResult.success,
        message: _buildResultMessage(pushResult, pullResult),
        status: SyncStatus.success,
        pushCount: pushResult.count,
        pullCount: pullResult.count,
      );
    } catch (e) {
      return SyncResult(
        success: false,
        message: 'Errore durante la sincronizzazione: $e',
        status: SyncStatus.error,
      );
    }
  }

  // PUSH - Invia i cambiamenti locali al backend
  Future<SyncResult> _pushLocalChanges() async {
    try {
      final daSincronizzare = await repository.getInterventiDaSincronizzare();
      final eliminati = await repository.getInterventiEliminati();
      
      int count = 0;

      // Sincronizza eliminazioni
      for (var intervento in eliminati) {
        try {
          await apiService.eliminaIntervento(intervento.id);
          await repository.marcaEliminatoSuServer(intervento.id);
          count++;
          print('🗑️ Eliminato: ${intervento.titolo}');
        } catch (e) {
          print('❌ Errore eliminazione ${intervento.id}: $e');
        }
      }

      // Sincronizza modifiche/creazioni
      for (var intervento in daSincronizzare) {
        try {
          final data = _interventoToJson(intervento);
          
          final exists = await _checkExistsOnServer(intervento.id);
          
          if (exists) {
            await apiService.aggiornaIntervento(intervento.id, data);
            print('✏️ Aggiornato: ${intervento.titolo}');
          } else {
            final response = await apiService.creaIntervento(data);
            // 🔥 USA L'ID RESTITUITO DAL SERVER
            final serverId = response['id']?.toString() ?? intervento.id;
            if (serverId != intervento.id) {
              // Se l'ID è diverso, aggiorna l'UUID locale
              await repository.aggiornaUuid(intervento.id, serverId);
            }
            print('📝 Creato sul server: ${intervento.titolo} (ID: $serverId)');
          }
          
          // 🔥 NON MARCARE COME SINCRONIZZATO QUI
          // Lo faremo dopo il pull per evitare duplicati
          count++;
        } catch (e) {
          print('❌ Errore push ${intervento.id}: $e');
        }
      }

      return SyncResult(
        success: true,
        message: 'Push completato',
        count: count,
      );
    } catch (e) {
      return SyncResult(
        success: false,
        message: 'Errore nel push: $e',
        count: 0,
      );
    }
  }

  // PULL - Recupera i dati dal backend
  Future<SyncResult> _pullRemoteChanges() async {
    try {
      final remoteData = await apiService.getInterventi();
      int count = 0;

      final localInterventi = await repository.getAllInterventi();
      final localMap = <String, Intervento>{};
      for (var i in localInterventi) {
        localMap[i.id] = i;
      }

      for (var data in remoteData) {
        try {
          final intervento = _jsonToIntervento(data);
          
          // 🔥 CONTROLLO PIÙ STRETTO
          if (localMap.containsKey(intervento.id)) {
            // ESISTE GIÀ - NON SALVARE
            print('⏭️ Intervento già esistente: ${intervento.titolo} (${intervento.id})');
          } else {
            // NUOVO - salva e marca come sincronizzato
            await repository.salvaIntervento(intervento);
            await repository.marcaSincronizzato(intervento.id);
            count++;
            print('✅ Nuovo intervento dal server: ${intervento.titolo} (${intervento.id})');
          }
        } catch (e) {
          print('❌ Errore pull per ${data['id']}: $e');
        }
      }

      return SyncResult(
        success: true,
        message: 'Pull completato: $count nuovi interventi',
        count: count,
      );
    } catch (e) {
      return SyncResult(
        success: false,
        message: 'Errore nel pull: $e',
        count: 0,
      );
    }
  }

  // 🔥 VERIFICA ESISTENZA INTERVENTO SU SERVER
  Future<bool> _checkExistsOnServer(String id) async {
    try {
      final interventi = await apiService.getInterventi();
      return interventi.any((i) => i['id'] == id);
    } catch (e) {
      print('❌ Errore verifica esistenza $id: $e');
      return false;
    }
  }

  String _buildResultMessage(SyncResult push, SyncResult pull) {
    final parts = <String>[];
    if (push.count > 0) parts.add('${push.count} inviati');
    if (pull.count > 0) parts.add('${pull.count} ricevuti');
    
    if (parts.isEmpty) return 'Nessun cambiamento da sincronizzare';
    return 'Sincronizzazione completata: ${parts.join(', ')}';
  }

  // Converti Intervento in Map
  Map<String, dynamic> _interventoToJson(Intervento intervento) {
    return {
      'id': intervento.id,
      'titolo': intervento.titolo,
      'descrizione': intervento.descrizione,
      'cliente': intervento.cliente,
      'tecnicoAssegnato': intervento.tecnicoAssegnato,
      'dataCreazione': intervento.dataCreazione.toIso8601String(),
      'dataScadenza': intervento.dataScadenza?.toIso8601String(),
      'stato': intervento.stato.name,
      'priorita': intervento.priorita.name,
      'tags': intervento.tags,
      'dataUltimaModifica': DateTime.now().toIso8601String(),
    };
  }

  // Converti Map in Intervento
  Intervento _jsonToIntervento(Map<String, dynamic> json) {
    return Intervento(
      id: json['id']?.toString() ?? '',
      titolo: json['titolo']?.toString() ?? '',
      descrizione: json['descrizione']?.toString() ?? '',
      cliente: json['cliente']?.toString() ?? '',
      tecnicoAssegnato: json['tecnicoAssegnato']?.toString(),
      dataCreazione: json['dataCreazione'] != null 
          ? DateTime.parse(json['dataCreazione']) 
          : DateTime.now(),
      dataScadenza: json['dataScadenza'] != null 
          ? DateTime.parse(json['dataScadenza']) 
          : null,
      stato: InterventoStato.values.firstWhere(
        (e) => e.name == json['stato'],
        orElse: () => InterventoStato.daAssegnare,
      ),
      priorita: Priorita.values.firstWhere(
        (e) => e.name == json['priorita'],
        orElse: () => Priorita.media,
      ),
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      metadata: null,
    );
  }
}

// Result della sincronizzazione
class SyncResult {
  final bool success;
  final String message;
  final SyncStatus status;
  final int count;
  final int pushCount;
  final int pullCount;

  SyncResult({
    required this.success,
    required this.message,
    this.status = SyncStatus.idle,
    this.count = 0,
    this.pushCount = 0,
    this.pullCount = 0,
  });
}