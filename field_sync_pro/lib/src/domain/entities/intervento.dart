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