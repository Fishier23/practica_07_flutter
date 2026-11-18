import 'package:flutter/material.dart';
import 'screen/screen_promedio.dart';
import 'screen/screen_pago.dart';
import 'screen/screen_descuento.dart';
import 'screen/screen_combustible.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 07 - Ejercicios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const ScreenPromedio()),
                );
              },
              child: const Text('Ejercicio 1: Promedio Académico'),
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const ScreenPago()),
                );
              },
              child: const Text('Ejercicio 2: Pago de Trabajador'),
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const ScreenDescuento()),
                );
              },
              child: const Text('Ejercicio 3: Descuento de Productos'),
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const ScreenCombustible()),
                );
              },
              child: const Text('Ejercicio 4: Consumo de Combustible'),
            ),
          ],
        ),
      ),
    );
  }
}