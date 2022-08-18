import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/models/reporte.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/screens/reporte.dart';
import 'package:bacheo_brigada/widgets/showBaloon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../widgets/orange_button.dart';

class VerReporte extends StatelessWidget {
  const VerReporte({Key? key, required this.reporte}) : super(key: key);
  final Reporte reporte;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    print(reporte.lat);
    print(reporte.lng);
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Container(
          color: brand_colors.BLUE_PRESIDENCIAL,
          height: screen.height * 0.15,
          child: Align(
            alignment: Alignment.center,
            child: Text("Reporte # ${reporte.id.toString().padLeft(8, '0')}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text(reporte.direccion ?? 'no  hay datos'),
                subtitle: Text('Dirección'),
              ),
              Divider(),
              ListTile(
                subtitle: Text('Referencia'),
                title: Text(reporte.referencia ?? 'no  hay datos'),
              ),
              Divider(),
              ListTile(
                subtitle: Text('Estado'),
                title: Text(reporte.status ?? 'no  hay datos'),
                trailing: ShowBallon(
                  status: reporte.status ?? 'No Iniciado',
                ),
              ),
              Divider(),
              Card(
                child: Container(
                  height: screen.height * 0.35,
                  child: FlutterMap(
                    mapController: appStateProvider.mapController,
                    options: MapOptions(
                      boundsOptions: FitBoundsOptions(
                        maxZoom: 20,
                      ),
                      crs: Epsg3857(),
                      center: LatLng(reporte.lat ?? 0.0, reporte.lng ?? 0.0),
                      zoom: 18,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',
                          subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                          maxZoom: 20),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point:
                                LatLng(reporte.lat ?? 0.0, reporte.lng ?? 0.0),
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_on,
                                color: brand_colors.ORANGE_MOPC,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.5 - 10,
                    height: 52,
                    child: OrangeButton(
                      text: 'Dar Respuesta',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReporteScreen(reporte: reporte)));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    ));
  }
}
