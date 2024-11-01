import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool sayiyor = false;
  int gecenSaniye = 0;
  String olculenSure(int saniye) {
    int saat = saniye ~/ 3600;
    int dakika = saniye ~/ 60 - (saat * 60);
    int kalanSaniye = saniye % 60;
    return "${saat.toString().padLeft(2, "0")} : ${dakika.toString().padLeft(2, "0")} : ${kalanSaniye.toString().padLeft(2, "0")}";
  }

  void kronometre() async {
    while (sayiyor) {
      await Future.delayed(const Duration(seconds: 1));

      if (sayiyor) {
        setState(() {
          gecenSaniye += 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          cupertinoOverrideTheme:
              const CupertinoThemeData(primaryColor: Colors.black)),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                olculenSure(gecenSaniye),
                style: const TextStyle(color: Colors.teal, fontSize: 48),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                    child: const Text("Sıfırla"),
                    onPressed: () {
                      setState(() {
                        sayiyor = false;
                        gecenSaniye = 0;
                      });
                    }),
                CupertinoButton(
                    child: const Text("Durdur"),
                    onPressed: () {
                      setState(() {
                        sayiyor = false;
                      });
                    }),
                CupertinoButton(
                    child: const Text("Başla"),
                    onPressed: () {
                      if (!sayiyor) {
                        setState(() {
                          sayiyor = true;
                        });
                        kronometre();
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
