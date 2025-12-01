import '../../../../core/api/network_service.dart';
import '../../../../service_locator.dart';
import '../model/user/user_modal.dart';

class LoginRepository {
  final _networkServices = getIt.get<NetworkApiService>();

  Future<UserModal> login(data) async {
    // final response = await _networkServices.postApiService(
    //   url: ApiConstants.loginUrl,
    //   data: data,
    // );

    await Future.delayed(Duration(seconds: 2));

    return UserModal.fromJson({'token': 'token'});
  }
}
