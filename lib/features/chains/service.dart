import 'package:avalon/common/snowflake.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/models/models.dart';

class ChainLibraryService {
  const ChainLibraryService({Database? store}) : _store = store;

  final Database? _store;

  Database get store => _store ?? database;

  Stream<List<ProxyChain>> watch() => store.proxyChainsDao.query().watch();

  Future<List<ProxyChain>> list() => store.proxyChainsDao.query().get();

  Future<ProxyChain?> get(int id) => store.proxyChainsDao.get(id);

  Future<List<ProxyChainHop>> hops(int chainId) =>
      store.proxyChainHopsDao.query(chainId).get();

  Future<ProxyChain> create({
    required String name,
    int branchLimit = 64,
  }) async {
    final id = snowflake.id;
    final chain = ProxyChain(
      id: id,
      name: name.trim().isEmpty ? 'Chain $id' : name.trim(),
      branchLimit: branchLimit.clamp(1, 1024),
      order: id,
    );
    await store.proxyChainsDao.put(chain);
    return chain;
  }

  Future<void> save(ProxyChain chain, Iterable<ProxyChainHop> hops) async {
    await store.transaction(() async {
      await store.proxyChainsDao.put(chain);
      await store.proxyChainHopsDao.removeForChain(chain.id);
      await store.proxyChainHopsDao.putAll(hops);
    });
  }

  Future<void> delete(int chainId) => store.proxyChainsDao.remove(chainId);

  Future<void> rename(int chainId, String name) async {
    final chain = await get(chainId);
    if (chain == null || name.trim().isEmpty) return;
    await store.proxyChainsDao.put(chain.copyWith(name: name.trim()));
  }

  Future<void> setBranchLimit(int chainId, int branchLimit) async {
    final chain = await get(chainId);
    if (chain == null) return;
    await store.proxyChainsDao.put(
      chain.copyWith(branchLimit: branchLimit.clamp(1, 1024)),
    );
  }

  Future<void> reorder(List<ProxyChain> chains) async {
    await store.transaction(() async {
      for (var index = 0; index < chains.length; index++) {
        await store.proxyChainsDao.put(chains[index].copyWith(order: index));
      }
    });
  }

  Future<ProxyChain?> duplicate(int chainId) async {
    final source = await get(chainId);
    if (source == null) return null;
    final sourceHops = await hops(chainId);
    final id = snowflake.id;
    final copy = source.copyWith(
      id: id,
      name: '${source.name} Copy',
      order: id,
    );
    await save(copy, [
      for (final hop in sourceHops) hop.copyWith(id: snowflake.id, chainId: id),
    ]);
    return copy;
  }

  Future<void> bind({
    required int profileId,
    required int chainId,
    bool isDefault = false,
    String? selectorName,
  }) async {
    await store.transaction(() async {
      if (isDefault) {
        final bindings = await store.proxyChainBindingsDao
            .query(profileId)
            .get();
        for (final binding in bindings.where(
          (item) => item.chainId != chainId,
        )) {
          if (binding.isDefault) {
            await store.proxyChainBindingsDao.put(
              binding.copyWith(isDefault: false),
            );
          }
        }
      }
      await store.proxyChainBindingsDao.put(
        ProxyChainBinding(
          profileId: profileId,
          chainId: chainId,
          isDefault: isDefault,
          selectorName: selectorName,
        ),
      );
    });
  }

  Future<void> unbind({required int profileId, required int chainId}) =>
      store.proxyChainBindingsDao.remove(profileId, chainId);

  Future<void> setEntryGroups({
    required int profileId,
    required int chainId,
    required Iterable<String> entryGroups,
  }) async {
    final groups = <String>[
      for (final group in entryGroups)
        if (group.trim().isNotEmpty) group.trim(),
    ];
    await store.transaction(() async {
      final bindings = await store.proxyChainBindingsDao.query(profileId).get();
      final binding = bindings
          .where((item) => item.chainId == chainId)
          .firstOrNull;
      await store.proxyChainBindingsDao.put(
        binding == null
            ? ProxyChainBinding(
                profileId: profileId,
                chainId: chainId,
                entryGroups: groups,
              )
            : binding.copyWith(entryGroups: groups),
      );
    });
  }

  Future<void> setDefault({
    required int profileId,
    required int chainId,
  }) async {
    await store.transaction(() async {
      final bindings = await store.proxyChainBindingsDao.query(profileId).get();
      if (!bindings.any((binding) => binding.chainId == chainId)) {
        await store.proxyChainBindingsDao.put(
          ProxyChainBinding(
            profileId: profileId,
            chainId: chainId,
            isDefault: true,
          ),
        );
      }
      for (final binding in bindings) {
        await store.proxyChainBindingsDao.put(
          binding.copyWith(
            isDefault: binding.chainId == chainId,
            enabled: binding.chainId == chainId || binding.enabled,
          ),
        );
      }
    });
  }
}

extension on ProxyChainHopsDao {
  Future<void> putAll(Iterable<ProxyChainHop> hops) async {
    await attachedDatabase.batch((batch) => setAllWithBatch(batch, hops));
  }

  Future<void> removeForChain(int chainId) async {
    await (delete(
      proxyChainHops,
    )..where((row) => row.chainId.equals(chainId))).go();
  }
}

extension on ProxyChainsDao {
  Future<void> remove(int chainId) async {
    await (delete(proxyChains)..where((row) => row.id.equals(chainId))).go();
  }
}

extension on ProxyChainBindingsDao {
  Future<void> remove(int profileId, int chainId) async {
    await (delete(proxyChainBindings)
          ..where((row) => row.profileId.equals(profileId))
          ..where((row) => row.chainId.equals(chainId)))
        .go();
  }
}
