import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class SnackDao {
  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao() {
    return _singleton;
  }
  SnackDao._internal();

  void saveSnackLists(List<SnackVO> snackList) async {
    Map<int, SnackVO> snackMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);
    await getSnackBox().putAll(snackMap);
  }

  List<SnackVO> getAllSnacks() {
    return getSnackBox().values.toList();
  }

  Box<SnackVO> getSnackBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }

  /// reactive programming
  Stream<void> getAllSnacksEventStream() {
    return getSnackBox().watch();
  }

  Stream<List<SnackVO>> getAllSnacksStream() {
    return Stream.value(getAllSnacks().toList());
  }

  List<SnackVO> getSnackList() {
    if (getAllSnacks() != null && (getAllSnacks().isNotEmpty ?? false)) {
      return getAllSnacks().toList();
    } else {
      return [];
    }
  }
}
