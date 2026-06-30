import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/intervento.dart';
import '../providers/intervento_providers.dart';

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
  
  InterventoStato _statoSelezionato = InterventoStato.daAssegnare;
  Priorita _prioritaSelezionata = Priorita.media;
  bool _isLoading = false;

  @override
  void dispose() {
    _titoloController.dispose();
    _descrizioneController.dispose();
    _clienteController.dispose();
    super.dispose();
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
        dataCreazione: DateTime.now(),
        stato: _statoSelezionato,
        priorita: _prioritaSelezionata,
        tags: [],
        metadata: null,
      );

      await ref.read(interventoStateProvider.notifier).aggiungiIntervento(intervento);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Intervento creato con successo!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    labelText: 'Titolo',
                    hintText: 'Inserisci il titolo dell\'intervento',
                    border: OutlineInputBorder(),
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
                    labelText: 'Descrizione',
                    hintText: 'Inserisci la descrizione dell\'intervento',
                    border: OutlineInputBorder(),
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
                    labelText: 'Cliente',
                    hintText: 'Inserisci il nome del cliente',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un cliente';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Stato
                DropdownButtonFormField<InterventoStato>(
                  value: _statoSelezionato,
                  decoration: const InputDecoration(
                    labelText: 'Stato',
                    border: OutlineInputBorder(),
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
                const SizedBox(height: 16),

                // Priorità
                DropdownButtonFormField<Priorita>(
                  value: _prioritaSelezionata,
                  decoration: const InputDecoration(
                    labelText: 'Priorità',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.priority_high),
                  ),
                  items: Priorita.values.map((priorita) {
                    return DropdownMenuItem(
                      value: priorita,
                      child: Text(_getPrioritaLabel(priorita)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _prioritaSelezionata = value);
                    }
                  },
                ),
                const SizedBox(height: 32),

                // Bottone Salva
                ElevatedButton(
                  onPressed: _isLoading ? null : _salvaIntervento,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                      : const Text(
                          'Salva Intervento',
                          style: TextStyle(fontSize: 16),
                        ),
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