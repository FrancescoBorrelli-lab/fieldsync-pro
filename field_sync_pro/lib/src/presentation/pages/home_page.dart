import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/intervento_providers.dart';
import '../widgets/intervento_card.dart';
import 'crea_intervento_page.dart';  // ← AGGIUNGI QUESTO IMPORT

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interventiState = ref.watch(interventoStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FieldSync-Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ref.read(interventoStateProvider.notifier).sincronizza();
            },
          ),
        ],
      ),
      body: interventiState.when(
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
          if (interventi.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nessun intervento',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Crea il tuo primo intervento!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: interventi.length,
            itemBuilder: (context, index) {
              final intervento = interventi[index];
              return InterventoCard(
                intervento: intervento,
                onTap: () {
                  // Naviga al dettaglio
                },
                onDelete: () {
                  ref.read(interventoStateProvider.notifier)
                      .eliminaIntervento(intervento.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ← MODIFICA QUI
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreaInterventoPage(),
            ),
          );
          
          // Se l'intervento è stato creato, ricarica la lista
          if (result == true) {
            ref.read(interventoStateProvider.notifier).caricaInterventi();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}