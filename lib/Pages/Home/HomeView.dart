import 'package:flutter/material.dart';
import 'HomeController.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Conversor",
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.amber[300],
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: controller.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando",
                  style: TextStyle(
                    color: Colors.amber[300],
                    fontSize: 30.0,
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar",
                    style: TextStyle(
                      color: Colors.amber[100],
                      fontSize: 30.0,
                    ),
                  ),
                );
              } else {
                controller.dollar = snapshot.data['USD']['buy'];
                controller.euro = snapshot.data['EUR']['buy'];

                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  behavior: HitTestBehavior.translucent,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber[300],
                        ),
                        buildTextField(
                          "Real",
                          "R\$",
                          controller.realController,
                          controller.realChange,
                        ),
                        Divider(),
                        DropdownButton(
                          value: controller.dropdownValue,
                           items: controller.currencies
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                           onChanged: (String value){
                             setState(() {
                               controller.dropdownValue = value;
                               switch (value) {
                                 case "dolar":
                                   controller.changeCurriency = controller.dollar;
                                   controller.symbol = "\$";
                                   break;
                                  case "euro":
                                    controller.changeCurriency = controller.euro;
                                    controller.symbol = "€";
                                    break;
                                 default:
                               }
                              controller.changeReal();
                               
                             });
                           },
                        ),
                        Divider(),
                        buildTextField(
                          controller.dropdownValue,
                          controller.symbol,
                          controller.dropdownController,
                          controller.changeSelector,
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(
  String label,
  String prefix,
  TextEditingController controller,
  Function foo,
) {
  return TextField(
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber[300]),
      border: OutlineInputBorder(),
      prefixText: prefix,
      prefixStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.amber[300],
      ),
    ),
    style: TextStyle(
      color: Colors.amber[300],
      fontSize: 25.0,
    ),
    controller: controller,
    onChanged: foo,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}