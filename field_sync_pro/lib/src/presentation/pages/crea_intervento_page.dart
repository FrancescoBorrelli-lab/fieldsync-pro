import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/intervento.dart';
import '../providers/intervento_providers.dart';
import '../widgets/tags_input.dart';  // ← AGGIUNGI

class CreaInterventoPage extends ConsumerStatefulWidget {
  const CreaInterventoPage({super.key});

  @override
  ConsumerState<CreaInterventoPage> createState() => _CreaInterventoPageState();
}

class _CreaInterventoPageState extends ConsumerState<CreaInterventoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titoloController = TextEditingController();
  final _descrizioneController = TextEditingController();
  final _clienteController = TextEditingController();
  final _tecnicoController = TextEditingController();
  final _scadenzaController = TextEditingController();
  
  InterventoStato _statoSelezionato = InterventoStato.daAssegnare;
  Priorita _prioritaSelezionata = Priorita.media;
  DateTime? _dataScadenza;
  bool _isLoading = false;
  List<String> _tags = [];  // ← AGGIUNTO

  @override
  void dispose() {
    _titoloController.dispose();
    _descrizioneController.dispose();
    _clienteController.dispose();
    _tecnicoController.dispose();
    _scadenzaController.dispose();
    super.dispose();
  }

  Future<void> _selezionaData() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
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

  Future<void> _salvaIntervento() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final intervento = Intervento(
        id: const Uuid().v4(),
        titolo: _titoloController.text.trim(),
        descrizione: _descrizioneController.text.trim(),
        cliente: _clienteController.text.trim(),
        tecnicoAssegnato: _tecnicoController.text.trim().isEmpty 
            ? null 
            : _tecnicoController.text.trim(),
        dataCreazione: DateTime.now(),
        dataScadenza: _dataScadenza,
        stato: _statoSelezionato,
        priorita: _prioritaSelezionata,
        tags: _tags,  // ← AGGIUNTO
        metadata: null,
      );

      await ref.read(interventoStateProvider.notifier).aggiungiIntervento(intervento);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Intervento creato con successo!'),
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
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuovo Intervento'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _salvaIntervento,
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
                    hintText: 'DD/MM/YYYY (opzionale)',
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
                const SizedBox(height: 24),

                // 🔥 TAGS - AGGIUNTO
                TagsInput(
                  initialTags: _tags,
                  onTagsChanged: (tags) {
                    setState(() {
                      _tags = tags;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // DOPO (usa Flexible invece di Expanded)
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<InterventoStato>(
                        value: _statoSelezionato,
                        decoration: const InputDecoration(
                          labelText: 'Stato',
                          prefixIcon: Icon(Icons.flag),
                          isDense: true,  // ← AGGIUNGI PER COMPATTEZZA
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
                    const SizedBox(width: 12),
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<Priorita>(
                        value: _prioritaSelezionata,
                        decoration: const InputDecoration(
                          labelText: 'Priorità',
                          prefixIcon: Icon(Icons.priority_high),
                          isDense: true,  // ← AGGIUNGI PER COMPATTEZZA
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
                                const SizedBox(width: 6),
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

                // Bottone Crea
                ElevatedButton(
                  onPressed: _isLoading ? null : _salvaIntervento,
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
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Crea Intervento'),
                ),
              ],
            ),
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