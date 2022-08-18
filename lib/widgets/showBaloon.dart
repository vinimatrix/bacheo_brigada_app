import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowBallon extends StatelessWidget {
  const ShowBallon({Key? key, required this.status}) : super(key: key);
  final String status;
  @override
  Widget build(BuildContext context) {
    return showBallon(status);
  }

  showBallon(String status) {
    Color color = Colors.red;

    if (status == 'iniciado') {
      color = Colors.green;
    }
    if (status == 'terminado') {
      color = Colors.blue;
    }
    if (status == 'Asignado') {
      color = Colors.yellow;
    }

    return CircleAvatar(
      backgroundColor: color,
      radius: 10,
    );
  }
}
