import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/network/responses/profile_response.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class UserDataDao {
  static final UserDataDao _singleton = UserDataDao._internal();

  factory UserDataDao() {
    return _singleton;
  }
  UserDataDao._internal();

  void saveUserData(ProfileResponse dataResponse) async {
    return getUserDataResponseBox().put(1, dataResponse);
  }

  ProfileResponse getUserDataResponse(int loginId) {
    return getUserDataResponseBox().get(loginId);
  }

  Box<ProfileResponse> getUserDataResponseBox() {
    return Hive.box<ProfileResponse>(BOX_NAME_PROFILE_VO);
  }

  /// Reactive Programming
  Stream<void> getUserDataEventStream() {
    return getUserDataResponseBox().watch();
  }

  Stream<ProfileResponse> getUserDataStream(int loginId) {
    // return Stream.value(getAllCinmeas().toList());
    return Stream.value(getUserDataResponse(loginId));
    // .where((cinema) => cinema.dates.contains(date))
  }

  ProfileResponse getUserData(int loginId) {
    if (getUserDataResponse(loginId) != null) {
      return getUserDataResponse(loginId);
      // .where((element) => element.dates.contains(date) ?? false);
    } else {
      return null;
    }
  }
}
