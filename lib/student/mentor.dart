import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Mentor extends StatefulWidget {
  const Mentor({Key? key}) : super(key: key);

  @override
  State<Mentor> createState() => _MentorState();
}

class _MentorState extends State<Mentor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(51, 107, 135, 1),
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                Text(
                  "Mentors",
                  style: GoogleFonts.audiowide(fontSize: 22),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("mentors").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("There is no mentor");
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      const Color.fromRGBO(51, 107, 135, 1),
                                  backgroundImage: NetworkImage(
                                    ds['profilePic'],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ds["name"].toString(),
                                        style:
                                            GoogleFonts.poppins(fontSize: 25)),
                                    Text(ds["topic"],
                                        style:
                                            GoogleFonts.poppins(fontSize: 15)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Mentees: ',
                            style: GoogleFonts.poppins(
                                fontSize: 18, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: ds['mentees'].length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        color: Colors.black,
                                        height: 5,
                                        width: 5,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final uri = Uri.parse(
                                              "https://alphadead.github.io/CyberHawkWeb/");
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri);
                                          } else {
                                            print('cannot');
                                          }
                                        },
                                        child: Text(ds["mentees"][index],
                                            style: GoogleFonts.poppins(
                                                fontSize: 18)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 1,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
