import 'package:MovieBookingApplication/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/resources/strings.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';



class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App_theme_color,
      body: Container(
        color: App_theme_color,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Small_margin_size,
            right: Small_margin_size,
            bottom: Regular_margin_size_2X,
            top: Image_margin_top,
          ),
          child: Stack(
            children: [
              Positioned(
                top: Title_text_size,
                left: Small_margin_size,
                right: Small_margin_size,
                child: Image.asset(
                  "lib/assets/images/welcomeImg.png",
                  width: Welcome_image_size,
                  height: Welcome_image_size,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Welcome_text_padding),
                  child: Text(
                    Welcome_txt,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Welcome_text_size,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: Hello_welcome_text_padding),
                  child: Text(
                    Hello_welcome_txt,
                    style: TextStyle(
                        color: Hello_welcome_text_color,
                        fontSize: Subtitle_text_size,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppActionBtn(
                  Get_started_txt,
                  () {
                    _navigateToLoginPage(context);
                  },
                  isGhostBtn: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToLoginPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}
