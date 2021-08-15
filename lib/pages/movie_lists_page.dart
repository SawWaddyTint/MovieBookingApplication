import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/network/responses/log_out_response.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/pages/login_page.dart';
import 'package:MovieBookingApplication/pages/welcome_page.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/pages/movie_details_page.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/resources/strings.dart';
import 'package:MovieBookingApplication/viewItems/movie_view.dart';
import 'package:MovieBookingApplication/widgets/circle_avatar_profile.dart';
import 'package:MovieBookingApplication/widgets/movie_label_text.dart';
import 'package:hive/hive.dart';

import '../utility_function.dart';

LoginDataResponse loginData;
String token;

class MovieListsPage extends StatefulWidget {
  final String fbProfileImg;
  MovieListsPage({this.fbProfileImg});
  @override
  _MovieListsPageState createState() => _MovieListsPageState();
}

class _MovieListsPageState extends State<MovieListsPage> {
  MovieModel mMovieModel = MovieModelImpl();
  Box userBox;

  List<MovieVO> mComingSoonMovieList;
  List<MovieVO> mNowShowingMovieList;
  LogOutResponse logOutData;
  List<String> menuItems = [
    "Promotion code",
    "Select a language",
    "Terms of services",
    "Help",
    "Rate us",
  ];
  @override
  void initState() {
    super.initState();
    //get token from database
    mMovieModel.getLoginDataFromDatabase().listen((value) {
      setState(() {
        loginData = value;
        debugPrint("login Data in movie list >>> " + loginData.toString());
        token = loginData.token;
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
    // Now Playing Movies
    // mMovieModel.getMovieList("current").then((movieList) {
    //   setState(() {
    //     mNowShowingMovieList = movieList;
    //     debugPrint("movie List >>>" + mNowShowingMovieList.toString());
    //   });
    // }).catchError((error) {
    //   handleError(context, error);
    //   // debugPrint(error.toString());
    // });

    mMovieModel.getNowPlayingMoviesFromDatabase().listen((value) {
      setState(() {
        mNowShowingMovieList = value;
        debugPrint("movie List >>>" + mNowShowingMovieList.toString());
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });

    // Coming Soon Movies
    // mMovieModel.getMovieList("comingsoon").then((movieList) {
    //   setState(() {
    //     mComingSoonMovieList = movieList;
    //     debugPrint("movie List >>>" + mComingSoonMovieList.toString());
    //   });
    // }).catchError((error) {
    //   handleError(context, error);
    //   // debugPrint(error.toString());
    // });

    mMovieModel.getComingSoonMoviesFromDatabase().listen((value) {
      setState(() {
        mComingSoonMovieList = value;
        debugPrint("movie List >>>" + mComingSoonMovieList.toString());
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  logout() {
    mMovieModel.getLogOut('Bearer $token').then((value) {
      setState(() {
        logOutData = value;
        if (logOutData.message == "user logout successfully") {
          // userBox = Hive.box<LogOutResponse>(BOX_NAME_LOGIN_DATA_RESPONSE_VO);
          // userBox.clear();
          Hive.box<LoginDataResponse>(BOX_NAME_LOGIN_DATA_RESPONSE_VO).clear();
          Fluttertoast.showToast(
            msg: logOutData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToLogInPage(context);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  _navigateToLogInPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (loginData != null &&
              loginData != "" &&
              mComingSoonMovieList != null &&
              mNowShowingMovieList != null &&
              mComingSoonMovieList != "" &&
              mNowShowingMovieList != "")
          ? Scaffold(
              drawer: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Drawer(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Regular_margin_size,
                    ),
                    color: App_theme_color,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Drawer_height,
                        ),
                        DrawerHeaderSectionView(widget.fbProfileImg),
                        SizedBox(
                          height: Medium_margin_size,
                        ),
                        MenuItemsSectionView(menuItems: menuItems),
                        Spacer(),
                        LogOutSectionView(() => logout()),
                        SizedBox(
                          height: Regular_margin_size_2X,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: Regular_margin_size,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(
                  bottom: Regular_margin_size_2X,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: Regular_margin_size),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AvatarAndNameView(widget.fbProfileImg),
                        SizedBox(
                          height: Small_margin_size,
                        ),
                        NowShowingMovieView(
                          (movieId) =>
                              _navigateToMovieDetailsPage(context, movieId),
                          mNowShowingMovieList,
                        ),
                        // SizedBox(
                        //   height: 16.0,
                        // ),
                        ComingSoonMovieView(
                          (movieId) =>
                              _navigateToMovieDetailsPage(context, movieId),
                          mComingSoonMovieList,
                        ),
                        SizedBox(
                          height: 16.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class LogOutSectionView extends StatelessWidget {
  final Function logout;
  LogOutSectionView(this.logout);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.white,
          size: 28.0,
        ),
        title: Text(
          "Log out",
          style: TextStyle(
            color: Colors.white,
            fontSize: Regular_title_text_size,
          ),
        ),
      ),
      onTap: () {
        logout();
      },
    );
  }
}

class MenuItemsSectionView extends StatelessWidget {
  const MenuItemsSectionView({
    this.menuItems,
  });

  final List<String> menuItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuItems.map((menu) {
        return Container(
          margin: EdgeInsets.only(top: Regular_margin_size),
          child: ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.white,
              size: 28.0,
            ),
            title: Text(
              menu,
              style: TextStyle(
                color: Colors.white,
                fontSize: Regular_title_text_size,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class DrawerHeaderSectionView extends StatelessWidget {
  final String fbProfileImg;
  DrawerHeaderSectionView(this.fbProfileImg);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: Regular_margin_size_3X,
          backgroundImage: (fbProfileImg == null || fbProfileImg == "")
              ? NetworkImage("$PROFILE_IMAGE_URL${loginData.data.profileImage}")
              : NetworkImage("$fbProfileImg"),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 2.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loginData.data.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Regular_margin_size_3X,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: XXS_margin_size,
            ),
            Row(
              children: [
                Text(
                  loginData.data.email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 28.0,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

void _navigateToMovieDetailsPage(BuildContext context, int movieId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MovieDetailsPage(movieId),
    ),
  );
}

class ComingSoonMovieView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> mComingSoonMovieList;
  const ComingSoonMovieView(this.onTapMovie, this.mComingSoonMovieList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieLabelText(Coming_soon_txt),
        SizedBox(
          height: Regular_margin_size,
        ),
        Container(
          height: 280.0,
          child: ListView.builder(
            // padding: EdgeInsets.only(left: Regular_margin_size),
            scrollDirection: Axis.horizontal,
            itemCount: mComingSoonMovieList.length,
            itemBuilder: (BuildContext context, int index) {
              return MovieView(
                mComingSoonMovieList[index],
                (movieId) {
                  onTapMovie(movieId);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}

class NowShowingMovieView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> mNowShowingMovieList;
  const NowShowingMovieView(this.onTapMovie, this.mNowShowingMovieList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieLabelText(Now_showing_txt),
        SizedBox(
          height: Regular_margin_size,
        ),
        Container(
          // margin: EdgeInsets.only(left: 8.0),
          height: Movie_list_height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mNowShowingMovieList.length,
            itemBuilder: (BuildContext context, int index) {
              return MovieView(
                mNowShowingMovieList[index],
                (movieId) {
                  onTapMovie(movieId);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: XXS_margin_size,
        ),
      ],
    );
  }
}

class AvatarAndNameView extends StatelessWidget {
  final String fbProfileImg;
  AvatarAndNameView(this.fbProfileImg);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: Regular_sizebox_height,
          backgroundImage: (fbProfileImg == null || fbProfileImg == "")
              ? NetworkImage("$PROFILE_IMAGE_URL${loginData.data.profileImage}")
              : NetworkImage("$fbProfileImg"),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          "Hi ${loginData.data.name}",
          style: TextStyle(
            fontSize: Medium_title_text_size,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
