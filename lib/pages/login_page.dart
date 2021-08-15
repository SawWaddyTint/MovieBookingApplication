import 'dart:convert';

import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_dio.dart';
import 'package:MovieBookingApplication/pages/movie_lists_page.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/resources/strings.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn_with_facebook.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn_with_google.dart';
import 'package:MovieBookingApplication/widgets/form_field_name.dart';
import 'package:MovieBookingApplication/widgets/form_text_field.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

import '../utility_function.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
var nameController = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
bool isEmailNull = false;
bool isPasswordNull = false;
bool isNameNull = false;
bool isPhoneNull = false;
bool isRegEmailNull = false;
bool isRegPwNull = false;
String fbAccessToken = "";
bool isValid = true;
bool isPhoneValid = true;
String googleAccessToken = "";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MovieModel mMovieModel = MovieModelImpl();
  List<MovieVO> mMovieList;
  // FacebookDataDao profileData;
  LoginDataResponse loginData;
  UserDataVO userData;
  String token;
  var fbProfile;
  String fbProfileImg;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  // var profileData;
  bool isLoggedIn = false;
  String _message = 'Log in/out by pressing the buttons below.';
  // void _registerGoogle() {
  //   debugPrint("");
  // }

  void _checkLoginField(String email, String password) {
    setState(() {
      String _email;
      String _password;
      _email = email;
      _password = password;
      if (_email == "") {
        setState(() {
          isEmailNull = true;
        });
      } else {
        isEmailNull = false;
        isValid = EmailValidator.validate(_email);
      }
      if (_password == "") {
        setState(() {
          isPasswordNull = true;
        });
      } else
        isPasswordNull = false;

      if (!isEmailNull && !isPasswordNull) {
        this.loginWithEmail(_email, _password);
      }
    });
  }

  void loginWithEmail(String email, String password) {
    mMovieModel.emailLogin(email, password).then((value) {
      setState(() {
        this.loginData = value;
        this.userData = this.loginData.data;
        this.token = this.loginData.token;
        if (this.loginData.message == "user login successfully") {
          Fluttertoast.showToast(
            msg: this.loginData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToMovieListsPage(context);
        } else {
          handleError(context, this.loginData.message);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  loginWithFacebook(String fbAccessToken) {
    mMovieModel.facebookLogin(fbAccessToken).then((value) {
      setState(() {
        this.loginData = value;
        this.userData = this.loginData.data;
        this.token = this.loginData.token;
        if (this.loginData.message == "user login successfully") {
          Fluttertoast.showToast(
            msg: this.loginData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToMovieListsPage(context);
        } else {
          handleError(context, this.loginData.message);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  loginWithGoogle(String googleAccessToken) {
    mMovieModel.googleLogin(googleAccessToken).then((value) {
      setState(() {
        this.loginData = value;
        this.userData = this.loginData.data;
        this.token = this.loginData.token;
        if (this.loginData.message == "user login successfully") {
          Fluttertoast.showToast(
            msg: this.loginData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToMovieListsPage(context);
        } else {
          handleError(context, this.loginData.message);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

// final graphResponse = await http.get(
//               'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
//           final profile = JSON.jsonDecode(graphResponse.body);
// proifle['id']
  void _navigateToMovieListsPage(BuildContext context) {
    name.text = "";
    phone.text = "";
    email.text = "";
    password.text = "";
    fbAccessToken = "";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieListsPage(
          fbProfileImg: fbProfileImg,
        ),
      ),
    );
  }

  _checkRegisterField(name, phone, email, password) {
    setState(() {
      String _name;
      String _phone;
      String _email;
      String _password;
      _name = name;
      _phone = phone;
      _email = email;
      _password = password;
      if (_name == "") {
        setState(() {
          isNameNull = true;
        });
      } else
        isNameNull = false;
      if (_phone == "") {
        setState(() {
          isPhoneNull = true;
        });
      } else {
        isPhoneNull = false;
        if (_phone.length != 12 || _phone.substring(0, 3) != "959") {
          isPhoneValid = false;
        } else
          isPhoneValid = true;
      }
      if (_email == "") {
        setState(() {
          isRegEmailNull = true;
        });
      } else {
        isRegEmailNull = false;
        isValid = EmailValidator.validate(_email);
      }
      if (_password == "") {
        setState(() {
          isRegPwNull = true;
        });
      } else
        isRegPwNull = false;

      if (fbAccessToken != "") {
        if (!isNameNull && !isPhoneNull && !isRegEmailNull && !isRegPwNull) {
          this.registerWithFacebook(
              _name, _phone, _password, _email, fbAccessToken);
        }
      } else if (googleAccessToken != "") {
        if (!isNameNull && !isPhoneNull && !isRegEmailNull && !isRegPwNull) {
          this.registerWithGoogle(
              _name, _phone, _password, _email, googleAccessToken);
        }
      } else {
        if (!isNameNull && !isPhoneNull && !isRegEmailNull && !isRegPwNull) {
          this.registerWithEmail(_name, _phone, _password, _email);
        }
      }
    });
  }

  registerWithEmail(String name, phone, password, email) {
    mMovieModel.register(name, email, phone, password).then((value) {
      if (value.code == RESPONSE_CODE_SUCCESS) {}
      setState(() {
        this.loginData = value;
        this.userData = this.loginData.data;
        this.token = this.loginData.token;
        if (this.loginData.message == "create user successfully") {
          Fluttertoast.showToast(
            msg: this.loginData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToMovieListsPage(context);
        } else {
          handleError(context, this.loginData.message);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  registerWithFacebook(String name, String phone, String password, String email,
      String fbAccessToken) {
    mMovieModel
        .register(name, email, phone, password,
            facebookAccessToken: fbAccessToken)
        .then((value) {
      setState(() {
        this.loginData = value;
        this.userData = this.loginData.data;
        this.token = this.loginData.token;
        if (this.loginData.message == "create user successfully") {
          Fluttertoast.showToast(
            msg: this.loginData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToMovieListsPage(context);
        } else {
          handleError(context, this.loginData.message);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  registerWithGoogle(String name, String phone, String password, String email,
      String googleAccessToken) {
    mMovieModel
        .register(name, email, phone, password,
            googleAccessToken: googleAccessToken)
        .then((value) {
      setState(() {
        this.loginData = value;
        this.userData = this.loginData.data;
        this.token = this.loginData.token;
        if (this.loginData.message == "create user successfully") {
          Fluttertoast.showToast(
            msg: this.loginData.message,
            textColor: App_theme_color,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
          );
          this._navigateToMovieListsPage(context);
        } else {
          handleError(context, this.loginData.message);
        }
      });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  Future<Null> _registerFB() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    debugPrint("facebook sign in result>>" + result.errorMessage.toString());

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        debugPrint("facebook access token is >>>" + result.accessToken.token);
        print("LoggedIn");
        var graphResponse = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${result.accessToken.token}");
        // FacebookDataDao profileData =
        // FacebookDataDao.fromJson(graphResponse.body);
        fbProfile = jsonDecode(graphResponse.body);
        // profileData = FacebookDataDao.fromJson(profile);
        // debugPrint("facebook data >>>" + profileData.toString());
        // final String name = profile['name'];
        fbProfileImg = fbProfile['picture']['data']['url'];
        fbAccessToken = fbProfile['id'];
        googleAccessToken = "";
        // debugPrint("profile name >>>" + name + profileImage);
        name.text = fbProfile['name'];
        email.text = fbProfile['email'];
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _loginFB() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    debugPrint("facebook sign in result>>" + result.errorMessage.toString());

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        debugPrint("facebook access token is >>>" + fbAccessToken);
        print("LoggedIn");
        var graphResponse = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${result.accessToken.token}");
        // FacebookDataDao profileData =
        // FacebookDataDao.fromJson(graphResponse.body);
        fbProfile = jsonDecode(graphResponse.body);
        // profileData = FacebookDataDao.fromJson(profile);
        // debugPrint("facebook data >>>" + profileData.toString());
        // final String name = profile['name'];
        fbProfileImg = fbProfile['picture']['data']['url'];
        fbAccessToken = fbProfile['id'];
        // debugPrint("profile name >>>" + name + profileImage);
        // name.text = fbProfile['name'];
        // email.text = fbProfile['email'];
        this.loginWithFacebook(fbAccessToken);
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  _loginGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        // 'email',
        'https://www.googleapis.com/auth/userinfo.email'
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      // email.text = googleAccount.email;
      googleAccount.authentication.then((authentication) {
        print(authentication.accessToken);
        googleAccessToken = authentication.accessToken;
        fbAccessToken = "";
        this.loginWithGoogle(googleAccessToken);
      });
    });
  }

  _registerGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        // 'email',
        'https://www.googleapis.com/auth/userinfo.email'
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      email.text = googleAccount.email;
      googleAccount.authentication.then((authentication) {
        print(authentication.accessToken);
        googleAccessToken = authentication.accessToken;
        fbAccessToken = "";
      });
    });
  }

  // Future<Map<String, dynamic>> getFacebookData(token)  async {
  //   var graphResponse = await Dio().get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  //   var map=Map<String, dynamic>.from(graphResponse.data);
  //   return FacebookDataVO.fromJson(map);
  // }
  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      // nameController.text = profileData.name;
    });
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  final List<String> tabNameList = ["Login", "Register"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: Toolbar_height,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: App_theme_color,
              unselectedLabelColor: Colors.black,
              labelColor: App_theme_color,
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: Small_margin_size),
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: tabNameList
                  .map(
                    (tName) => Tab(
                      child: TabNameView(tName),
                    ),
                  )
                  .toList(),
            ),
            title: LoginPageTitle(),
          ),
          body: TabBarView(
            children: [
              LoginTabBarView(
                // (loginEmail,loginPw)=>_getLoginData(loginEmail,loginPw)
                (loginEmail, loginPw) => _checkLoginField(loginEmail, loginPw),
                () {
                  this._loginFB();
                },
                () {
                  this._loginGoogle();
                },
              ),
              RegisterTabBarView(
                (registerName, registerPhone, registerEmail, registerPw) =>
                    _checkRegisterField(
                        registerName, registerPhone, registerEmail, registerPw),
                () {
                  this._registerFB();
                },
                () {
                  this._registerGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabNameView extends StatelessWidget {
  final String tabName;
  TabNameView(this.tabName);

  @override
  Widget build(BuildContext context) {
    return Text(
      tabName,
      style: TextStyle(
        fontSize: Regular_title_text_size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class RegisterTabBarView extends StatelessWidget {
  final Function(String, String, String, String) getRegisterValue;
  final Function registerWithFb;
  final Function registerWithGoogle;
  RegisterTabBarView(
      this.getRegisterValue, this.registerWithFb, this.registerWithGoogle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Small_margin_size,
        right: Small_margin_size,
        top: Image_margin_top,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterFieldsView(
                (registerName, registerPhone, registerEmail, registerPw) {
              this.getRegisterValue(
                  registerName, registerPhone, registerEmail, registerPw);
            }, () {
              this.registerWithFb();
            }, () {
              this.registerWithGoogle();
            }),
            SizedBox(
              height: Medium_title_text_size,
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterFieldsView extends StatelessWidget {
  final Function(String, String, String, String) getRegisterValue;
  final Function registerWithFb;
  final Function registerWithGoogle;
  RegisterFieldsView(
      this.getRegisterValue, this.registerWithFb, this.registerWithGoogle);
  @override
  Widget build(BuildContext context) {
    bool isPwField = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldName(Name_txt),
        TextField(
          controller: name,
          obscureText: isPwField,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Visibility(
          child: Text(
            "Please fill name!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: isNameNull,
        ),
        SizedBox(
          height: Medium_sizebox_height,
        ),
        FormFieldName(Ph_num_txt),
        TextField(
          controller: phone,
          obscureText: isPwField,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Visibility(
          child: Text(
            "Please fill phone number!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: isPhoneNull,
        ),
        Visibility(
          child: Text(
            "Wrong Phone Number!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: !isPhoneValid,
        ),
        SizedBox(
          height: Medium_sizebox_height,
        ),
        FormFieldName(Email_txt),
        TextField(
          controller: email,
          obscureText: isPwField,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Visibility(
          child: Text(
            "Please fill email!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: isRegEmailNull,
        ),
        Visibility(
          child: Text(
            "Wrong Email Format!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: !isValid,
        ),
        SizedBox(
          height: Medium_sizebox_height,
        ),
        FormFieldName(Pw_txt),
        TextField(
          controller: password,
          obscureText: isPwField,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Visibility(
          child: Text(
            "Please fill password!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: isRegPwNull,
        ),
        SizedBox(
          height: Regular_sizebox_height,
        ),
        AppActionBtnWithFacebook(
          Reg_with_fb_txt,
          Image.asset(
            "lib/assets/images/facebook.webp",
            height: Medium_title_text_size,
            width: Medium_title_text_size,
          ),
          () {
            this.registerWithFb();
          },
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtnWithGoogle(
          Reg_with_google_txt,
          Image.asset(
            "lib/assets/images/google.png",
            height: Medium_title_text_size,
            width: Medium_title_text_size,
          ),
          () {
            this.registerWithGoogle();
          },
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtn(
          Confirm_txt,
          () {
            this.getRegisterValue(
                name.text, phone.text, email.text, password.text);
          },
        ),
        SizedBox(
          height: Regular_margin_size_2X,
        ),
      ],
    );
  }
}

class LoginTabBarView extends StatelessWidget {
  final Function(String, String) getLogInValue;
  final Function loginWithFacebook;
  final Function loginWithGoogle;
  LoginTabBarView(
      this.getLogInValue, this.loginWithFacebook, this.loginWithGoogle);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Small_margin_size,
        right: Small_margin_size,
        top: Image_margin_top,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogInFieldsView((loginEmail, loginPw) {
              getLogInValue(loginEmail, loginPw);
            }, () {
              this.loginWithFacebook();
            }, () {
              this.loginWithGoogle();
            }),
          ],
        ),
      ),
    );
  }
}

class LogInFieldsView extends StatefulWidget {
  final Function(String, String) getLogInValue;
  final Function loginWithFacebook;
  final Function loginWithGoogle;
  LogInFieldsView(
      this.getLogInValue, this.loginWithFacebook, this.loginWithGoogle);

  @override
  _LogInFieldsViewState createState() => _LogInFieldsViewState();
}

class _LogInFieldsViewState extends State<LogInFieldsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldName(Email_txt),
        TextField(
          controller: email,
          obscureText: false,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Visibility(
          child: Text(
            "Please fill email!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: isEmailNull,
        ),
        Visibility(
          child: Text(
            "Wrong Email Format!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: !isValid,
        ),
        SizedBox(
          height: Medium_sizebox_height,
        ),
        FormFieldName(Pw_txt),
        TextField(
          controller: password,
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Visibility(
          child: Text(
            "Please fill password!",
            style: TextStyle(
              color: Colors.red,
              fontSize: Regular_text_size,
            ),
          ),
          visible: isPasswordNull,
        ),
        SizedBox(
          height: Regular_sizebox_height,
        ),
        ForgetPasswordText(),
        SizedBox(
          height: Regular_sizebox_height,
        ),
        AppActionBtnWithFacebook(
            SignIn_with_fb_txt,
            Image.asset(
              "lib/assets/images/facebook.webp",
              height: Medium_title_text_size,
              width: Medium_title_text_size,
            ), () {
          widget.loginWithFacebook();
        }),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtnWithGoogle(
          SignIn_with_google_txt,
          Image.asset(
            "lib/assets/images/google.png",
            height: Medium_title_text_size,
            width: Medium_title_text_size,
          ),
          () {
            widget.loginWithGoogle();
          },
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtn(Confirm_txt, () {
          widget.getLogInValue(email.text, password.text);
        }),
        SizedBox(
          height: Regular_margin_size_2X,
        ),
        //      Container(
        //      height: Action_btn_height,
        //        width: double.infinity,
        //       child: RaisedButton(
        //      color: App_theme_color,
        //       shape: RoundedRectangleBorder(
        //        borderRadius: BorderRadius.all(
        //      Radius.circular(XXS_margin_size),
        //        ),
        //       side:
        //      BorderSide(color: App_theme_color),
        //  ),
        //     child: Center(
        //      child: Text(
        //      "Confirm",
        //      style: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //     fontSize: Subtitle_text_size),
        //     ),
        //      ),
        //  onPressed: () {
        //  widget.getLogInValue(
        // widget.email.text,widget.password.text
        //  );
        //  },
        //  ),
        //  ),
      ],
    );
  }
}

class LoginActionBtnView extends StatelessWidget {
  final Function onTapBtn;
  LoginActionBtnView(this.onTapBtn);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppActionBtnWithFacebook(
            SignIn_with_fb_txt,
            Image.asset(
              "lib/assets/images/facebook.webp",
              height: Medium_title_text_size,
              width: Medium_title_text_size,
            ),
            () {}),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtnWithGoogle(
          SignIn_with_google_txt,
          Image.asset(
            "lib/assets/images/google.png",
            height: Medium_title_text_size,
            width: Medium_title_text_size,
          ),
          () {
            this.onTapBtn();
          },
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtn(
          Confirm_txt,
          () {
            this.onTapBtn();
          },
        ),
        SizedBox(
          height: Regular_margin_size_2X,
        ),
      ],
    );
  }
}

class ForgetPasswordText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        Forget_Pw_text,
        style: TextStyle(
          color: Welcome_logIn_subTitle_color,
          fontWeight: FontWeight.bold,
          fontSize: Regular_text_size,
        ),
      ),
    );
  }
}

class LoginPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Welcome_txt1,
          style: TextStyle(
            fontSize: Title_text_size,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          Welcome_back_txt,
          style: TextStyle(
              color: Welcome_logIn_subTitle_color,
              fontSize: Regular_text_size,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RegisterActionBtnView extends StatelessWidget {
  final Function onTapBtn;
  final Function registerWithFb;
  final Function registerWithGoogle;
  RegisterActionBtnView(
      this.onTapBtn, this.registerWithFb, this.registerWithGoogle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppActionBtnWithFacebook(
          Reg_with_fb_txt,
          Image.asset(
            "lib/assets/images/facebook.webp",
            height: Medium_title_text_size,
            width: Medium_title_text_size,
          ),
          () {
            this.registerWithFb();
          },
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtnWithGoogle(
          Reg_with_google_txt,
          Image.asset(
            "lib/assets/images/google.png",
            height: Medium_title_text_size,
            width: Medium_title_text_size,
          ),
          () {
            this.registerWithGoogle();
          },
        ),
        SizedBox(
          height: Small_margin_size,
        ),
        AppActionBtn(
          Confirm_txt,
          () {
            this.onTapBtn();
          },
        ),
        SizedBox(
          height: Regular_margin_size_2X,
        ),
      ],
    );
  }
}
