import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../../../feature/synchronization/view_model/synchronization_view_model.dart';
import '../../cache/models/app_setting_model.dart';
import '../../service/interface/sync_get_operation.dart';
import '../../service/manager/product_service_manager.dart';
import '../../service/sync_get_service.dart';
import '../view_model/product_view_model.dart';

/// Product container for dependency injection
final class ProductContainer {
  const ProductContainer._();
  static final _getIt = GetIt.I;

  /// Product core required items
  static void setup() {
    _getIt
      ..registerSingleton<ProductNetworkManager>(ProductNetworkManager.base())
      // AppSettingModel GenericRepository'si zaten ProductViewModel tarafından kullanılacak
      ..registerLazySingleton<GenericRepository<AppSettingModel>>(
        () => GenericRepository<AppSettingModel>(
          tableName: AppSettingModel.staticTableName,
          fromMapFactory: AppSettingModel.fromMap,
        ),
      )
      ..registerLazySingleton<ProductViewModel>(() => ProductViewModel(_getIt<GenericRepository<AppSettingModel>>()))
      // ProductViewModel, AppSettingModel Repository 'Here GetIt'
      ..registerLazySingleton<SyncGetOperation>(() => SyncGetService(_getIt<ProductNetworkManager>()))
      //Save with Synchronization ViewModel Sync Get Operation Addiction
      ..registerLazySingleton<SynchronizationViewModel>(
        () => SynchronizationViewModel(syncGetOperation: _getIt<SyncGetOperation>()),
      );
  }

  /// read your dependency item for [ProductContainer]
  static T read<T extends Object>() => _getIt<T>();
}
