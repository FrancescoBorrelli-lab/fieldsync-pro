class Intervento {
  final String id;
  final String titolo;
  final String descrizione;
  final String cliente;
  final String? tecnicoAssegnato;
  final DateTime dataCreazione;
  final DateTime? dataScadenza;
  final InterventoStato stato;
  final Priorita priorita;
  final List<String> tags;
  final Map<String, dynamic>? metadata;

  Intervento({
    required this.id,
    required this.titolo,
    required this.descrizione,
    required this.cliente,
    this.tecnicoAssegnato,
    required this.dataCreazione,
    this.dataScadenza,
    required this.stato,
    required this.priorita,
    this.tags = const [],
    this.metadata,
  });

  Intervento copyWith({
    String? id,
    String? titolo,
    String? descrizione,
    String? cliente,
    String? tecnicoAssegnato,
    DateTime? dataCreazione,
    DateTime? dataScadenza,
    InterventoStato? stato,
    Priorita? priorita,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  }) {
    return Intervento(
      id: id ?? this.id,
      titolo: titolo ?? this.titolo,
      descrizione: descrizione ?? this.descrizione,
      cliente: cliente ?? this.cliente,
      tecnicoAssegnato: tecnicoAssegnato ?? this.tecnicoAssegnato,
      dataCreazione: dataCreazione ?? this.dataCreazione,
      dataScadenza: dataScadenza ?? this.dataScadenza,
      stato: stato ?? this.stato,
      priorita: priorita ?? this.priorita,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
    );
  }
}

enum InterventoStato {
  daAssegnare,
  assegnato,
  inCorso,
  completato,
  sospeso,
  annullato,
}

enum Priorita {
  bassa,
  media,
  alta,
  urgente,
}