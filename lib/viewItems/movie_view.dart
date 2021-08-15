import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class MovieView extends StatelessWidget {
  final MovieVO mMovie;
  final Function(int) onTapMovie;
  MovieView(this.mMovie, this.onTapMovie);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      // margin: EdgeInsets.only(left: 8.0),
      child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapMovie(mMovie.id);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Xs_margin_size),
              child: MovieImages(mMovie),
            ),
          ),
          SizedBox(
            height: Regular_margin_size,
          ),
          Container(
            // margin: EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.0,
                  child: Text(
                    mMovie.originalTitle,
                    style: TextStyle(
                      fontSize: Regular_text_size,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GenreAndDurationView(
                    mMovie.genres.map((genre) => genre).join("/"))
              ],
            ),
          ),

          // Text(
          //         mMovie.originalTitle,
          //         style: TextStyle(
          //           fontSize: Subtitle_text_size,
          //           fontWeight: FontWeight.w700,
          //         ),
          //       ),
          //       SizedBox(
          //         height: 6.0,
          //       ),
          //           Row(
          //             children:<Widget>[  for(var genres in mMovie.genres ) TextViewWidget(genres)
          //              ,]
          //
          //           )
        ],
      ),
    );
  }
}

class GenreAndDurationView extends StatelessWidget {
  final String genre;
  GenreAndDurationView(this.genre);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Flexible(
          child: Text(
            genre,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              color: Welcome_logIn_subTitle_color,
            ),
            // overflow: TextOverflow.ellipsis
          ),
        ),
        Flexible(
          child: Text(
            " - 1hr 45min",
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              color: Welcome_logIn_subTitle_color,
            ),
            // overflow: TextOverflow.ellipsis,
            // softWrap: false,
          ),
        ),
      ]),
    );
  }
}

class TextViewWidget extends StatelessWidget {
  final String genre;
  TextViewWidget(this.genre);
  @override
  Widget build(BuildContext context) {
    return Text(
      genre,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
        color: Welcome_logIn_subTitle_color,
      ),
      // overflow: TextOverflow.ellipsis
    );
  }
}

class MovieImages extends StatelessWidget {
  MovieVO mMovie;
  MovieImages(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL${mMovie.posterPath}",
      height: 200.0,
      width: 160.0,
      fit: BoxFit.cover,
    );
  }
}
