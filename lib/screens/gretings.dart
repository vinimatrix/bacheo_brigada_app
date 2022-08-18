import 'package:bacheo_brigada/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/orange_button.dart';

class GrettingsScreen extends StatelessWidget {
  const GrettingsScreen({Key? key, this.id = 0}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset('assets/images/logo_bacheo.png'),
              ),
              Container(
                child: Text(
                  '¡Gracias por tu Trabajo!',
                  style: TextStyle(
                      color: brand_colors.BLUE_PRESIDENCIAL,
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  'el Informe ha sido enviado y \nregistrado \ncorrectamente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: brand_colors.BLUE_PRESIDENCIAL,
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400),
                ),
              ),
              /*   Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  'N de reporte:',
                  style: TextStyle(
                      color: brand_colors.BLUE_PRESIDENCIAL,
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Text(id.toString().padLeft(8, '0'),
                    style: TextStyle(
                        color: brand_colors.ORANGE_MOPC,
                        fontSize: 26,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600)),
              ),*/
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    width: MediaQuery.of(context).size.width * 0.5 - 10,
                    height: 52,
                    child: OrangeButton(
                      text: 'Volver al inicio',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
