import 'package:flutter/material.dart';
import 'package:pokedex/core/bindings/core_bindings.dart';
import 'package:pokedex/core/domain/usecases/pokemon/fetch_pokemon_pagination_use_case.dart';
import 'package:pokedex/core/managers/instance_manager.dart';

void main() {
  CoreBindings.configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(
        useCase: InstanceManager().find(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.useCase,
  });

  final IFetchPokemonPaginationUseCase useCase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
          child: Text('GO!'),
          onPressed: fetch,
        ),
      ]),
    );
  }

  Future<void> fetch() async {
    final result = await useCase.fetch();
    final i = result.getOrNull();

    if (i != null) {
      print(i);
    }
  }
}
