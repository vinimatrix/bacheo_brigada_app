import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/widgets/card_picture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../widgets/orange_button.dart';
import '../widgets/take_photo.dart';

class FotosScreen extends StatefulWidget {
  const FotosScreen({Key? key}) : super(key: key);

  @override
  State<FotosScreen> createState() => _FotosScreenState();
}

class _FotosScreenState extends State<FotosScreen> {
  late CameraDescription _cameraDescription;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      final camera = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.back)
          .toList()
          .first;
      setState(() {
        _cameraDescription = camera;
        print(camera);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appProvider = Provider.of<AppStateProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        InkWell(
          onTap: () async {
            final String? imagePath =
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TakePhoto(
                          camera: _cameraDescription,
                        )));

            print('imagepath: $imagePath');
            if (imagePath != null) {
              setState(() {
                appProvider.paths.add(imagePath);
              });
            }
          },
          child: Container(
            color: brand_colors.ORANGE_MOPC,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: brand_colors.ORANGE_MOPC,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('AGREGAR EVIDENCIAS ...',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: appProvider.paths
                  .map((String path) => CardPicture(
                        onTap: () => {
                          setState(() {
                            appProvider.paths.remove(path);
                          })
                        },
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
                      setState(() {
                        appProvider.paths.clear();
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  width: MediaQuery.of(context).size.width * 0.5 - 10,
                  height: 52,
                  child: OrangeButton(
                    text: 'Siguiente',
                    onPressed: () {
                      if (true) {
                        Navigator.of(context).pushNamed('/confirmacion');
                      }
                      {
                        return null;
                      }
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
