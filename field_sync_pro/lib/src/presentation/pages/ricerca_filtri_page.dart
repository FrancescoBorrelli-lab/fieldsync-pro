import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/intervento.dart';
import '../providers/filtro_providers.dart';

class RicercaFiltriPage extends ConsumerStatefulWidget {
  const RicercaFiltriPage({super.key});

  @override
  ConsumerState<RicercaFiltriPage> createState() => _RicercaFiltriPageState();
}

class _RicercaFiltriPageState extends ConsumerState<RicercaFiltriPage> {
  final _searchController = TextEditingController();
  final _clienteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final filtro = ref.read(filtroProvider);
    _searchController.text = filtro.query;
    _clienteController.text = filtro.cliente ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    _clienteController.dispose();
    super.dispose();
  }

  void _applicaFiltri() {
    ref.read(filtroProvider.notifier).state = ref.read(filtroProvider).copyWith(
      query: _searchController.text,
      cliente: _clienteController.text.isEmpty ? null : _clienteController.text,
    );
    Navigator.pop(context);
  }

  void _resetFiltri() {
    ref.read(filtroProvider.notifier).state = FiltroState();
    _searchController.clear();
    _clienteController.clear();
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final filtro = ref.watch(filtroProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ricerca e Filtri'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _applicaFiltri,
            child: const Text(
              'Applica',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo di ricerca testuale
              TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Cerca interventi',
                  hintText: 'Titolo, descrizione, cliente, tecnico...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.clear),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),

              const Text(
                'Filtri Avanzati',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Filtro per stato
              DropdownButtonFormField<InterventoStato?>(
                value: filtro.stato,
                decoration: const InputDecoration(
                  labelText: 'Stato',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('Tutti gli stati'),
                  ),
                  ...InterventoStato.values.map((stato) {
                    return DropdownMenuItem(
                      value: stato,
                      child: Text(_getStatoLabel(stato)),
                    );
                  }),
                ],
                onChanged: (value) {
                  ref.read(filtroProvider.notifier).state = filtro.copyWith(stato: value);
                },
              ),
              const SizedBox(height: 16),

              // Filtro per priorità
              DropdownButtonFormField<Priorita?>(
                value: filtro.priorita,
                decoration: const InputDecoration(
                  labelText: 'Priorità',
                  prefixIcon: Icon(Icons.priority_high),
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('Tutte le priorità'),
                  ),
                  ...Priorita.values.map((priorita) {
                    return DropdownMenuItem(
                      value: priorita,
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: priorita.color,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(_getPrioritaLabel(priorita)),
                        ],
                      ),
                    );
                  }),
                ],
                onChanged: (value) {
                  ref.read(filtroProvider.notifier).state = filtro.copyWith(priorita: value);
                },
              ),
              const SizedBox(height: 16),

              // Filtro per cliente
              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                  hintText: 'Filtra per nome cliente',
                  prefixIcon: Icon(Icons.business),
                  suffixIcon: Icon(Icons.clear),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),

              // Checkbox per scaduti
              CheckboxListTile(
                title: const Text('Mostra solo interventi scaduti'),
                subtitle: const Text('Interventi con data di scadenza passata'),
                value: filtro.mostraScaduti,
                onChanged: (value) {
                  ref.read(filtroProvider.notifier).state = filtro.copyWith(mostraScaduti: value);
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppTheme.primaryColor,
              ),

              const SizedBox(height: 32),

              // Bottoni azione
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetFiltri,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Reset Filtri'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applicaFiltri,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Applica Filtri'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatoLabel(InterventoStato stato) {
    switch (stato) {
      case InterventoStato.daAssegnare:
        return 'Da Assegnare';
      case InterventoStato.assegnato:
        return 'Assegnato';
      case InterventoStato.inCorso:
        return 'In Corso';
      case InterventoStato.completato:
        return 'Completato';
      case InterventoStato.sospeso:
        return 'Sospeso';
      case InterventoStato.annullato:
        return 'Annullato';
    }
  }

  String _getPrioritaLabel(Priorita priorita) {
    switch (priorita) {
      case Priorita.bassa:
        return 'Bassa';
      case Priorita.media:
        return 'Media';
      case Priorita.alta:
        return 'Alta';
      case Priorita.urgente:
        return 'Urgente';
    }
  }
}