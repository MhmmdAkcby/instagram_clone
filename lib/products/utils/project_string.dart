enum ProjectString { emailText, passwordText, loginText, haveAccountText, signUpText }

extension ProjectStringTextExtension on ProjectString {
  String toStr() {
    switch (this) {
      case ProjectString.emailText:
        return 'Enter your Email';
      case ProjectString.passwordText:
        return 'Enter your Password';
      case ProjectString.loginText:
        return 'Login';
      case ProjectString.haveAccountText:
        return 'Don\'t have an account?';
      case ProjectString.signUpText:
        return 'Sign up';
    }
  }
}
