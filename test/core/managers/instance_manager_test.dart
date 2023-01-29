import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/adapters/service_injector/service_injector.dart';
import 'package:pokedex/core/managers/instance_manager.dart';

void main() {
  late InstanceManager sut;
  late _ServiceInjectorMock serviceInjector;

  const someDependency = _SomeDependency();

  setUp(() {
    serviceInjector = _ServiceInjectorMock();
    sut = InstanceManager(serviceInjector: serviceInjector);
  });

  group('register singleton', () {
    test('Should be able to register a dependency with the correct values', () async {
      // arrange
      when(
        () => serviceInjector.registerSingleton(someDependency),
      ).thenAnswer((final _) => _);

      when(() => serviceInjector.isRegistered<_SomeDependency>()).thenAnswer(
        (final _) => false,
      );

      // act
      sut.registerSingleton(someDependency);

      // assert
      verify(
        () => serviceInjector.registerSingleton(someDependency),
      ).called(1);
    });

    test('Should be able to register a dependency with a name', () async {
      // arrange
      const instanceName = 'instance name';
      when(
        () => serviceInjector.registerSingleton(
          someDependency,
          instanceName: instanceName,
        ),
      ).thenAnswer((final _) => _);

      when(() => serviceInjector.isRegistered<_SomeDependency>()).thenAnswer(
        (final _) => false,
      );

      // act
      sut.registerSingleton(
        someDependency,
        instanceName: instanceName,
      );

      // assert
      verify(
        () => serviceInjector.registerSingleton(
          someDependency,
          instanceName: instanceName,
        ),
      ).called(1);
    });

    test('should not register if a instance is already registered', () async {
      // arrange
      when(() => serviceInjector.isRegistered<_SomeDependency>()).thenAnswer(
        (final _) => true,
      );

      when(
        () => serviceInjector.registerSingleton(someDependency),
      ).thenAnswer((final _) => _);

      // act

      // assert
      expect(
        () => sut.registerSingleton(someDependency),
        throwsException,
      );
      verify(() => serviceInjector.isRegistered<_SomeDependency>()).called(1);
      verifyNever(() => serviceInjector.registerSingleton(someDependency));
    });

    test('should return a dependency with correct values', () async {
      // arrange
      when(
        () => serviceInjector.get<_SomeDependency>(),
      ).thenAnswer((final _) => someDependency);

      // act
      final result = sut.find<_SomeDependency>();

      // assert
      expect(result, isA<_SomeDependency>());
    });
  });
}

class _ServiceInjectorMock extends Mock implements ServiceInjector {}

class _SomeDependency {
  const _SomeDependency();
}
