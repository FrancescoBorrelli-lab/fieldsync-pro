import 'package:field_sync_pro/src/presentation/providers/intervento_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/intervento.dart';

// Stato dei filtri
class FiltroState {
  final String query;
  final InterventoStato? stato;
  final Priorita? priorita;
  final String? cliente;
  final bool mostraScaduti;

  FiltroState({
    this.query = '',
    this.stato,
    this.priorita,
    this.cliente,
    this.mostraScaduti = false,
  });

  FiltroState copyWith({
    String? query,
    InterventoStato? stato,
    Priorita? priorita,
    String? cliente,
    bool? mostraScaduti,
  }) {
    return FiltroState(
      query: query ?? this.query,
      stato: stato ?? this.stato,
      priorita: priorita ?? this.priorita,
      cliente: cliente ?? this.cliente,
      mostraScaduti: mostraScaduti ?? this.mostraScaduti,
    );
  }

  bool get isActive {
    return query.isNotEmpty ||
        stato != null ||
        priorita != null ||
        cliente != null ||
        mostraScaduti;
  }
}

// Provider per i filtri
final filtroProvider = StateProvider<FiltroState>((ref) {
  return FiltroState();
});

// Provider per la lista filtrata
final interventiFiltratiProvider = Provider<List<Intervento>>((ref) {
  final interventi = ref.watch(interventoStateProvider).value ?? [];
  final filtro = ref.watch(filtroProvider);

  return interventi.where((intervento) {
    // Filtro per query (ricerca testuale)
    if (filtro.query.isNotEmpty) {
      final queryLower = filtro.query.toLowerCase();
      final matchTitolo = intervento.titolo.toLowerCase().contains(queryLower);
      final matchDescrizione = intervento.descrizione.toLowerCase().contains(queryLower);
      final matchCliente = intervento.cliente.toLowerCase().contains(queryLower);
      final matchTecnico = intervento.tecnicoAssegnato?.toLowerCase().contains(queryLower) ?? false;
      if (!(matchTitolo || matchDescrizione || matchCliente || matchTecnico)) {
        return false;
      }
    }

    // Filtro per stato
    if (filtro.stato != null && intervento.stato != filtro.stato) {
      return false;
    }

    // Filtro per priorità
    if (filtro.priorita != null && intervento.priorita != filtro.priorita) {
      return false;
    }

    // Filtro per cliente
    if (filtro.cliente != null && filtro.cliente!.isNotEmpty) {
      if (!intervento.cliente.toLowerCase().contains(filtro.cliente!.toLowerCase())) {
        return false;
      }
    }

    // Filtro per scaduti
    if (filtro.mostraScaduti) {
      if (intervento.dataScadenza == null) return false;
      if (intervento.dataScadenza!.isAfter(DateTime.now())) return false;
    }

    return true;
  }).toList();
});