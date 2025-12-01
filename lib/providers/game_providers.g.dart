// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameServiceHash() => r'f2e52e32ece82417ad3b35084b780b9a9abfe6bc';

/// Provider for the game service
///
/// Copied from [gameService].
@ProviderFor(gameService)
final gameServiceProvider = AutoDisposeProvider<GameService>.internal(
  gameService,
  name: r'gameServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameServiceHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GameServiceRef = AutoDisposeProviderRef<GameService>;
String _$gameStreamHash() => r'ecf40fd6632754b3f6acb43f71e55b496bf3169c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [gameStream].
@ProviderFor(gameStream)
const gameStreamProvider = GameStreamFamily();

/// See also [gameStream].
class GameStreamFamily extends Family<AsyncValue<Game?>> {
  /// See also [gameStream].
  const GameStreamFamily();

  /// See also [gameStream].
  GameStreamProvider call({required String gameId}) {
    return GameStreamProvider(gameId: gameId);
  }

  @override
  GameStreamProvider getProviderOverride(
    covariant GameStreamProvider provider,
  ) {
    return call(gameId: provider.gameId);
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    gameServiceProvider,
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
        gameServiceProvider,
        ...?gameServiceProvider.allTransitiveDependencies,
      };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'gameStreamProvider';
}

/// See also [gameStream].
class GameStreamProvider extends AutoDisposeStreamProvider<Game?> {
  /// See also [gameStream].
  GameStreamProvider({required String gameId})
    : this._internal(
        (ref) => gameStream(ref as GameStreamRef, gameId: gameId),
        from: gameStreamProvider,
        name: r'gameStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$gameStreamHash,
        dependencies: GameStreamFamily._dependencies,
        allTransitiveDependencies: GameStreamFamily._allTransitiveDependencies,
        gameId: gameId,
      );

  GameStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameId,
  }) : super.internal();

  final String gameId;

  @override
  Override overrideWith(Stream<Game?> Function(GameStreamRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: GameStreamProvider._internal(
        (ref) => create(ref as GameStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameId: gameId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Game?> createElement() {
    return _GameStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameStreamProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GameStreamRef on AutoDisposeStreamProviderRef<Game?> {
  /// The parameter `gameId` of this provider.
  String get gameId;
}

class _GameStreamProviderElement extends AutoDisposeStreamProviderElement<Game?>
    with GameStreamRef {
  _GameStreamProviderElement(super.provider);

  @override
  String get gameId => (origin as GameStreamProvider).gameId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
