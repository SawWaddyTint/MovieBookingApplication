import 'package:MovieBookingApplication/pages/movie_choose_time_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/cast_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/pages/ticket_details.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';
import 'package:MovieBookingApplication/widgets/circle_avatar_profile.dart';
import 'package:MovieBookingApplication/widgets/movie_label_text.dart';

import '../utility_function.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  MovieDetailsPage(this.movieId);
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieModel mMovieModel = MovieModelImpl();
  MovieDetailVO mMovie;
  List<CastVO> casts;
  final List<String> genreList = [
    "Mystery",
    "Adventure",
  ];
  @override
  void initState() {
    super.initState();

    // Movie Details
    //   mMovieModel.getMovieDetails(widget.movieId).then((movie) {
    //     setState(() {
    //       this.mMovie = movie;
    //       mMovieModel.getSigleMovieFromDatabase(widget.movieId).then((value) {
    //         setState(() {
    //           this.mMovie = value;
    //         });
    //       }).catchError((error) {
    //         handleError(context, error);
    //         // debugPrint(error.toString());
    //       });
    //       if (this.mMovie != null) {
    //         this.casts = this.mMovie.casts;
    //       }
    //       debugPrint(
    //           "Movie details in Movie details page>>> " + this.mMovie.toString());
    //     });
    //   }).catchError((error) {
    //     handleError(context, error);
    //     // debugPrint(error.toString());
    //   });

    mMovieModel.getSigleMovieFromDatabase(widget.movieId).listen((value) {
      setState(() {
        this.mMovie = value;
        if (this.mMovie != null) {
          this.casts = this.mMovie.casts;
        }
      });
    }).onError((error) {
      debugPrint(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: (this.mMovie != null)
          ? Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      expandedHeight: Slivers_expanded_height,
                      flexibleSpace: Stack(
                        children: [
                          FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Stack(
                              children: [
                                BackgroundImageView(mMovie),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: BackBtnView(
                                      () => _navigateToPreviousPage(context)),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: PlayButtonView(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Regular_title_text_size),
                                  topLeft:
                                      Radius.circular(Regular_title_text_size)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: Regular_margin_size,
                                  top: Medium_margin_size,
                                  right: Regular_margin_size),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MovieNameDurationAndRatingView(mMovie),
                                  MoiveGenreChipView(mMovie),
                                  SizedBox(
                                    height: Small_margin_size,
                                  ),
                                  PlotSummaryView(mMovie),
                                  SizedBox(
                                    height: Small_margin_size,
                                  ),
                                  CastView(casts),
                                  SizedBox(height: Large_sizebox_height),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetTicketBtnView(() {
                    _navigateToMovieChooseTimePage(context, mMovie);
                  }),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

_navigateToPreviousPage(BuildContext context) {
  Navigator.pop(context);
}

class PlayButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.0,
      height: 38.0,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(Regular_sizebox_height),
        border: Border.all(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      child: Icon(
        Icons.play_arrow,
        size: Regular_sizebox_height,
        color: Colors.white,
      ),
    );
  }
}

void _navigateToMovieChooseTimePage(BuildContext context, MovieDetailVO movie) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MovieChooseTimePage(movie),
    ),
  );
}

class GetTicketBtnView extends StatelessWidget {
  final Function onTapGetTicket;
  GetTicketBtnView(this.onTapGetTicket);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Small_margin_size,
        right: Small_margin_size,
        bottom: Regular_margin_size_2X,
        top: Image_margin_top,
      ),
      child: AppActionBtn("Get your ticket", () {
        this.onTapGetTicket();
      }),
    );
  }
}

class CastView extends StatelessWidget {
  List<CastVO> casts;
  CastView(this.casts);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieLabelText("Cast"),
        SizedBox(
          height: Small_margin_size,
        ),
        Container(
          height: 50.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (BuildContext context, int index) {
              return CircleAvatarProfile(Regular_sizebox_height, casts[index]);
            },
          ),
        ),
      ],
    );
  }
}

class PlotSummaryView extends StatelessWidget {
  final MovieDetailVO mMovie;
  PlotSummaryView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieLabelText("Plot Summary"),
        SizedBox(
          height: XXS_margin_size,
        ),
        Text(
          mMovie.overview,
          style: TextStyle(
            color: Movie_details_text_color,
            fontSize: Subtitle_text_size,
          ),
        ),
      ],
    );
  }
}

class MoiveGenreChipView extends StatelessWidget {
  final MovieDetailVO mMovie;
  MoiveGenreChipView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: <Widget>[
          for (var genres in mMovie.genres) GenreChipView(genres),
        ]);
  }
}

class MovieNameDurationAndRatingView extends StatelessWidget {
  final MovieDetailVO mMovie;
  MovieNameDurationAndRatingView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mMovie.originalTitle,
          style: TextStyle(
            fontSize: Movie_title_txt_size,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        Row(
          children: [
            Text(
              mMovie.runtime.toString() + " min",
              style: TextStyle(
                color: Movie_details_text_color,
                fontSize: Regular_title_text_size,
              ),
            ),
            SizedBox(
              width: XXS_margin_size,
            ),
            RatingBar.builder(
              initialRating: 5.0,
              itemBuilder: (BuildContext context, int index) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              itemSize: Medium_margin_size,
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(
              width: XXS_margin_size,
            ),
            Text(
              "IMDb " + mMovie.rating.toString(),
              style: TextStyle(
                color: Movie_details_text_color,
                fontSize: Regular_title_text_size,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BackBtnView extends StatelessWidget {
  final Function tapBack;
  BackBtnView(this.tapBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(
          left: XXS_margin_size,
          top: Regular_margin_size_2X,
        ),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: Back_arrow_size,
        ),
      ),
      onTap: () {
        this.tapBack();
      },
    );
  }
}

class BackgroundImageView extends StatelessWidget {
  final MovieDetailVO mMovie;
  BackgroundImageView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "$IMAGE_BASE_URL${mMovie.posterPath}",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: null /* add child content here */,
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          backgroundColor: Colors.transparent,
          shape: StadiumBorder(
              side: BorderSide(color: Movie_details_chip_border_color)),
          label: Padding(
            padding: const EdgeInsets.all(XXS_margin_size),
            child: Text(
              genreText,
              style: TextStyle(
                color: Movie_details_text_color,
                fontWeight: FontWeight.bold,
                fontSize: Small_text_size,
              ),
            ),
          ),
        ),
        SizedBox(
          width: XXS_margin_size,
        ),
      ],
    );
  }
}
