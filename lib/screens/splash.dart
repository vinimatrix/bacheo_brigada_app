import 'package:bacheo_brigada/constants/colors.dart';

import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/widgets/orange_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../providers/globals.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.4,
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /* Text(
                    'Bacheo',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ), */
                  Container(
                    child: Image.asset(
                      'assets/images/logo_bacheo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'BRIGADAS',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: brand_colors.BLUE_PRESIDENCIAL,
                    ),
                  ),
                  /*  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          brand_colors.BLUE_PRESIDENCIAL),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      'Bacheo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ), */
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7 - 10,
                      height: 52,
                      margin: EdgeInsets.only(top: 20),
                      child: OrangeButton(
                        onPressed: () {
                          HelperMethods.getUser().then((user) {
                            if (user != null) {
                              Globals.user = user;
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          });
                          /*Globals.user == null
                              ? Navigator.pushReplacementNamed(
                                  context, '/login')
                              : Navigator.pushReplacementNamed(
                                  context, '/main');*/
                        },
                        text: 'Ingresar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
