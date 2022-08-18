import 'dart:convert';

import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/providers/auth_provider.dart';
import 'package:bacheo_brigada/providers/globals.dart';
import 'package:bacheo_brigada/services/http_service.dart';
import 'package:bacheo_brigada/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/orange_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final HttpSerrvice service = HttpSerrvice();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: brand_colors.BLUE_PRESIDENCIAL,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Datos de la Brigada',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Column(children: [
                      Text('Codigo',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: brand_colors.BLUE_PRESIDENCIAL)),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: userController,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: brand_colors.BLUE_PRESIDENCIAL,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: '0000909',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey.shade800),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (String? value) {
                          RegExp regex = RegExp(r'^[0-9]{3,8}$');
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su Codigo de brigada';
                          } /* else if (!regex.hasMatch(value)) {
                            return 'Ingrese un Código válido';
                          } */
                          else {
                            return null;
                          }
                        },
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Column(children: [
                      Text('Password',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: brand_colors.BLUE_PRESIDENCIAL)),
                      /* TextFormField(
                        controller: userController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: brand_colors.BLUE_PRESIDENCIAL,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: '8095555555',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey.shade800),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (String? value) {
                          RegExp regex = RegExp(r'^8[024]9[0-9]{7}$');
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su teléfono';
                          } else if (!regex.hasMatch(value)) {
                            return 'Ingrese un teléfono válido';
                          } else {
                            return null;
                          }
                        },
                      ), */
                      PasswordField(
                        controller: passwordController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su password';
                          } else {
                            return null;
                          }
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*   Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Column(children: [
                      Text('Correo',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: brand_colors.BLUE_PRESIDENCIAL)),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: brand_colors.BLUE_PRESIDENCIAL,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'juanperez@gmail.com',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey.shade800),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        /*  validator: (String? value) {
                          RegExp regex = RegExp(
                              r'^[A-Za-z]{3,}@[A-Za-z0-9]{3,}\.[A-Za-z0-9].*$');
                          if (value!.isNotEmpty && !regex.hasMatch(value)) {
                            return 'Ingrese un correo válido';
                          } else {
                            return null;
                          }
                        }, */
                      ),
                    ]),
                  ),
                   */
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        width: MediaQuery.of(context).size.width * 0.5 - 10,
                        height: 52,
                        child: OrangeButton(
                          text: 'Ingresar',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login(context, userController.text,
                                  passwordController.text);
                            }
                            {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  login(context, user, password) {
    //print(user);
    //rprint(password);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: AlertDialog(
              content: Container(
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      'iniciando sesión...',
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    service.login(user, password).then((user) {
      if (user.body.isNotEmpty) {
        print(user.body);

        User juser = User.fromJson(jsonDecode(user.body));
        Globals.user = juser;
        HelperMethods.saveUser(juser);
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Usuario o contraseña incorrectos'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
  }
}
