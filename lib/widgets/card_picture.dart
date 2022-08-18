import 'dart:io';
import 'package:flutter/material.dart';

class CardPicture extends StatelessWidget {
  CardPicture({Key? key, this.onTap, this.imagePath}) : super(key: key);

  final Function()? onTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(10.0),
        width: size.width * .50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          image: DecorationImage(
              fit: BoxFit.cover, image: FileImage(File(imagePath as String))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 2.0,
                    )
                  ]),
              child: IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.delete, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
