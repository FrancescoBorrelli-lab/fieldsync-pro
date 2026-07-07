import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/services/sync_service.dart';
import '../../data/datasources/api_service.dart';
import 'intervento_providers.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final repository = ref.watch(interventoRepositoryProvider);
  final apiService = ref.watch(apiServiceProvider);
  final connectivity = ref.watch(connectivityProvider);
  
  return SyncService(
    repository: repository,
    apiService: apiService,
    connectivity: connectivity,
  );
});

final syncStatusProvider = StateProvider<SyncStatus>((ref) {
  return SyncStatus.idle;
});

// 🔥 MODIFICA: Non modificare syncStatusProvider durante la creazione
final syncProvider = FutureProvider.autoDispose<SyncResult>((ref) async {
  final syncService = ref.watch(syncServiceProvider);
  
  // NON modificare syncStatusProvider qui!
  // Invece, lo facciamo quando il risultato arriva
  
  try {
    final result = await syncService.sync();
    // Aggiorna lo stato DOPO che il future è completo
    ref.read(syncStatusProvider.notifier).state = result.status;
    return result;
  } catch (e) {
    ref.read(syncStatusProvider.notifier).state = SyncStatus.error;
    return SyncResult(
      success: false,
      message: 'Errore: $e',
      status: SyncStatus.error,
    );
  }
});