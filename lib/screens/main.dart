import 'dart:io';
import 'dart:typed_data';

import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/helpers/helper_methods.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/screens/mis_reportes.dart';
import 'package:bacheo_brigada/widgets/orange_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../models/reporte.dart';
import '../models/user.dart';
import '../providers/globals.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainState();
}

class _MainState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Reporte> reportes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appProvider = Provider.of<AppStateProvider>(context);
    if (Globals.user != null) {
      HelperMethods.getUserReportes(Globals.user!.id ?? 0).then((value) => {
            appProvider.reportes = value,
          });
    }
    //print(user);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Bacheo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: brand_colors.BLUE_PRESIDENCIAL,
                ),
              ),
              ListTile(
                title: Text('Mi perfil'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              /* ListTile(
                title: Text('Mis reportes'),
                onTap: () {
                  if (reportes.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MisReportes(reportes: reportes);
                    }));
                  }
                },
              ), */
              ListTile(
                title: Text('Salir'),
                onTap: () {
                  appProvider.logout(context);
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: brand_colors.BLUE_PRESIDENCIAL,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Bacheo - v1.0.0\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'MOPC - 2022',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ])),
                        ),
                      )))
            ],
          ),
        ),
        body: Column(children: [
          Container(
            color: brand_colors.BLUE_PRESIDENCIAL,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _scaffoldKey.currentState!.openDrawer();
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
            width: MediaQuery.of(context).size.width * 0.7 - 10,
            height: 52,
            margin: EdgeInsets.only(top: 20),
            child: OrangeButton(
              onPressed: () async {
                if (appProvider.reportes.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MisReportes(reportes: appProvider.reportes);
                  }));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text('No tienes reportes'),
                            content: Text(
                                'Para ver la lista de reportes debes tener al menos un reporte asignado'),
                            actions: [
                              FlatButton(
                                child: Text('Aceptar'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ));
                }
              },
              text: 'Ver Reportes',
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ///Text("${appProvider.lat} ${appProvider.lng}"),
          appProvider.reportes.length == 0
              ? Column(children: [
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CircularProgressIndicator()),
                  Text('Cargando reportes...')
                ])
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: showChart(context, appProvider.reportes),
                  ),
                )
        ]),
      ),
    );
  }

  Widget showChart(context, List<Reporte> reportes) {
    double noIniciado =
        reportes.where((o) => o.status == "No Iniciado").toList().length * 1.0;
    double enProceso =
        reportes.where((o) => o.status == "iniciado").toList().length * 1.0;
    double terminado =
        reportes.where((o) => o.status == "terminado").toList().length * 1.0;
    double asignado =
        reportes.where((o) => o.status == "Asignado").toList().length * 1.0;
    double total = reportes.length * 1.0;
    List<Color> colors = [];
    colors.add(Colors.red);
    colors.add(Colors.green);
    colors.add(Colors.blue);
    colors.add(Colors.yellow);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
      child: PieChart(
        chartType: ChartType.ring,
        ringStrokeWidth: 30,
        dataMap: {
          'No iniciado': noIniciado,
          'Iniciado': enProceso,
          'Terminado': terminado,
          'Asignado': asignado
        },
        colorList: colors,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery.of(context).size.width / 2.7,
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
      ),
    );
  }
}
