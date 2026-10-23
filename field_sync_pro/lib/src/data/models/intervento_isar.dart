import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/intervento.dart';

part 'intervento_isar.g.dart';

@Collection()
class InterventoIsar {
  Id id = Isar.autoIncrement;
  
  String? uuid;
  String titolo = '';
  String descrizione = '';
  String cliente = '';
  String? tecnicoAssegnato;
  DateTime dataCreazione = DateTime.now();
  DateTime? dataScadenza;
  String stato = 'daAssegnare';
  String priorita = 'media';
  List<String> tags = [];
  
  bool sincronizzato = false;
  bool eliminato = false;
  DateTime? dataUltimaModifica;
  String? ultimaModificaDa;

  InterventoIsar();

  factory InterventoIsar.fromDomain(Intervento intervento) {
    return InterventoIsar()
      ..uuid = intervento.id
      ..titolo = intervento.titolo
      ..descrizione = intervento.descrizione
      ..cliente = intervento.cliente
      ..tecnicoAssegnato = intervento.tecnicoAssegnato
      ..dataCreazione = intervento.dataCreazione
      ..dataScadenza = intervento.dataScadenza
      ..stato = intervento.stato.name
      ..priorita = intervento.priorita.name
      ..tags = intervento.tags
      ..sincronizzato = false
      ..eliminato = false
      ..dataUltimaModifica = DateTime.now()
      ..ultimaModificaDa = 'locale';
  }

  Intervento toDomain() {
    return Intervento(
      id: uuid ?? const Uuid().v4(),
      titolo: titolo,
      descrizione: descrizione,
      cliente: cliente,
      tecnicoAssegnato: tecnicoAssegnato,
      dataCreazione: dataCreazione,
      dataScadenza: dataScadenza,
      stato: InterventoStato.values.firstWhere(
        (e) => e.name == stato,
        orElse: () => InterventoStato.daAssegnare,
      ),
      priorita: Priorita.values.firstWhere(
        (e) => e.name == priorita,
        orElse: () => Priorita.media,
      ),
      tags: tags,
      metadata: null,
    );
  }
}