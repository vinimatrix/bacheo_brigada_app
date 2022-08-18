import 'dart:convert';

import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/screens/gretings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/card_picture.dart';
import '../widgets/orange_button.dart';

class ConfirmacionScreen extends StatelessWidget {
  const ConfirmacionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    AppStateProvider appProvider = Provider.of<AppStateProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          color: brand_colors.BLUE_PRESIDENCIAL,
          height: screen.height * 0.25,
          child: const Align(
            alignment: Alignment.center,
            child: Text('Confirmación',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Form(
            child: Column(
          children: [
            Container(
                width: screen.width * 0.8,
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      maxLines: 3,
                      keyboardType: TextInputType.streetAddress,
                      initialValue: appProvider.brigada_feedback,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: brand_colors.BLUE_PRESIDENCIAL,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Calle 14 #64, Ensanche \nel Sol...',
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey.shade800),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                width: screen.width * 0.8,
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 3,
                      enabled: false,
                      initialValue: appProvider.status,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: brand_colors.BLUE_PRESIDENCIAL,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Fente a la Farmacia...',
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey.shade800),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        )),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: appProvider.paths
                  .map((String path) => CardPicture(
                        imagePath: path,
                      ))
                  .toList()),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  width: MediaQuery.of(context).size.width * 0.5 - 10,
                  height: 52,
                  child: OrangeButton(
                    text: 'Anterior',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  width: MediaQuery.of(context).size.width * 0.5 - 10,
                  height: 52,
                  child: OrangeButton(
                    text: 'Enviar',
                    onPressed: () {
                      appProvider.sendMessage(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
