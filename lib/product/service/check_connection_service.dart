import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:vexana/vexana.dart';

import '../state/container/product_state_container.dart';
import 'manager/product_service_manager.dart';

Future<bool> checkConnectionStatus() async {
  final INetworkManager<EmptyModel> networkManager = ProductContainer.read<ProductNetworkManager>();

  try {
    final response = await networkManager.send<ConnectionResponseModel, ConnectionResponseModel>(
      '/datetime',
      method: RequestType.POST,
      parseModel: ConnectionResponseModel(),
      options: Options(headers: {'clientId': 'dinamikbarkod', 'clientPass': 'dampex56'}),
    );

    if (response.data != null && response.data?.success == true) {
      return true;
    } else {
      AppLogger.warning(
        'checkConnectionStatus,API yanıtı: ${response.data?.success == false ? 'Başarısız (false)' : 'Boş veya tanımsız'}',
      );
      return false;
    }
  } on DioException catch (e) {
    AppLogger.error('checkConnectionStatus,Vexana bağlantı hatası: ${e.message}');
    return false;
  } catch (e) {
    AppLogger.error('checkConnectionStatus, Genel hata: $e');
    return false;
  }
}
