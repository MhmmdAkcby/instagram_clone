import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/products/constants/color_constants.dart';
import 'package:instagram_clone/products/constants/string_constants.dart';
import 'package:instagram_clone/products/utils/global_variables.dart';
import 'package:instagram_clone/products/utils/image_path.dart';
import 'package:instagram_clone/products/utils/utils.dart';
import 'package:instagram_clone/products/widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isShow = true;

  void _changeVisibility() {
    setState(() {
      isShow = !isShow;
    });
  }

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

    if (res == StringConstants.success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(context: context, content: res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
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
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3)
            : const _WidgetEdgeInsets.containerSymmetricH(),
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
        _infoText(child: const Text(StringConstants.haveAccountText)),
        GestureDetector(
          onTap: navigateToSignUp,
          child: _infoText(child: Text(StringConstants.signUpText, style: _signUpTextStyle())),
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
                child: CircularProgressIndicator(color: ColorConstants.primaryColor),
              )
            : const Text(StringConstants.loginText),
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
      color: ColorConstants.blueColor,
    );
  }

  Widget _emailInput() {
    return TextFieldInput(
      textEditingController: _emailController,
      hintText: StringConstants.emailText,
      textInputType: TextInputType.emailAddress,
    );
  }

  Widget _passwordInput() {
    return TextFieldInput(
      textEditingController: _passwordController,
      hintText: StringConstants.passwordText,
      textInputType: TextInputType.text,
      isPass: isShow,
      icon: isShow ? Icons.visibility : Icons.visibility_off,
      onChange: () {
        _changeVisibility();
      },
    );
  }

  Widget _instagramSvgMethod() {
    return SvgPicture.asset(
      ImagePath.instagramSvg.imagePath(),
      color: ColorConstants.primaryColor,
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
