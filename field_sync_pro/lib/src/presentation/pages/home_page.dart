import 'package:field_sync_pro/src/core/services/sync_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/intervento_providers.dart';
import '../providers/filtro_providers.dart';
import '../providers/sync_providers.dart';
import '../widgets/intervento_card.dart';
import 'crea_intervento_page.dart';
import 'dettaglio_intervento_page.dart';
import 'ricerca_filtri_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isSyncing = false;  // ← STATO LOCALE

  @override
  Widget build(BuildContext context) {
    final interventiFiltrati = ref.watch(interventiFiltratiProvider);
    final filtro = ref.watch(filtroProvider);
    final interventiState = ref.watch(interventoStateProvider);
    final syncStatus = ref.watch(syncStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FieldSync-Pro'),
        actions: [
          // 🔍 Pulsante Ricerca/Filtri
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RicercaFiltriPage(),
                    ),
                  );
                  ref.read(interventoStateProvider.notifier).caricaInterventi();
                },
              ),
              if (filtro.isActive)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          // 🔄 Pulsante Sincronizzazione
          Stack(
            children: [
              IconButton(
                icon: syncStatus == SyncStatus.syncing
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.sync),
                onPressed: syncStatus == SyncStatus.syncing
                    ? null
                    : () async {
                        setState(() => _isSyncing = true);
                        try {
                          final result = await ref.read(syncProvider.future);
                          if (result.success) {
                            ref.read(interventoStateProvider.notifier).caricaInterventi();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result.message),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result.message),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isSyncing = false);
                          }
                        }
                      },
              ),
              if (syncStatus == SyncStatus.offline)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              if (syncStatus == SyncStatus.error)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              if (syncStatus == SyncStatus.success)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final result = await ref.read(syncProvider.future);
          ref.read(interventoStateProvider.notifier).caricaInterventi();
          
          if (result.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result.message),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: _isSyncing
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Sincronizzazione in corso...'),
                  ],
                ),
              )
            : interventiState.when(
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
                data: (_) {
                  if (interventiFiltrati.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (filtro.isActive)
                            const Icon(Icons.filter_list_off, size: 64, color: Colors.grey)
                          else
                            const Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            filtro.isActive ? 'Nessun risultato con i filtri applicati' : 'Nessun intervento',
                            style: const TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            filtro.isActive ? 'Prova a modificare i filtri' : 'Crea il tuo primo intervento!',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          if (filtro.isActive)
                            TextButton(
                              onPressed: () {
                                ref.read(filtroProvider.notifier).state = FiltroState();
                                ref.read(interventoStateProvider.notifier).caricaInterventi();
                              },
                              child: const Text('Rimuovi tutti i filtri'),
                            ),
                          if (interventiFiltrati.isEmpty && !filtro.isActive)
                            const SizedBox(height: 8),
                          if (interventiFiltrati.isEmpty && !filtro.isActive)
                            const Text(
                              'Tira verso il basso per sincronizzare 🔄',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: interventiFiltrati.length,
                    itemBuilder: (context, index) {
                      final intervento = interventiFiltrati[index];
                      return InterventoCard(
                        intervento: intervento,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DettaglioInterventoPage(
                                interventoId: intervento.id,
                              ),
                            ),
                          );
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreaInterventoPage(),
            ),
          );
          if (result == true) {
            ref.read(interventoStateProvider.notifier).caricaInterventi();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}