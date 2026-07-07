import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/intervento.dart';

class InterventoCard extends StatelessWidget {
  final Intervento intervento;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const InterventoCard({
    super.key,
    required this.intervento,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(intervento.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'Elimina',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Riga superiore: Priorità + Stato + Data
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Priorità badge (compattato)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: intervento.priorita.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: intervento.priorita.color,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            _getPrioritaLabel(intervento.priorita),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: intervento.priorita.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Stato badge (compattato)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: intervento.stato.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _getStatoLabel(intervento.stato),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: intervento.stato.color,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Data scadenza (compattata)
                    if (intervento.dataScadenza != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event,
                            size: 12,
                            color: _isScadenzaVicina(intervento.dataScadenza!)
                                ? Colors.red.shade600
                                : Colors.grey.shade500,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            DateFormat('dd/MM/yy').format(intervento.dataScadenza!),
                            style: TextStyle(
                              fontSize: 10,
                              color: _isScadenzaVicina(intervento.dataScadenza!)
                                  ? Colors.red.shade600
                                  : Colors.grey.shade500,
                              fontWeight: _isScadenzaVicina(intervento.dataScadenza!)
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                // Titolo (più compatto)
                Text(
                  intervento.titolo,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                // Descrizione (se presente)
                if (intervento.descrizione.isNotEmpty)
                  Text(
                    intervento.descrizione,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 6),
                // Riga inferiore: Cliente + Tecnico (più compatta)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.business,
                      size: 12,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      intervento.cliente,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    if (intervento.tecnicoAssegnato != null) ...[
                      const SizedBox(width: 10),
                      Icon(
                        Icons.person,
                        size: 12,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        intervento.tecnicoAssegnato!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
                // Tags (se presenti, più compatti)
                if (intervento.tags.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: intervento.tags.take(2).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.blue.shade200, width: 0.5),
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (intervento.tags.length > 2)
                    Text(
                      '+${intervento.tags.length - 2}',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isScadenzaVicina(DateTime dataScadenza) {
    final oggi = DateTime.now();
    final differenza = dataScadenza.difference(oggi).inDays;
    return differenza <= 3 && differenza >= 0;
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