import 'package:get_it/get_it.dart';
import 'package:pokedex/core/adapters/service_injector/service_injector.dart';

class GetItAdapter implements ServiceInjector {
  final GetIt _getIt = GetIt.instance;

  @override
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
  }) {
    _getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
    );
  }

  @override
  T get<T extends Object>({
    final String? instanceName,
  }) {
    return _getIt.get<T>(
      instanceName: instanceName,
    );
  }
}
