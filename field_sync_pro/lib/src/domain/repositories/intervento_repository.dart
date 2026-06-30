import '../entities/intervento.dart';

abstract class InterventoRepository {
  Future<List<Intervento>> getAllInterventi();
  Future<Intervento?> getInterventoById(String id);
  Future<void> salvaIntervento(Intervento intervento);
  Future<void> eliminaIntervento(String id);
  Future<List<Intervento>> getInterventiByStato(InterventoStato stato);
  Future<List<Intervento>> getInterventiByCliente(String cliente);
  Future<void> sincronizza();
}