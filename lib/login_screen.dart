// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up_app/mentor/mentor_board.dart';
import 'package:look_up_app/student/student_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String pass = 'student';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              'assets/logo.png',
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/Kid.gif'),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "Rankulator",
                style: GoogleFonts.audiowide(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: const Color.fromRGBO(51, 107, 135, 1),
                ),
              ),
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(144, 175, 195, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(51, 107, 135, 1),
                      child: MaterialButton(
                        minWidth: 250,
                        height: 60,
                        child: Text(
                          'Mentor Sign In',
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),

                        // by onpressed we call the function signup function
                        onPressed: () {
                          setState(() {
                            pass = 'mentor';
                          });
                          signup(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(51, 107, 135, 1),
                      child: MaterialButton(
                        minWidth: 250,
                        height: 60,
                        child: Text(
                          'Student Sign In',
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),

                        // by onpressed we call the function signup function
                        onPressed: () {
                          setState(() {
                            pass = 'student';
                          });
                          signup(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // function to implement the google signin

// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final snackbar = SnackBar(
    content: Text(
      'You are not an authorized mentor',
      style: GoogleFonts.audiowide(),
    ),
    backgroundColor: const Color.fromRGBO(51, 107, 135, 1),
  );
  Future<void> signup(
    BuildContext context,
  ) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Getting users credential
    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;
    if (pass == 'mentor' && user!.email == 'adarshgupta1563@gmail.com') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MentorBoard()));
    } else if (pass == 'student' &&
        user!.email == 'adarshgupta1563@gmail.com') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {});
    } else if (pass == 'student') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
