import 'package:bacheo_brigada/constants/colors.dart';
import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/reporte.dart';
import '../widgets/orange_button.dart';

class ReporteScreen extends StatefulWidget {
  const ReporteScreen({Key? key, required this.reporte}) : super(key: key);
  final Reporte reporte;

  @override
  State<ReporteScreen> createState() => _ReporteScreenState();
}

class _ReporteScreenState extends State<ReporteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController referenciaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    AppStateProvider appProvider = Provider.of<AppStateProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          color: brand_colors.ORANGE_MOPC,
          height: screen.height * 0.25,
          child: const Align(
            alignment: Alignment.center,
            child: Text('Respuesta del Bacheo',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    width: screen.width * 0.8,
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Comentarios',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: brand_colors.BLUE_PRESIDENCIAL)),
                        ),
                        TextFormField(
                          maxLines: 4,
                          keyboardType: TextInputType.streetAddress,
                          controller: direccionController,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: brand_colors.BLUE_PRESIDENCIAL,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'comentarios...',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey.shade800),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) =>
                              {appProvider.brigada_feedback = value},
                        ),
                      ],
                    )),
                Container(
                    width: screen.width * 0.8,
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Status',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: brand_colors.BLUE_PRESIDENCIAL)),
                        ),
                        DropdownButtonFormField(
                          isExpanded: true,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: brand_colors.BLUE_PRESIDENCIAL,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'Selecione estado...',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey.shade800),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: <String>[
                            'iniciado',
                            'terminado',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                children: [
                                  Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            appProvider.status = value!;
                          },
                        ),
                      ],
                    ))
              ],
            )),
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
                        appProvider.brigada_feedback = "";
                        appProvider.status = "";
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
                      if (_formKey.currentState!.validate()) {
                        appProvider.reporteId = widget.reporte.id!;
                        appProvider.reporte = widget.reporte;
                        Navigator.of(context).pushNamed('/reporte_2');
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
