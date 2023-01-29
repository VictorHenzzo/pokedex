import 'package:pokedex/core/infra/dependency_injector/get_it_adapter.dart';
import 'package:pokedex/core/infra/dependency_injector/service_injector.dart';

class InstanceManager {
  InstanceManager({
    final ServiceInjector? serviceInjector,
  }) : _serviceInjector = serviceInjector ?? GetItAdapter();

  final ServiceInjector _serviceInjector;

  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
  }) {
    _serviceInjector.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
    );
  }

  T find<T extends Object>({
    final String? instanceName,
  }) {
    return _serviceInjector.get<T>(
      instanceName: instanceName,
    );
  }
}
