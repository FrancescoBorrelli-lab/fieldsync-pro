import 'package:isar/isar.dart';
import '../../domain/entities/intervento.dart';
import '../../domain/repositories/intervento_repository.dart';
import '../models/intervento_isar.dart';

class InterventoRepositoryImpl implements InterventoRepository {
  final Isar isar;

  InterventoRepositoryImpl(this.isar);

  @override
  Future<List<Intervento>> getAllInterventi() async {
    final interventiIsar = await isar.interventoIsars.where().findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Intervento?> getInterventoById(String id) async {
    final interventoIsar = await isar.interventoIsars
        .where()
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    return interventoIsar?.toDomain();
  }

  @override
  Future<void> salvaIntervento(Intervento intervento) async {
    final isarIntervento = InterventoIsar.fromDomain(intervento);
    await isar.writeTxn(() async {
      await isar.interventoIsars.put(isarIntervento);
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
        await isar.interventoIsars.delete(intervento.id);
      });
    }
  }

  @override
  Future<List<Intervento>> getInterventiByStato(InterventoStato stato) async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .statoEqualTo(stato.name)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Intervento>> getInterventiByCliente(String cliente) async {
    final interventiIsar = await isar.interventoIsars
        .where()
        .filter()
        .clienteEqualTo(cliente)
        .findAll();
    return interventiIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> sincronizza() async {
    // TODO: Implementare logica di sincronizzazione con backend
    // Per ora, marcamo tutti come sincronizzati
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
}