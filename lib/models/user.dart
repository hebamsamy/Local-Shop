class UserLogin {
  String Password, Email;
  UserLogin({
    required this.Email,
    required this.Password,
  });
}

class UserRegister {
  String UserName, Password, PhoneNumber, Email;
  UserRegister({
    required this.Email,
    required this.UserName,
    required this.Password,
    required this.PhoneNumber,
  });
}
