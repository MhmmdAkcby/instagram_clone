enum ProjectString {
  emailText,
  passwordText,
  loginText,
  haveAccountText,
  signUpText,
  usernameText,
  bioText,
  signupText,
  haveAccountInfoText,
}

extension ProjectStringTextExtension on ProjectString {
  String toStr() {
    switch (this) {
      case ProjectString.emailText:
        return 'Enter your email';
      case ProjectString.passwordText:
        return 'Enter your password';
      case ProjectString.loginText:
        return 'Login';
      case ProjectString.haveAccountText:
        return 'Don\'t have an account?';
      case ProjectString.signUpText:
        return 'Sign up';
      case ProjectString.usernameText:
        return 'Enter your username';
      case ProjectString.bioText:
        return 'Enter your bio';
      case ProjectString.signupText:
        return 'Sign Up';
      case ProjectString.haveAccountInfoText:
        return 'Your have a account?';
    }
  }
}
