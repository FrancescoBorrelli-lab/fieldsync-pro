import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/intervento.dart';
import '../providers/intervento_providers.dart';
import 'modifica_intervento_page.dart';

class DettaglioInterventoPage extends ConsumerWidget {
  final String interventoId;

  const DettaglioInterventoPage({
    super.key,
    required this.interventoId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interventoAsync = ref.watch(interventoStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettaglio Intervento'),
        elevation: 0,
      ),
      body: interventoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Errore: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(interventoStateProvider.notifier).caricaInterventi();
                },
                child: const Text('Riprova'),
              ),
            ],
          ),
        ),
        data: (interventi) {
          final intervento = interventi.firstWhere(
            (i) => i.id == interventoId,
            orElse: () => throw Exception('Intervento non trovato'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(intervento),
                const SizedBox(height: 20),
                _buildDetailSection(intervento),
                const SizedBox(height: 20),
                _buildInfoSection(intervento),
                const SizedBox(height: 24),
                _buildActionButtons(context, ref, intervento),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(Intervento intervento) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            intervento.priorita.color.withValues(alpha: 0.85),
            intervento.priorita.color.withValues(alpha: 0.35),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: intervento.priorita.color,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _getPrioritaLabel(intervento.priorita),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: intervento.priorita.color,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatoLabel(intervento.stato),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: intervento.stato.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            intervento.titolo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            intervento.descrizione,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(Intervento intervento) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📋 Informazioni Intervento',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.business, 'Cliente', intervento.cliente),
            const Divider(height: 16),
            _buildInfoRow(
              Icons.person,
              'Tecnico Assegnato',
              intervento.tecnicoAssegnato ?? 'Non assegnato',
            ),
            const Divider(height: 16),
            _buildInfoRow(
              Icons.calendar_today,
              'Data Creazione',
              DateFormat('dd/MM/yyyy HH:mm').format(intervento.dataCreazione),
            ),
            if (intervento.dataScadenza != null) ...[
              const Divider(height: 16),
              _buildInfoRow(
                Icons.event,
                'Data Scadenza',
                DateFormat('dd/MM/yyyy').format(intervento.dataScadenza!),
              ),
            ],
            if (intervento.tags.isNotEmpty) ...[
              const Divider(height: 16),
              _buildTagsRow(intervento.tags),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(Intervento intervento) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Stato Avanzamento',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildProgressIndicator(intervento.stato),
                ),
                const SizedBox(width: 16),
                Text(
                  '${_getProgressValue(intervento.stato)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, Intervento intervento) {
    return Row(
      children: [
        // Pulsante Modifica
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModificaInterventoPage(
                    interventoId: intervento.id,
                  ),
                ),
              );
              if (result == true) {
                ref.read(interventoStateProvider.notifier).caricaInterventi();
              }
            },
            icon: const Icon(Icons.edit, size: 20, color: AppTheme.primaryColor),
            label: const Text(
              'Modifica',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Pulsante Elimina
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              _showDeleteDialog(context, ref, intervento);
            },
            icon: const Icon(Icons.delete_outline, size: 20, color: Colors.white),
            label: const Text(
              'Elimina',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryColor),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagsRow(List<String> tags) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.label, size: 20, color: AppTheme.primaryColor),
        const SizedBox(width: 12),
        const SizedBox(
          width: 120,
          child: Text(
            'Tags',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  '#$tag',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(InterventoStato stato) {
    final progress = _getProgressValue(stato);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: progress / 100,
        minHeight: 10,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(
          progress < 30 ? Colors.orange.shade600 :
          progress < 70 ? Colors.blue.shade600 :
          Colors.green.shade600,
        ),
      ),
    );
  }

  int _getProgressValue(InterventoStato stato) {
    switch (stato) {
      case InterventoStato.daAssegnare:
        return 0;
      case InterventoStato.assegnato:
        return 20;
      case InterventoStato.inCorso:
        return 50;
      case InterventoStato.completato:
        return 100;
      case InterventoStato.sospeso:
        return 30;
      case InterventoStato.annullato:
        return 0;
    }
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, Intervento intervento) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Text('Elimina Intervento'),
          ],
        ),
        content: Text(
          'Sei sicuro di voler eliminare l\'intervento\n"${intervento.titolo}"?',
          style: const TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(interventoStateProvider.notifier)
                  .eliminaIntervento(intervento.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('Elimina'),
          ),
        ],
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