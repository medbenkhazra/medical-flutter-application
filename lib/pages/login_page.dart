import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:health_app/common/theme_helper.dart';
import 'package:health_app/controllers/authentificationController.dart';
import 'package:health_app/jwt/jwtMethods.dart';
import 'package:health_app/models/Roles.dart';
import 'package:health_app/pages/doctor/doctorContent.dart';
import 'package:health_app/pages/doctor/drawerDoctorScreen.dart';
import 'package:health_app/pages/forgot_password_page.dart';
import 'package:health_app/pages/patient/PatientHomePage.dart';
import 'package:health_app/pages/patient/drawerPatientScreen.dart';
import 'package:health_app/pages/patient/patientContent.dart';
import 'package:health_app/pages/profile_page.dart';
import 'package:health_app/pages/registration_page.dart';
import 'package:health_app/pages/secretaire/drawerSecretaireScreen.dart';
import 'package:health_app/pages/secretaire/secretaireContent.dart';
import 'package:health_app/services/api_service.dart';
import 'package:health_app/services/auth.dart';
import 'package:health_app/widgets/header_widget.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState(errMsg: '');
}

class LoginPageState extends State<LoginPage> {
  LoginPageState({required this.errMsg});
  final String errMsg;
  final AuthService authService = AuthService();
  static var storage = const FlutterSecureStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  static var username;
  static var firstName;
  static var lastName;
  // final _emailController = TextEditingController();
//final _passwordController = TextEditingController();
  bool isLoading = false;

  void checkToken() async {
    var token = await storage.read(key: "token");
    if (token != null) {
      Navigator.pushReplacement(
          context,
          //i need here to add another conditions for roles
          MaterialPageRoute(builder: (_) => PatientContent()));
    }
  }
    static var currentUserData;
   void fetchCurrentUser() async {
    //send request to get profile
    var getResponse = await apiService.getMyProfile();

    print('this is response status ${getResponse.statusCode}');
  
    switch (getResponse.statusCode) {
      case 200:
        {
          
            currentUserData = jsonDecode(getResponse.body);
         
           
          print("the actual login is ********************");
          print(LoginPageState.currentUserData);
          print(currentUserData['login']);

          print("the actual user is *******");
          print(currentUserData);

          //storing actual user data
          await LoginPageState.storage.write(
              key: 'idCurrentUser', value: currentUserData['id'].toString());
          await LoginPageState.storage
              .write(key: 'loginCurrentUser', value: currentUserData['login']);
          await LoginPageState.storage.write(
              key: 'firstNameCurrentUser', value: currentUserData['firstName']);
          await LoginPageState.storage.write(
              key: 'lastNameCurrentUser', value: currentUserData['lastName']);
          await LoginPageState.storage
              .write(key: 'emailCurrentUser', value: currentUserData['email']);
          await LoginPageState.storage
              .write(key: 'imageCurrentUser', value: currentUserData['image_url']);
          await LoginPageState.storage.write(
              key: 'authoritiesCurrentUser',
              value: json.encode(currentUserData['authorities']));
        }
        break;

      case 401:
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Unauthorized to get user "),
          ));
        }
        break;

      default:
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to get actual user "),
          ));
        }
        break;
    }
  }



  @override
  void initState() {
    super.initState();
    // faaaaaait attention
    LoginPageState.currentUserData=null;
    LoginPageState.storage.deleteAll();
    // checkToken();

    if (errMsg.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errMsg),
        ));
      });
    }
  }

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  //final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  ApiService apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: _headerHeight,
                  child: HeaderWidget(_headerHeight, true,
                      Icons.login), //let's create a common header widget
                ),
                Center(child: Lottie.asset("assets/lottie/login.json")),
              ],
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'HealthCare',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please enter your username';
                                    }
                                  },
                                  onChanged: (value) {},
                                  autocorrect: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'User Name', 'Enter your user name'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {},
                                  autocorrect: true,
                                  obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  //TextField
                                  // obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordPage()),
                                    );
                                  },
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    //after
                                    if (_loginFormKey.currentState == null) {
                                      print("currentStateIs NUll");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Wrong email and password!"),
                                      ));
                                    } else {
                                      if (_loginFormKey.currentState!
                                          .validate()) {
                                        print("currentStateIs Valide");
                                        _loginFormKey.currentState!.save();

                                        var res = await authService.login(
                                            _usernameController.text,
                                            _passwordController.text);

                                        switch (res!.statusCode) {
                                          case 200:
                                        

                                          //***************** */
                                            var data = jsonDecode(res.body);
                                            Map<String, dynamic> payloadMap =
                                                parseJwt(res.body);
                                            print(
                                                "this is our payloadMap *******");
                                            print(payloadMap);
                                            print("this is data *******");
                                            String rolePayload =
                                                payloadMap['auth'];
                                            print("this is roles payload");
                                            print(rolePayload);
                                            List<String> roles =
                                                rolePayload.split(',');
                                            print("this my roles");
                                            print(roles);
                                            print(data);
                                            storage.write(
                                                key: "token",
                                                value: data['id_token']);
                                            print(
                                                "*******************************************it s okkkkay********************************************");
                                            print(await LoginPageState.storage
                                                .read(key: "token"));
                                                fetchCurrentUser();
                                            if (roles.contains("PATIENT")) {
                                             // await Future.delayed(const Duration(seconds: 10), (){});
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                      
                                                         // PatientContent()
                                                         DrawerPatientScreen()
                                                         
                                                          ));
                                            } else if (roles
                                                .contains("MEDECIN")) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          DrawerDoctorScreen()));
                                            } else if (roles
                                                .contains("SECRETAIRE")) {
                                                  print("entered to secretaire");
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                      DrawerSecretaireScreen()
                                                         // SecretaireContent()

                                                          )
                                                          );
                                            } else {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PatientContent()));
                                            }

                                            //getCurrentUser
                                            









                                            

                                            break;
                                          case 401:
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Wrong username or password!"),
                                            ));
                                            break;
                                          default:
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Wrong username or password!"),
                                            ));
                                            break;
                                        }
                                      }
                                    }

                                    //Before
                                    /*  var username = _usernameController.text;
                                    var password = _passwordController.text;
                                    print("${username} this is the username");
                                    print("${password} this is the passord");
                                    var jwt =
                                        await Authentification.attemptLogIn(
                                            username, password, false);
                                    Authentification.jwtAuthen = jwt;
                                    print("thiissss is our json web token");
                                    print(jwt);

                                    if (jwt != null) {
                                      Authentification.storageJwt
                                          .write(key: "jwt", value: jwt);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              //  builder: (context) => HomePage.fromBase64(jwt)
                                              builder: (context) => ProfilePage(
                                                    jwt: jwt,
                                                  )));
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.INFO,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Dialog Title',
                                        desc:
                                            'Dialog description here.............',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {},
                                      )..show();
                                    }
                                    //After successful login we will redirect to profile page. Let's create profile page now

                                    /* Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage())); */ */
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Don\'t have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
