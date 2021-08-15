import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class LoginDataResponseDao {
  static final LoginDataResponseDao _singleton =
      LoginDataResponseDao._internal();

  factory LoginDataResponseDao() {
    return _singleton;
  }
  LoginDataResponseDao._internal();

  void saveLoginDataResponse(LoginDataResponse dataResponse) async {
    return getLoginDataResponseBox().put(1, dataResponse);
  }

  LoginDataResponse getLoginData(int loginId) {
    return getLoginDataResponseBox().get(loginId);
  }

  Box<LoginDataResponse> getLoginDataResponseBox() {
    return Hive.box<LoginDataResponse>(BOX_NAME_LOGIN_DATA_RESPONSE_VO);
  }

  /// Reactive Programming
  Stream<void> getUserDataEventStream() {
    return getLoginDataResponseBox().watch();
  }

  Stream<LoginDataResponse> getUserDataStream(int loginId) {
    // return Stream.value(getAllCinmeas().toList());
    return Stream.value(getLoginData(loginId));
    // .where((cinema) => cinema.dates.contains(date))
  }

  LoginDataResponse getUserData(int loginId) {
    if (getLoginData(loginId) != null) {
      return getLoginData(loginId);
      // .where((element) => element.dates.contains(date) ?? false);
    } else {
      return null;
    }
  }
}
