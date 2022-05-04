import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/common/theme_helper.dart';
import 'package:health_app/controllers/authentificationController.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/registration_page.dart';

import 'package:health_app/pages/splash_screen.dart';
import 'package:health_app/services/api_service.dart';
import 'package:health_app/services/apiinterceptor.dart';
import 'package:health_app/widgets/header_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;

  final _ModifyFormKey = GlobalKey<FormState>();
  String tesxt="sg";
  
  final _loginController = TextEditingController();
  
  final _passwordController = TextEditingController();
  
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final ApiService apiService = new ApiService();
  final ApiInterceptor _apiInterceptor = new ApiInterceptor();
  String fullName="user name";
  //var currentUserData;
  
  File? image;
  Future pickImage(ImageSource source) async {
    print("enter to fct");
    try {
      print("enter to Block");
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      print("image picked");
      if (image == null) {
        print("image is null");
        return;
      }
      ;
      print("image is not null");
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Faild to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  //  fetchCurrentUser();
    
    _loginController.text= LoginPageState.currentUserData['login'] ??"enter your name";
    _firstNameController.text= LoginPageState.currentUserData['firstName'] ??"enter your firstName";
    _lastNameController.text= LoginPageState.currentUserData['lastName'] ??"enter your lastName";
    _emailController.text= LoginPageState.currentUserData['email'] ??"enter your email";
      
    fullName="${_firstNameController.text} ${_lastNameController.text}";
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 100, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _ModifyFormKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 5, color: Colors.white),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: const Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    width: 90.0,
                                    height: 90.0,
                                    child: new Stack(
                                      children: <Widget>[
                                        image != null
                                            ? ClipOval(
                                                child: Image.file(
                                                  image!,
                                                  width: 130,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : FlutterLogo(size: 130),
                                        new Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: FloatingActionButton(
                                                heroTag: "btn1",
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons
                                                    .add_circle_outline_rounded),
                                                onPressed: () {
                                                  pickImage(
                                                      ImageSource.gallery);
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  //before
                                  /* child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ), */

                                  //before
                                  /* child: image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          image!,
                                          width: 130,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : FlutterLogo(size: 80) ,
                              ),
                              Positioned(
                                right: 3,
                                bottom: 20,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                    },
                                    child: Icon(
                                      Icons.add_circle_rounded,
                                      color: Colors.red,
                                      size: 25.0,
                                    ),
                                  ),
                                ),*/
                                  ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              fullName.toUpperCase(),
                             // "Mohammed BENKHAZRA".toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField( 
                           
                            controller: _loginController,
                            decoration: ThemeHelper().textInputDecoration(
                                'username ', 'Enter your username'),
                            onChanged: (value) {},
                            autocorrect: true,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name', 'Enter your first name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your last name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your Email';
                              } else {
                                return EmailValidator.validate(value)
                                    ? null
                                    : 'Please fill with the valid email';
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        /* SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number",
                                "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ), */
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          height: 40,
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Modify".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            //after
                            onPressed: () async {
                              //after
                              if (_ModifyFormKey.currentState == null) {
                                print("currentStateIs NUll");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Wrong email and password!"),
                                ));
                              } else {
                                if (_ModifyFormKey.currentState!.validate()) {
                                  print("currentStateIs Valide");
                                  _ModifyFormKey.currentState!.save();
                                  print("*****************");
                                  print(_loginController.text);
                                  print(_firstNameController.text);
                                  print(_lastNameController.text);
                                  print(_emailController.text);
                                  print(_passwordController.text);

                                  var res = await apiService.updateUser(
                                      _loginController.text,
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _emailController.text,
                                      _passwordController.text);
                                      

                                  switch (res.statusCode) {
                                    case 200:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "resource updated successfully"),
                                      ));
                                      break;
                                    case 204:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "resource updated successfully"),
                                      ));
                                      break;
                                    case 201:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("new user is created"),
                                      ));
                                      break;
                                    case 400:
                                      var data = jsonDecode(res.body);
                                      if (data["msg"]) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(data["msg"].toString()),
                                        ));
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Failed to update user"),
                                      ));
                                      break;

                                      break;

                                    case 401:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("update failed"),
                                      ));
                                      break;
                                    case 403:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Permission Denied"),
                                      ));
                                      break;

                                    default:
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Default update failed"),
                                      ));
                                      break;
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
