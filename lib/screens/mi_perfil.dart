import 'dart:io';

import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/providers/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool firstEnabled = false;
  bool emailEnabled = false;
  XFile? photo;
  String old_name = '';
  String email = '';
  String name = '';
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    old_name = Globals.user?.nombre ?? '';
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          Container(
            color: brand_colors.BLUE_PRESIDENCIAL,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        ///TODO me quede implementando esto

                        var user = await HelperMethods.updateProfile(
                            Globals.user?.id ?? 0,
                            name,
                            old_name,
                            email,
                            photo);
                        if (user != null) {
                          Navigator.pop(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('ERROR'),
                                    content: Text(
                                        'hubo un error actualizando tu perfil'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text('Ok'))
                                    ],
                                  ));
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Selecione Foto'),
                                  content: const Text(
                                      'Seleccione una foto de perfil para continuar.'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.photo_camera),
                                            FlatButton(
                                              child: Text('Camara'),
                                              onPressed: () async {
                                                photo = await picker.pickImage(
                                                    source: ImageSource.camera);
                                                if (photo != null) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.photo_library),
                                            FlatButton(
                                              child: Text('Galeria'),
                                              onPressed: () async {
                                                photo = await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                                if (photo != null) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            },
                            child: Stack(children: [
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: brand_colors.BLUE_PRESIDENCIAL,
                                  ),
                                ),
                              )
                            ]),
                          ),
                          Text(
                            Globals.user!.nombre ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(children: [
              ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    style: TextStyle(
                        color: brand_colors.BLUE_PRESIDENCIAL,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabled: firstEnabled,
                    decoration: InputDecoration(
                      hintText: 'Escriba su Nombre',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    initialValue: Globals.user?.nombre,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: brand_colors.BLUE_PRESIDENCIAL,
                  ),
                  onPressed: () {
                    if (firstEnabled == false) {
                      setState(() {
                        firstEnabled = true;
                      });
                    } else {
                      setState(() {
                        firstEnabled = false;
                      });
                    }
                  },
                ),
                subtitle: Text(
                  'Nombre',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    style: TextStyle(
                        color: brand_colors.BLUE_PRESIDENCIAL,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabled: emailEnabled,
                    decoration: InputDecoration(
                      hintText: 'Escriba su Correo',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    initialValue: Globals.user?.phone,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: brand_colors.BLUE_PRESIDENCIAL,
                  ),
                  onPressed: () {
                    if (emailEnabled == false) {
                      setState(() {
                        emailEnabled = true;
                      });
                    } else {
                      setState(() {
                        emailEnabled = false;
                      });
                    }
                  },
                ),
                subtitle: Text(
                  'Correo',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          photo?.path != null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(File(photo?.path ?? '')),
                    ),
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
