import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/intervento.dart';
import '../providers/intervento_providers.dart';
import '../widgets/tags_input.dart';

class ModificaInterventoPage extends ConsumerStatefulWidget {
  final String interventoId;

  const ModificaInterventoPage({
    super.key,
    required this.interventoId,
  });

  @override
  ConsumerState<ModificaInterventoPage> createState() => _ModificaInterventoPageState();
}

class _ModificaInterventoPageState extends ConsumerState<ModificaInterventoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titoloController = TextEditingController();
  final _descrizioneController = TextEditingController();
  final _clienteController = TextEditingController();
  final _tecnicoController = TextEditingController();
  final _scadenzaController = TextEditingController();
  
  InterventoStato? _statoSelezionato;
  Priorita? _prioritaSelezionata;
  DateTime? _dataScadenza;
  bool _isLoading = true;
  bool _isSaving = false;
  Intervento? _intervento;
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _caricaIntervento();
  }

  Future<void> _caricaIntervento() async {
    setState(() => _isLoading = true);
    
    final interventi = ref.read(interventoStateProvider).value;
    if (interventi != null) {
      _intervento = interventi.firstWhere(
        (i) => i.id == widget.interventoId,
        orElse: () => throw Exception('Intervento non trovato'),
      );
      
      _titoloController.text = _intervento!.titolo;
      _descrizioneController.text = _intervento!.descrizione;
      _clienteController.text = _intervento!.cliente;
      _tecnicoController.text = _intervento!.tecnicoAssegnato ?? '';
      _statoSelezionato = _intervento!.stato;
      _prioritaSelezionata = _intervento!.priorita;
      _dataScadenza = _intervento!.dataScadenza;
      _tags = _intervento!.tags;  // ← AGGIUNGI QUESTA RIGA
      if (_dataScadenza != null) {
        _scadenzaController.text = DateFormat('dd/MM/yyyy').format(_dataScadenza!);
      }
    }
    
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _titoloController.dispose();
    _descrizioneController.dispose();
    _clienteController.dispose();
    _tecnicoController.dispose();
    _scadenzaController.dispose();
    super.dispose();
  }

  Future<void> _salvaModifiche() async {
    if (!_formKey.currentState!.validate()) return;
    if (_intervento == null) return;

    setState(() => _isSaving = true);

    try {
      final interventoModificato = _intervento!.copyWith(
        titolo: _titoloController.text.trim(),
        descrizione: _descrizioneController.text.trim(),
        cliente: _clienteController.text.trim(),
        tecnicoAssegnato: _tecnicoController.text.trim().isEmpty 
            ? null 
            : _tecnicoController.text.trim(),
        stato: _statoSelezionato!,
        priorita: _prioritaSelezionata!,
        dataScadenza: _dataScadenza,
        tags: _tags,  // ← AGGIUNGI QUESTA RIGA
      );

      await ref.read(interventoStateProvider.notifier)
          .modificaIntervento(interventoModificato);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Intervento modificato con successo!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Errore: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_intervento == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Modifica Intervento')),
        body: const Center(
          child: Text('Intervento non trovato'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Intervento'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _salvaModifiche,
            child: const Text(
              'Salva',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Titolo
                TextFormField(
                  controller: _titoloController,
                  decoration: const InputDecoration(
                    labelText: 'Titolo *',
                    hintText: 'Inserisci il titolo dell\'intervento',
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un titolo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Descrizione
                TextFormField(
                  controller: _descrizioneController,
                  decoration: const InputDecoration(
                    labelText: 'Descrizione *',
                    hintText: 'Inserisci la descrizione dell\'intervento',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci una descrizione';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Cliente
                TextFormField(
                  controller: _clienteController,
                  decoration: const InputDecoration(
                    labelText: 'Cliente *',
                    hintText: 'Inserisci il nome del cliente',
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un cliente';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tecnico Assegnato
                TextFormField(
                  controller: _tecnicoController,
                  decoration: const InputDecoration(
                    labelText: 'Tecnico Assegnato',
                    hintText: 'Inserisci il nome del tecnico (opzionale)',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),

                // Data Scadenza
                TextFormField(
                  controller: _scadenzaController,
                  decoration: const InputDecoration(
                    labelText: 'Data Scadenza',
                    hintText: 'DD/MM/YYYY',
                    prefixIcon: Icon(Icons.event),
                  ),
                  readOnly: true,
                  onTap: _selezionaData,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      try {
                        DateFormat('dd/MM/yyyy').parse(value);
                      } catch (_) {
                        return 'Formato data non valido. Usa DD/MM/YYYY';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 🔥 TAGS - AGGIUNTO
                TagsInput(
                  initialTags: _tags,
                  onTagsChanged: (tags) {
                    setState(() {
                      _tags = tags;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Stato e Priorità
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<InterventoStato>(
                        value: _statoSelezionato,
                        decoration: const InputDecoration(
                          labelText: 'Stato',
                          prefixIcon: Icon(Icons.flag),
                        ),
                        items: InterventoStato.values.map((stato) {
                          return DropdownMenuItem(
                            value: stato,
                            child: Text(_getStatoLabel(stato)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _statoSelezionato = value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<Priorita>(
                        value: _prioritaSelezionata,
                        decoration: const InputDecoration(
                          labelText: 'Priorità',
                          prefixIcon: Icon(Icons.priority_high),
                        ),
                        items: Priorita.values.map((priorita) {
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
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _prioritaSelezionata = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Pulsante Salva Modifiche
                ElevatedButton(
                  onPressed: _isSaving ? null : _salvaModifiche,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    elevation: 2,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Salva Modifiche'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selezionaData() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dataScadenza ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _dataScadenza = date;
        _scadenzaController.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
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