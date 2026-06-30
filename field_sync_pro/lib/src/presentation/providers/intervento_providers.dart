import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/intervento.dart';
import '../../domain/repositories/intervento_repository.dart';
import '../../data/repositories/intervento_repository_impl.dart';

// Provider per Isar
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar deve essere inizializzato in main.dart');
});

// Provider per il repository
final interventoRepositoryProvider = Provider<InterventoRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return InterventoRepositoryImpl(isar);
});

// Provider per la lista degli interventi
final interventiProvider = FutureProvider<List<Intervento>>((ref) async {
  final repository = ref.watch(interventoRepositoryProvider);
  return repository.getAllInterventi();
});

// Provider per filtrare per stato
final interventiByStatoProvider = FutureProvider.family<List<Intervento>, InterventoStato>(
  (ref, stato) async {
    final repository = ref.watch(interventoRepositoryProvider);
    return repository.getInterventiByStato(stato);
  }
);

// StateNotifier per gestire lo stato degli interventi
class InterventoNotifier extends StateNotifier<AsyncValue<List<Intervento>>> {
  final InterventoRepository repository;

  InterventoNotifier(this.repository) : super(const AsyncValue.loading());

  Future<void> caricaInterventi() async {
    state = const AsyncValue.loading();
    try {
      final interventi = await repository.getAllInterventi();
      state = AsyncValue.data(interventi);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> aggiungiIntervento(Intervento intervento) async {
    try {
      await repository.salvaIntervento(intervento);
      await caricaInterventi();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> modificaIntervento(Intervento intervento) async {
    try {
      await repository.salvaIntervento(intervento);
      await caricaInterventi();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> eliminaIntervento(String id) async {
    try {
      await repository.eliminaIntervento(id);
      await caricaInterventi();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> sincronizza() async {
    try {
      await repository.sincronizza();
      await caricaInterventi();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final interventoStateProvider = StateNotifierProvider<InterventoNotifier, AsyncValue<List<Intervento>>>(
  (ref) {
    final repository = ref.watch(interventoRepositoryProvider);
    final notifier = InterventoNotifier(repository);
    notifier.caricaInterventi();
    return notifier;
  }
);