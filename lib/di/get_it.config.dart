// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/repository/item_repo.dart' as _i762;
import '../data/repository/login_repo.dart' as _i444;
import '../presentation/provider/item_provider.dart' as _i317;
import '../presentation/provider/login_provider.dart' as _i80;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i762.ItemRepo>(() => _i762.ItemRepoImpl());
    gh.lazySingleton<_i444.LoginRepo>(() => _i444.LoginRepoImpl());
    gh.factory<_i80.LoginProvider>(
        () => _i80.LoginProvider(loginRepo: gh<_i444.LoginRepo>()));
    gh.factory<_i317.ItemProvider>(
        () => _i317.ItemProvider(itemRepo: gh<_i762.ItemRepo>()));
    return this;
  }
}
