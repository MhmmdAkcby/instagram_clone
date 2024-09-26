import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/products/utils/colors.dart';
import 'package:instagram_clone/products/utils/image_path.dart';
import 'package:instagram_clone/products/utils/project_string.dart';
import 'package:instagram_clone/products/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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

            //circular widget to accept and show our selected file
            Stack(
              children: [
                CircleAvatar(
                  radius: _WidgetSize().circularAvatarRadius,
                  backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1720048171419-b515a96a73b8?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: primaryColor,
                      )),
                ),
              ],
            ),
            SizedBox(height: _WidgetSize().sizedBoxHeight2),

            //text field input for username
            _usernameInput(),
            SizedBox(height: _WidgetSize().sizedBoxHeight2),

            //text field input for bio
            _bioInput(),
            SizedBox(height: _WidgetSize().sizedBoxHeight2),

            // text field input for email
            _emailInput(),
            SizedBox(height: _WidgetSize().sizedBoxHeight2),

            // text field input for password
            _passwordInput(),
            SizedBox(height: _WidgetSize().sizedBoxHeight),

            // button signup
            _signupButton(),
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
        _infoText(child: Text(ProjectString.haveAccountInfoText.toStr())),
        GestureDetector(
          child: _infoText(child: Text(ProjectString.loginText.toStr(), style: _signUpTextStyle())),
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

  Widget _signupButton() {
    return InkWell(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const _WidgetEdgeInsets.loginButtonPaddingV(),
        decoration: _loginButtonDecoration(),
        child: Text(ProjectString.signUpText.toStr()),
      ),
      onTap: () {},
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

  Widget _usernameInput() {
    return TextFieldInput(
      textEditingController: _usernameController,
      hintText: ProjectString.usernameText.toStr(),
      textInputType: TextInputType.text,
    );
  }

  Widget _bioInput() {
    return TextFieldInput(
      textEditingController: _bioController,
      hintText: ProjectString.bioText.toStr(),
      textInputType: TextInputType.text,
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
  final double circularAvatarRadius = 64;
  //int
  final int flex = 2;
}
