import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/assets.dart';
import 'package:tt9_betweener_challenge/views/home_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../../views/widgets/google_button_widget.dart';
import '../Helpers/snak_bar.dart';
import '../controllers/register_controller.dart';
import '../models/user.dart';
import 'loading_view.dart';

class RegisterView extends StatefulWidget {
  static String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with ShowSnackBar {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Hero(
                          tag: 'authImage',
                          child: SvgPicture.asset(AssetsData.authImage))),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    hint: 'John Doe',
                    label: 'Name',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hint: 'example@gmail.com',
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    hint: 'Enter password',
                    label: 'password',
                    password: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SecondaryButtonWidget(
                      onTap: () {
                        _performRegister();
                      },
                      text: 'REGISTER'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GoogleButtonWidget(onTap: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _performRegister() {
    if (_validateData()) {
      _Register();
    }
  }

  bool _validateData() {
    if (nameController.text.isEmpty) {
      showSnackBar(context, text: 'Please, Enter the text', isError: true);
      return false;
    } else if (emailController.text.isEmpty) {
      showSnackBar(context,
          isError: true, text: "Input Your Email Address please!");
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showSnackBar(context,
          isError: true, text: "Input availed Email Address please!");
      return false;
    } else if (passwordController.text.isEmpty) {
      showSnackBar(context, text: "Input Your Password please!", isError: true);

      return false;
    } else if (!RegExp("(?=.*?[0-9])(?=.*?[A-Za-z])(?=.*[^0-9A-Za-z]).+")
        .hasMatch(passwordController.text)) {
      showSnackBar(context,
          text:
              "Password must contain at least one character (a-z)/(A-Z) or digit!",
          isError: true);
      return false;
    }
    return true;
  }

  _Register() {
    ///

    final body = {
      "name": nameController.text,
      "email": emailController.text,
      "password_confirmation": passwordController.text,
      "password": passwordController.text
    };
    register(body: body).then((value) async {
      print("ooooo");
      showSnackBar(context, text: "Registered successfully");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', userToJson(value));
      if (mounted) {
        Navigator.pushNamed(context, LoadingView.id);
      }
    }).catchError((err) {
      showSnackBar(context, text: "registered account", isError: true);
    });
  }
}
