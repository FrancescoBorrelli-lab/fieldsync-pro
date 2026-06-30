import 'package:flutter/material.dart';
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

  Color _getPrioritaColor(Priorita priorita) {
    switch (priorita) {
      case Priorita.bassa:
        return Colors.green;
      case Priorita.media:
        return Colors.orange;
      case Priorita.alta:
        return Colors.red;
      case Priorita.urgente:
        return Colors.purple;
    }
  }

  Color _getStatoColor(InterventoStato stato) {
    switch (stato) {
      case InterventoStato.daAssegnare:
        return Colors.grey;
      case InterventoStato.assegnato:
        return Colors.blue;
      case InterventoStato.inCorso:
        return Colors.orange;
      case InterventoStato.completato:
        return Colors.green;
      case InterventoStato.sospeso:
        return Colors.red;
      case InterventoStato.annullato:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _getPrioritaColor(intervento.priorita),
          child: Text(
            intervento.priorita.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          intervento.titolo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(intervento.descrizione),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatoColor(intervento.stato).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    intervento.stato.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatoColor(intervento.stato),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Cliente: ${intervento.cliente}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}