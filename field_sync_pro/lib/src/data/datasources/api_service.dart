import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Configurabili da riga di comando, senza toccare il codice:
  //   flutter run --dart-define=USE_MOCK=false --dart-define=API_BASE_URL=http://<ip>:3000
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
  static const bool useMock = bool.fromEnvironment('USE_MOCK', defaultValue: true);

  // HEADERS
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // GET - Recupera tutti gli interventi dal backend
  Future<List<Map<String, dynamic>>> getInterventi() async {
    if (useMock) {
      // 🔥 DATI MOCK PER TEST
      await Future.delayed(const Duration(seconds: 1));
      return [
        {
          'id': 'mock-1',
          'titolo': 'Mock Intervento 1',
          'descrizione': 'Questo è un mock per test',
          'cliente': 'Cliente Mock',
          'tecnicoAssegnato': 'Tecnico Mock',
          'dataCreazione': DateTime.now().toIso8601String(),
          'dataScadenza': DateTime.now().add(Duration(days: 5)).toIso8601String(),
          'stato': 'inCorso',
          'priorita': 'alta',
          'tags': ['test', 'mock'],
        },
        {
          'id': 'mock-2',
          'titolo': 'Mock Intervento 2',
          'descrizione': 'Secondo mock per test',
          'cliente': 'Cliente Test',
          'tecnicoAssegnato': null,
          'dataCreazione': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
          'dataScadenza': null,
          'stato': 'daAssegnare',
          'priorita': 'media',
          'tags': ['urgente'],
        },
      ];
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/interventi'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Errore nel recupero degli interventi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // POST - Invia un intervento al backend
  Future<Map<String, dynamic>> creaIntervento(Map<String, dynamic> intervento) async {
    if (useMock) {
      await Future.delayed(const Duration(seconds: 1));
      return {'success': true, 'id': 'mock-new-${DateTime.now().millisecondsSinceEpoch}'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/interventi'),
        headers: _headers,
        body: json.encode(intervento),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Errore nella creazione: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // PUT - Aggiorna un intervento
  Future<Map<String, dynamic>> aggiornaIntervento(String id, Map<String, dynamic> intervento) async {
    if (useMock) {
      await Future.delayed(const Duration(seconds: 1));
      return {'success': true, 'id': id};
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/interventi/$id'),
        headers: _headers,
        body: json.encode(intervento),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Errore nell\'aggiornamento: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // DELETE - Elimina un intervento
  Future<void> eliminaIntervento(String id) async {
    if (useMock) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/interventi/$id'),
        headers: _headers,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Errore nell\'eliminazione: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // GET - Verifica connettività
  Future<bool> isConnected() async {
    if (useMock) return true;
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: _headers,
      ).timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}