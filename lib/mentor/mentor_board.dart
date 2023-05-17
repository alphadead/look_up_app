// Home page screen

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up_app/login_screen.dart';
import 'package:look_up_app/mentor/mentor_profile.dart';
import 'package:look_up_app/mentor/student.dart';
import 'package:url_launcher/url_launcher.dart';

class MentorBoard extends StatefulWidget {
  const MentorBoard({Key? key}) : super(key: key);

  @override
  _MentorBoardState createState() => _MentorBoardState();
}

class _MentorBoardState extends State<MentorBoard> {
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
              "CyberHawk",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MentorProfile()));
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
                        'Student List',
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),

                      // by onpressed we call the function signup function
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Student()));
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
}
