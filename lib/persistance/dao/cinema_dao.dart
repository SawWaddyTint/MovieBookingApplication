import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hive/hive.dart';

class CinemaDao {
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao() {
    return _singleton;
  }
  CinemaDao._internal();

  void saveCinemas(List<CinemaVO> cinemaList, String date) async {
    List<CinemaVO> updatedCinemaList = cinemaList.map((cinema) {
      CinemaVO cinemaFromHive = this.getCinemaById(cinema.cinemaId);
      if (cinemaFromHive == null) {
        cinemaFromHive.dates = [];
        return cinema;
      } else {
        cinemaFromHive.dates.add(date);
        return cinemaFromHive;
      }
    }).toList();

    Map<int, CinemaVO> cinemaMap = Map.fromIterable(updatedCinemaList,
        key: (cinema) => cinema.cinemaId, value: (cinema) => cinema);
    await getCinemaBox().putAll(cinemaMap);
  }

  CinemaVO getCinemaById(int cinemaId) {
    return getCinemaBox().get(cinemaId);
  }

  List<CinemaVO> getAllCinmeas() {
    return getCinemaBox().values.toList();
  }

  Box<CinemaVO> getCinemaBox() {
    return Hive.box<CinemaVO>(BOX_NAME_CINEMA_VO);
  }

  /// reactive programming
  Stream<void> getAllCinemasEventStream() {
    return getCinemaBox().watch();
  }

  Stream<List<CinemaVO>> getAllCinemasStream(String date) {
    // return Stream.value(getAllCinmeas().toList());
    return Stream.value(getAllCinmeas()
        .where((cinema) => cinema.dates.contains(date) ?? false)
        .toList());
  }

  List<CinemaVO> getAllCinemasByDate(String date) {
    if (getAllCinmeas() != null && (getAllCinmeas().isNotEmpty ?? false)) {
      return getAllCinmeas()
          .where((element) => element.dates.contains(date) ?? false)
          .toList();
      //  return getAllCinmeas().toList();
    } else {
      return [];
    }
  }
}
