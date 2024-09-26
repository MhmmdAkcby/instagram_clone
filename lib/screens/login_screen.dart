import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/products/utils/colors.dart';
import 'package:instagram_clone/products/utils/image_path.dart';
import 'package:instagram_clone/products/utils/project_string.dart';
import 'package:instagram_clone/products/utils/utils.dart';
import 'package:instagram_clone/products/widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      //
    } else {
      //
      showSnackBar(context: context, content: res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Container(
        padding: const _WidgetEdgeInsets.containerSymmetricH(),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: _WidgetSize().flex, child: Container()),
            // svg Image,
            _instagramSvgMethod(),
            SizedBox(height: _WidgetSize().sizedBoxHeight),

            // text field input for email
            _emailInput(),
            SizedBox(height: _WidgetSize().sizedBoxHeight2),

            // text field input for password
            _passwordInput(),
            SizedBox(height: _WidgetSize().sizedBoxHeight),

            // button login
            _loginButton(),
            SizedBox(height: _WidgetSize().sizedBoxHeight3),
            Flexible(flex: _WidgetSize().flex, child: Container()),

            // Transitioning to signing up
            _warringText(),
          ],
        ),
      ),
    );
  }

  Widget _warringText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _infoText(child: Text(ProjectString.haveAccountText.toStr())),
        GestureDetector(
          child: _infoText(child: Text(ProjectString.signUpText.toStr(), style: _signUpTextStyle())),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _infoText({required Widget child}) {
    return Container(
      padding: const _WidgetEdgeInsets.warringTextSymmetricV(),
      child: child,
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: loginUser,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const _WidgetEdgeInsets.loginButtonPaddingV(),
        decoration: _loginButtonDecoration(),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : Text(ProjectString.loginText.toStr()),
      ),
    );
  }

  ShapeDecoration _loginButtonDecoration() {
    return ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_WidgetSize().buttonRadius),
        ),
      ),
      color: blueColor,
    );
  }

  Widget _emailInput() {
    return TextFieldInput(
      textEditingController: _emailController,
      hintText: ProjectString.emailText.toStr(),
      textInputType: TextInputType.emailAddress,
    );
  }

  Widget _passwordInput() {
    return TextFieldInput(
      textEditingController: _passwordController,
      hintText: ProjectString.passwordText.toStr(),
      textInputType: TextInputType.text,
      isPass: true,
    );
  }

  Widget _instagramSvgMethod() {
    return SvgPicture.asset(
      ImagePath.instagramSvg.imagePath(),
      color: primaryColor,
      height: _WidgetSize().instagramSvgHeight,
    );
  }

  TextStyle? _signUpTextStyle() {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }
}

class _WidgetEdgeInsets extends EdgeInsets {
  const _WidgetEdgeInsets.containerSymmetricH() : super.symmetric(horizontal: 32);
  const _WidgetEdgeInsets.loginButtonPaddingV() : super.symmetric(vertical: 12);
  const _WidgetEdgeInsets.warringTextSymmetricV() : super.symmetric(vertical: 8);
}

class _WidgetSize {
  final double instagramSvgHeight = 64;
  final double sizedBoxHeight = 64;
  final double sizedBoxHeight2 = 24;
  final double sizedBoxHeight3 = 12;
  final double buttonRadius = 4;
  //int
  final int flex = 2;
}
