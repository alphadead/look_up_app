// Home page screen

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up_app/login_screen.dart';
import 'package:look_up_app/student/mentor.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          GoogleSignIn().signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SignInScreen()));
        },
        backgroundColor: const Color.fromRGBO(51, 107, 135, 1),
        child: const Icon(Icons.logout),
      ),
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(51, 107, 135, 1),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Codehub",
              style: GoogleFonts.audiowide(fontSize: 22),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 12, 0),
              child: InkWell(
                onTap: () async {
                  final uri = Uri.parse("https://cyber-hawk.vercel.app/");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    print('cannot');
                  }
                },
                child: Image.asset(
                  'assets/logo1.png',
                  height: 40,
                  width: 40,
                ),
              ),
            )
          ],
        ),
      ),

      // In body text containing 'Home page ' in center
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(144, 175, 195, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(51, 107, 135, 1),
                    child: MaterialButton(
                      minWidth: 160,
                      child: Text(
                        'My Profile',
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),

                      // by onpressed we call the function signup function
                      onPressed: () async {
                        showAlertDialog(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(51, 107, 135, 1),
                    child: MaterialButton(
                      minWidth: 160,
                      child: Text(
                        'Mentor List',
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),

                      // by onpressed we call the function signup function
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mentor()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            'assets/home_pic.png',
          ),
        ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget analyticsBut = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(51, 107, 135, 1),
      ),
      child: const Text("Analytics"),
      onPressed: () async {
        final uri = Uri.parse("https://alphadead.github.io/CyberHawkWeb/");
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          print('cannot');
        }
      },
    );
    Widget practiceBut = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(51, 107, 135, 1),
      ),
      child: const Text("Practice"),
      onPressed: () async {
        final uri = Uri.parse("https://cyber-hawk.vercel.app/company");
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          print('cannot');
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Tracks", style: GoogleFonts.poppins(fontSize: 22)),
      content: Text("What would you like to go ahead with?",
          style: GoogleFonts.poppins(fontSize: 18)),
      actions: [
        analyticsBut,
        practiceBut,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
