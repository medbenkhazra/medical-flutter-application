class LoginVM {
  String username;
  String password;
  bool rememberMe;
 String get getUsername => this.username;

 set setUsername(String username) => this.username = username;

  get getPassword => this.password;

 set setPassword( password) => this.password = password;

  get getRememberMe => this.rememberMe;

 set setRememberMe( rememberMe) => this.rememberMe = rememberMe;
 

  LoginVM({
    required this.username,
    required this.password,
    required this.rememberMe,
  });
}
