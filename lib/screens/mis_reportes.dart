import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/models/reporte.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/screens/ver_reporte.dart';
import 'package:bacheo_brigada/widgets/showBaloon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MisReportes extends StatelessWidget {
  const MisReportes({Key? key, required this.reportes}) : super(key: key);
  final List<Reporte> reportes;
  @override
  Widget build(BuildContext context) {
    AppStateProvider appProvider = Provider.of<AppStateProvider>(context);

    Size screen = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Container(
          color: brand_colors.ORANGE_MOPC,
          height: screen.height * 0.25,
          child: const Align(
            alignment: Alignment.center,
            child: Text('Mis Reportes',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: reportes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => reportes[index].status == "terminado"
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Este reporte esta finalizado!"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Ok'))
                              ],
                            ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VerReporte(reporte: reportes[index]))),
                child: ListTile(
                  title: Text(reportes[index].id.toString().padLeft(8, '0')),
                  subtitle: Text(
                    reportes[index].direccion ?? 'no  hay datos',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: ShowBallon(
                    status: reportes[index].status ?? 'No Iniciado',
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ),
      ]),
    ));
  }
}
