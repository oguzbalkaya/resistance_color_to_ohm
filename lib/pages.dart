import "package:flutter/material.dart";
import 'package:resistance_color_to_ohm/Models/resistance.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int colorCount = 4;
  static double ohm = 0;
  static Units unit = units[3];
  int secilenMenuItem = 0;

  String text = "";

  static List<MyColor> colorList = [
    MyColor(0, Colors.black),
    MyColor(1, Colors.brown),
    MyColor(2, Colors.redAccent),
    MyColor(3, Colors.deepOrange),
    MyColor(4, Colors.yellow),
    MyColor(5, Colors.green),
    MyColor(6, Colors.blue),
    MyColor(7, Colors.purple),
    MyColor(8, Colors.grey),
    MyColor(9, Colors.white)
  ];

  static List<MyColor> toleranceColorList = [
    MyColor(1, Colors.brown),
    MyColor(2, Colors.redAccent),
    MyColor(3, Colors.deepOrange),
    MyColor(4, Colors.yellow),
    MyColor(0.5, Colors.green),
    MyColor(0.25, Colors.blue),
    MyColor(0.1, Colors.purple),
    MyColor(0.05, Colors.grey),
    MyColor(5, Colors.amber),
    MyColor(10, Colors.blueGrey)
  ];

  static List<MyColor> multiplierColorList = [
    MyColor(1, Colors.black),
    MyColor(10, Colors.brown),
    MyColor(100, Colors.redAccent),
    MyColor(1000, Colors.deepOrange),
    MyColor(10000, Colors.yellow),
    MyColor(100000, Colors.green),
    MyColor(1000000, Colors.blue),
    MyColor(10000000, Colors.purple),
    MyColor(100000000, Colors.grey),
    MyColor(1000000000, Colors.white),
    MyColor(0.1, Colors.amber),
    MyColor(0.01, Colors.blueGrey),
  ];

  static List<MyColor> temperatureColorList = [
    MyColor(100, Colors.brown),
    MyColor(50, Colors.redAccent),
    MyColor(15, Colors.deepOrange),
    MyColor(25, Colors.yellow),
    MyColor(10, Colors.blue),
    MyColor(5, Colors.purple),
  ];

  static List<Units> units = [
    Units("nΩ", 1000000000),
    Units("µΩ", 1000000),
    Units("mΩ", 1000),
    Units("Ω", 1),
    Units("kΩ", 0.001),
    Units("MΩ", 0.000001),
    Units("GΩ", 0.000000001)
  ];

  static MyColor color1 = colorList[1],
      color2 = colorList[0],
      color3 = colorList[0],
      multiplier = multiplierColorList[0],
      tolerance = toleranceColorList[0],
      temperature = temperatureColorList[0];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("Direnç Hesapla"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showOhm(),
          Padding(
            padding: EdgeInsets.all(10),
            child: showColors(),
          ),
          Expanded(
              child: ListView(
            children: [
              selectColorCount(),
              selectColor(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectUnit(),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        debugPrint("tıklandı");
                        String unitSymbol;

                        setState(() {
                          calculateOhm();
                          String temp = colorCount == 6
                              ? "\nSıcaklık katsayısı : ${temperature.value}"
                              : "";
                          text =
                              "Direnç değeri : ${ohm.toString()} ${unit.name}\n" +
                                  "Tolerans : ± %${tolerance.value}" +
                                  "$temp";
                        });
                      }
                    },
                    color: Colors.cyan,
                    child: Text(
                      "Hesapla",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  //// Functions
  selectUnit() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: DropdownButton<Units>(
          hint: Text("Birim seçin"),
          value: unit,
          items: [
            DropdownMenuItem(
              child: Text("Nanoohm (nΩ)"),
              value: units[0],
            ),
            DropdownMenuItem(
              child: Text("Mikroohm (µΩ)"),
              value: units[1],
            ),
            DropdownMenuItem(
              child: Text("Miliohm (mΩ)"),
              value: units[2],
            ),
            DropdownMenuItem(
              child: Text("Ohm (Ω)"),
              value: units[3],
            ),
            DropdownMenuItem(
              child: Text("Kiloohm (kΩ)"),
              value: units[4],
            ),
            DropdownMenuItem(
              child: Text("Megaohm (MΩ)"),
              value: units[5],
            ),
            DropdownMenuItem(
              child: Text("Gigaohm (GΩ)"),
              value: units[6],
            ),
          ],
          onChanged: (selected) {
            setState(() {
              unit = selected;
            });
          }),
    );
  }

  toleranceList() {
    return DropdownButton(
        value: tolerance,
        items: [
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %1 Kahverengi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[0],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %2 Kırmızı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[1],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %3 Turuncu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[2],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %4 Sarı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[3],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %0.5 Yeşil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[4],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %0.25 Mavi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[5],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %0.10 Mor",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[6],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %0.05 Grey",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: toleranceColorList[7],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %5 Altın",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: toleranceColorList[8],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "± %10 Gümüş",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: toleranceColorList[9],
          ),
        ],
        onChanged: (selectedColor) {
          setState(() {
            tolerance = selectedColor;
          });
        });
  }

  color1List() {
    return DropdownButton(
        value: color1,
        items: [
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1 Kahverengi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[1],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "2 Kırmızı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[2],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "3 Turuncu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[3],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "4 Sarı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[4],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "5 Yeşil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[5],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "6 Mavi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[6],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "7 Mor",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[7],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "8 Gray",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[8],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "9 Beyaz",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: colorList[9],
          ),
        ],
        onChanged: (selectedColor) {
          setState(() {
            color1 = selectedColor;
          });
        });
  }

  color2List() {
    return DropdownButton(
        value: color2,
        items: [
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "0 Siyah",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[0],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1 Kahverengi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[1],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "2 Kırmızı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[2],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "3 Turuncu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[3],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "4 Sarı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[4],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "5 Yeşil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[5],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "6 Mavi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[6],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "7 Mor",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[7],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "8 Grey",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[8],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "9 Beyaz",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: colorList[9],
          ),
        ],
        onChanged: (selectedColor) {
          setState(() {
            color2 = selectedColor;
          });
        });
  }

  color3List() {
    return DropdownButton(
        value: color3,
        items: [
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "0 Siyah",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[0],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1 Kahverengi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[1],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "2 Kırmızı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[2],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "3 Turuncu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[3],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "4 Sarı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[4],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "5 Yeşil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[5],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "6 Mavi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[6],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "7 Mor",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[7],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "8 Gray",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: colorList[8],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "9 Beyaz",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: colorList[9],
          ),
        ],
        onChanged: (selectedColor) {
          setState(() {
            color3 = selectedColor;
          });
        });
  }

  multiplierList() {
    return DropdownButton(
        value: multiplier,
        items: [
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1 Siyah",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[0],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "10 Kahverengi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[1],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "100 Kırmızı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[2],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1000 Turuncu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[3],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "10K Sarı",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[4],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "100K Yeşil",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[5],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1M Mavi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[6],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "10M Mor",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[7],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "100M Gri",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            value: multiplierColorList[8],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "1G Beyaz",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: multiplierColorList[9],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "0.10 Altın",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: multiplierColorList[10],
          ),
          DropdownMenuItem(
            child: Container(
              width: 150,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "0.01 Gümüş",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            value: multiplierColorList[11],
          )
        ],
        onChanged: (selectedColor) {
          setState(() {
            multiplier = selectedColor;
          });
        });
  }

  showColors() {
    if (colorCount == 4) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 20,
              height: 50,
              color: color1.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: color2.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: multiplier.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: tolerance.color,
            ),
          ],
        ),
      );
    } else if (colorCount == 5) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 20,
              height: 50,
              color: color1.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: color2.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: color3.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: multiplier.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: tolerance.color,
            ),
          ],
        ),
      );
    } else if (colorCount == 6) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 20,
              height: 50,
              color: color1.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: color2.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: color3.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: multiplier.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: tolerance.color,
            ),
            Container(
              width: 20,
              height: 50,
              color: temperature.color,
            ),
          ],
        ),
      );
    }
  }

  selectColorCount() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: DropdownButton<int>(
          hint: Text("Direncin bant sayısını seçin"),
          value: colorCount,
          items: [
            DropdownMenuItem(
              child: Text("4 Bantlı Direnç"),
              value: 4,
            ),
            DropdownMenuItem(
              child: Text("5 Bantlı Direnç"),
              value: 5,
            ),
            DropdownMenuItem(
              child: Text("6 Bantlı Direnç"),
              value: 6,
            ),
          ],
          onChanged: (selected) {
            setState(() {
              colorCount = selected;
            });
          }),
    );
  }

  selectColor() {
    if (colorCount == 4) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Text("Birinci renk : 1. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color1List(),
            Text("İkinci renk : 2. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color2List(),
            Text("Üçüncü renk : çarpan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            multiplierList(),
            Text("Dördüncü renk : tolerans",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            toleranceList(),
          ],
        ),
      );
    } else if (colorCount == 5) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Text("Birinci renk : 1. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color1List(),
            Text("İkinci renk : 2. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color2List(),
            Text("Üçüncü renk : 3. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color3List(),
            Text("Dördüncü renk : çarpan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            multiplierList(),
            Text("Beşinci renk : tolerans",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            toleranceList(),
          ],
        ),
      );
    } else if (colorCount == 6) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Text("Birinci renk : 1. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color1List(),
            Text("İkinci renk : 2. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color2List(),
            Text("Üçüncü renk : 3. basamak",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            color3List(),
            Text("Dördüncü renk : çarpan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            multiplierList(),
            Text("Beşinci renk : tolerans",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            toleranceList(),
            Text("Altıncı renk : sıcaklık katsayısı",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            DropdownButton(
                value: temperatureColorList[0],
                items: [
                  DropdownMenuItem(
                    child: Container(
                      width: 150,
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "100 Kahverengi",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    value: temperatureColorList[0],
                  ),
                  DropdownMenuItem(
                    child: Container(
                      width: 150,
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "50 Kırmızı",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    value: temperatureColorList[1],
                  ),
                  DropdownMenuItem(
                    child: Container(
                      width: 150,
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "15 Turuncu",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    value: temperatureColorList[2],
                  ),
                  DropdownMenuItem(
                      child: Container(
                        width: 150,
                        height: 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "25 Sarı",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      value: temperatureColorList[3]),
                  DropdownMenuItem(
                    child: Container(
                      width: 150,
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "10 Mavi",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    value: temperatureColorList[4],
                  ),
                  DropdownMenuItem(
                    child: Container(
                      width: 150,
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "5 Mor",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    value: temperatureColorList[5],
                  ),
                ],
                onChanged: (selectedColor) {
                  setState(() {
                    temperature = selectedColor;
                  });
                }),
          ],
        ),
      );
    }
  }

  showOhm() {
    if (text != "") {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.cyan.shade50),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Text("");
    }
  }

  calculateOhm() {
    if (colorCount == 4) {
      ohm =
          ((color1.value * 10 + color2.value) * multiplier.value) * unit.value;
    } else if (colorCount == 5 || colorCount == 6) {
      ohm = ((color1.value * 100 + color2.value * 10 + color3.value) *
              multiplier.value) *
          unit.value;
    }
  }
////
}
