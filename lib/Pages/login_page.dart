import 'package:flutter/material.dart';
import 'get_id.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // P5 Red Color
    const Color p5Red = Color(0xFFCE3333);

    return Scaffold(
      backgroundColor: p5Red,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'assets/logov1.png',
                    height: 250, // Adjust based on screen size
                    fit: BoxFit.contain,
                  ),
                ),

                // "Enter Your ID" Text
                Transform.rotate(
                  angle: -0.05, // Slight skew for style
                  child: const Text(
                    "Enter Your ID",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontFamily: 'Roboto', // Fallback
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

                // Text Input Field
                // Using a Stack to place the TextField over the asset
                SizedBox(
                  width: 350,
                  height: 100, // Approximate height of the asset
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Image
                      Image.asset(
                        'assets/Textbox.png',
                        width: 350,
                        fit: BoxFit.contain,
                      ),
                      // TextField
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Transform.rotate(
                          angle: -0.05, // Match asset skew if any
                          child: TextField(
                            controller: _idController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter here...",
                              hintStyle: TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // "Don't have one? Tap Here"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have one? ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                offset: Offset(1, 1),
                                color: Colors.black,
                                blurRadius: 0)
                          ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetIDPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Tap Here",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            shadows: [
                              Shadow(
                                  offset: Offset(1, 1),
                                  color: Colors.black,
                                  blurRadius: 0)
                            ]),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Enter Button
                GestureDetector(
                  onTap: () {
                    final id = _idController.text.trim();
                    if (id.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "ID is Empty!",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Login Logic
                      debugPrint("Enter button pressed with ID: $id");
                    }
                  },
                  child: Image.asset(
                    'assets/Enter_Button.png',
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
