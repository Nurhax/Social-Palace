import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../Data/data_manager.dart';

class GetIDPage extends StatefulWidget {
  const GetIDPage({super.key});

  @override
  State<GetIDPage> createState() => _GetIDPageState();
}

class _GetIDPageState extends State<GetIDPage> {
  late String generatedID;

  @override
  void initState() {
    super.initState();
    generatedID = _generateRandomID();
  }

  String _generateRandomID() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Future<void> _copyToClipboard() async {
    Clipboard.setData(ClipboardData(text: generatedID));

    // Save generated ID to data.json
    await DataManager().saveId(generatedID);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("ID copied to clipboard and saved!"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color p5Red = Color(0xFFCE3333);

    return Scaffold(
      backgroundColor: p5Red,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                  'assets/logov1.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),

              // "Your ID" Text
              Transform.rotate(
                angle: -0.05,
                child: const Text(
                  "Your ID",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ID Display using Textbox.png
              SizedBox(
                width: 350,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/Textbox.png',
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                    Transform.rotate(
                      angle: -0.05,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          generatedID,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // "Copy to clipboard"
              GestureDetector(
                onTap: _copyToClipboard,
                child: Transform.rotate(
                  angle: -0.02,
                  child: const Text(
                    "Copy to clipboard",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 0,
                            color: Colors.black,
                          ),
                        ]),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // DONE Button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/Done_Button.png',
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
