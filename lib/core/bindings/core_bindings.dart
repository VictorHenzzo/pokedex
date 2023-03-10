import 'package:http/http.dart';
import 'package:pokedex/core/data/repositories/pokemon_repository.dart';
import 'package:pokedex/core/domain/usecases/pokemon/fetch_pokemon_pagination_use_case.dart';
import 'package:pokedex/core/adapters/http/http_data_source_adapter.dart';
import 'package:pokedex/core/adapters/http/remote_data_source.dart';
import 'package:pokedex/core/managers/instance_manager.dart';

class CoreBindings {
  CoreBindings._();
  static final InstanceManager _instanceManager = InstanceManager();

  static void configureDependencies() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
  }

  static void _registerDataSources() {
    final client = Client();
    final remoteDataSource = HttpDataSourceAdapter(client);

    _instanceManager.registerSingleton<RemoteDatasource>(
      remoteDataSource,
    );
  }

  static void _registerRepositories() {
    final dataSource = _instanceManager.find<RemoteDatasource>();
    final pokemonRepository = PokemonRepository(dataSource);

    _instanceManager.registerSingleton<PokemonRepository>(
      pokemonRepository,
    );
  }

  static void _registerUseCases() {
    final pokemonRepository = _instanceManager.find<PokemonRepository>();
    final fetchPokemonPaginationUseCase = FetchPokemonPaginationUseCase(pokemonRepository);

    _instanceManager.registerSingleton<IFetchPokemonPaginationUseCase>(
      fetchPokemonPaginationUseCase,
    );
  }
}
