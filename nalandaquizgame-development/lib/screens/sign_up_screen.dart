// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:nalandaquizgame/utils/routes.dart';
import 'package:nalandaquizgame/widgets/footer_container_widget.dart';
import 'package:nalandaquizgame/widgets/heading_container_widget.dart';
import 'package:nalandaquizgame/widgets/rounded_button_widget.dart';
import 'package:nalandaquizgame/widgets/rounded_text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  
  bool _nameValidate = false;
  bool _emailValidate = false;
  bool _emailRegExValidate = false;
  bool _passwordValidate = false;

  var emailRegulator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/images/backgrounds/transparentBG.png").image,
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.modulate,)
          ),
          color: Color.fromARGB(255, 227, 219, 219)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  HeadingContainerWidget(containerText: "Create Account", screenHeight: height, dividerHeight: 4,),
                  SizedBox(height: height / height / 0.03,),
                  // TextFieldWidget("Enter your name"),
                  TextFieldWidget(
                    textFieldHint: "Enter your name", 
                    textFieldError: "Name cannot be empty", 
                    controller: _nameController, 
                    validate: _nameValidate
                  ),

                  SizedBox(height: height / height / 0.04),
                  // TextFieldWidget("Enter your email"),
                  TextFieldWidget(
                    textFieldHint: "Enter your email", 
                    textFieldError: "Email cannot be empty", 
                    invalidEmailError: "Enter a valid email!",
                    controller: _emailController, 
                    emailValidate: _emailRegExValidate,
                    validate: _emailValidate
                  ),
                  SizedBox(height: height / height / 0.04),
                  // TextFieldWidget("Enter your password"),
                  TextFieldWidget(
                    textFieldHint: "Enter your password", 
                    textFieldError: "Password cannot be empty", 
                    controller: _passwordController, 
                    validate: _passwordValidate
                  ),
                  SizedBox(height: height / height / 0.03,),
                  RoundedButtonWidget(
                    buttonText: "Sign Up", 
                    width: 350, 
                    onpressed: () {
                      setState(() {
                        _nameController.text.isEmpty ? _nameValidate = true : _nameValidate = false;
                        _emailController.text.isEmpty ? _emailValidate = true : _emailValidate = false;
                        _passwordController.text.isEmpty ? _passwordValidate = true : _passwordValidate = false;

                      });
                      if(_emailValidate == false && _nameValidate == false && _passwordValidate == false){
                        if(!emailRegulator.hasMatch(_emailController.text) && _emailController.text.isNotEmpty)
                        {
                          setState(() {
                            _emailRegExValidate = true;
                            _emailValidate = false;
                          });
                        }
                        else if(emailRegulator.hasMatch(_emailController.text) && _emailController.text.isNotEmpty)
                        {
                          setState(() {
                            _emailRegExValidate = false;
                            _emailValidate = false;
                          });
                        }
                        else
                        {
                          Navigator.pushNamed(context, MyRoutes.landingRoute);
                        }
                      }
                      
                    }
                  ),
                  SizedBox(height: height / height / 0.0094,),
                  FooterContainerWidget(containerText: "Login", screenHeight: height, screenWidth: width, onPressed: () => Navigator.pushNamed(context, MyRoutes.landingRoute),)
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}