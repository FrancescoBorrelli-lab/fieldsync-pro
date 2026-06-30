import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'src/data/models/intervento_isar.dart';
import 'src/presentation/pages/home_page.dart';
import 'src/presentation/providers/intervento_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inizializza Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [InterventoIsarSchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldSync-Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}