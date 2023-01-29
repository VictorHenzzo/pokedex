abstract class ServiceInjector {
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
  });

  T get<T extends Object>({
    final String? instanceName,
  });

  bool isRegistered<T extends Object>();
}
