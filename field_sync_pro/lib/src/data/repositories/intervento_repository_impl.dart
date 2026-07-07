import 'package:isar/isar.dart';
import '../../domain/entities/intervento.dart';
import '../../domain/repositories/intervento_repository.dart';
import '../models/intervento_isar.dart';

class InterventoRepositoryImpl implements InterventoRepository {
  final Isar isar;

  InterventoRepositoryImpl(this.isar);

  @override
  Future<List<Intervento>> getAllInterventi() async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .eliminatoEqualTo(false)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Intervento?> getInterventoById(String id) async {
    final interventoIsar = await isar.interventoIsars
        .where()
        .filter()
        .uuidEqualTo(id)
        .eliminatoEqualTo(false)
        .findFirst();
    return interventoIsar?.toDomain();
  }

  @override
  Future<void> salvaIntervento(Intervento intervento) async {
    await isar.writeTxn(() async {
      // 🔥 CERCA PER UUID
      final existing = await isar.interventoIsars
          .where()
          .filter()
          .uuidEqualTo(intervento.id)
          .findFirst();
      
      if (existing != null) {
        // ✅ AGGIORNA ESISTENTE - NON CREARE DUPLICATI
        existing.titolo = intervento.titolo;
        existing.descrizione = intervento.descrizione;
        existing.cliente = intervento.cliente;
        existing.tecnicoAssegnato = intervento.tecnicoAssegnato;
        existing.dataScadenza = intervento.dataScadenza;
        existing.stato = intervento.stato.name;
        existing.priorita = intervento.priorita.name;
        existing.tags = intervento.tags;
        existing.dataUltimaModifica = DateTime.now();
        existing.sincronizzato = false;
        existing.ultimaModificaDa = 'locale';
        existing.eliminato = false;
        await isar.interventoIsars.put(existing);
        print('📝 Intervento aggiornato (UUID: ${intervento.id})');
      } else {
        // ✅ CREA NUOVO
        final nuovo = InterventoIsar.fromDomain(intervento);
        await isar.interventoIsars.put(nuovo);
        print('📝 Intervento creato (UUID: ${intervento.id})');
      }
    });
  }

  @override
  Future<void> eliminaIntervento(String id) async {
    final intervento = await isar.interventoIsars
        .where()
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    
    if (intervento != null) {
      await isar.writeTxn(() async {
        intervento.eliminato = true;
        intervento.sincronizzato = false;
        intervento.dataUltimaModifica = DateTime.now();
        intervento.ultimaModificaDa = 'locale';
        await isar.interventoIsars.put(intervento);
      });
    }
  }

  @override
  Future<List<Intervento>> getInterventiByStato(InterventoStato stato) async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .statoEqualTo(stato.name)
        .eliminatoEqualTo(false)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Intervento>> getInterventiByCliente(String cliente) async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .clienteEqualTo(cliente)
        .eliminatoEqualTo(false)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Intervento>> getInterventiDaSincronizzare() async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .sincronizzatoEqualTo(false)
        .eliminatoEqualTo(false)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Intervento>> getInterventiEliminati() async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .eliminatoEqualTo(true)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> marcaSincronizzato(String id) async {
    final intervento = await isar.interventoIsars
        .where()
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    
    if (intervento != null) {
      await isar.writeTxn(() async {
        intervento.sincronizzato = true;
        intervento.ultimaModificaDa = 'server';
        await isar.interventoIsars.put(intervento);
      });
    }
  }

  @override
  Future<void> marcaEliminatoSuServer(String id) async {
    final intervento = await isar.interventoIsars
        .where()
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    
    if (intervento != null) {
      await isar.writeTxn(() async {
        await isar.interventoIsars.delete(intervento.id);
      });
    }
  }

  @override
  Future<void> sincronizza() async {
    final daSincronizzare = await isar.interventoIsars
        .where()
        .filter()
        .sincronizzatoEqualTo(false)
        .findAll();
    
    if (daSincronizzare.isNotEmpty) {
      await isar.writeTxn(() async {
        for (var intervento in daSincronizzare) {
          intervento.sincronizzato = true;
          intervento.dataUltimaModifica = DateTime.now();
          await isar.interventoIsars.put(intervento);
        }
      });
    }
  }

  @override
  Future<void> aggiornaUuid(String oldId, String newId) async {
    final intervento = await isar.interventoIsars
        .where()
        .filter()
        .uuidEqualTo(oldId)
        .findFirst();
    
    if (intervento != null) {
      await isar.writeTxn(() async {
        intervento.uuid = newId;
        intervento.sincronizzato = true;
        await isar.interventoIsars.put(intervento);
      });
      print('🔄 UUID aggiornato: $oldId → $newId');
    }
  }
}