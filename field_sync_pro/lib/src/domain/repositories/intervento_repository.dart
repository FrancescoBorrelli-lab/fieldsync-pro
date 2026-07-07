import '../entities/intervento.dart';

abstract class InterventoRepository {
  // CRUD di base
  Future<List<Intervento>> getAllInterventi();
  Future<Intervento?> getInterventoById(String id);
  Future<void> salvaIntervento(Intervento intervento);
  Future<void> eliminaIntervento(String id);
  Future<List<Intervento>> getInterventiByStato(InterventoStato stato);
  Future<List<Intervento>> getInterventiByCliente(String cliente);
  
  // Metodi per la sincronizzazione
  Future<List<Intervento>> getInterventiDaSincronizzare();
  Future<List<Intervento>> getInterventiEliminati();
  Future<void> marcaSincronizzato(String id);
  Future<void> marcaEliminatoSuServer(String id);
  Future<void> sincronizza();
  Future<void> aggiornaUuid(String oldId, String newId);
}