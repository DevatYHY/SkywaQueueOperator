import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/UserCreator.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowUser extends StatelessWidget {
  final repo;
  final pic;

  ShowUser({@required this.repo, this.pic});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(
        repo: repo,
        pic: pic,
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  final pic;
  final repo;

  @override
  _MyHomeState createState() => _MyHomeState(repo: this.repo, pic: this.pic);

  MyHome({this.repo, this.pic});
}

class _MyHomeState extends State<MyHome> {
  final pic;
  final repo;

  _MyHomeState({@required this.repo, this.pic});

  @override
  Widget build(BuildContext context) {
    print(repo);
    final Widget nameWidget = Text(
      'Email: ${repo['Email']}',
      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
    );
    final Widget phoneWidget = Text(
      'Phone: ${repo['PhoneNumber']}',
      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
    );
    final gender = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image(
                width: 140,
                image: pic != null
                    ? pic
                    : (gender == ""
                        ? AssetImage(
                            "assets/images/undraw_profile_pic_ic5t.png")
                        : (gender == "Male"
                            ? AssetImage(
                                "assets/images/undraw_male_avatar_323b.png")
                            : AssetImage(
                                "assets/images/undraw_female_avatar_w3jk.png"))),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                repo['UserName'] != null ? repo['UserName'] : "User",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                repo['UserType'] != null ? repo['UserType'] : "Developer",
                style: TextStyle(letterSpacing: 1),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: nameWidget,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: phoneWidget,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UserCreator(
                                      name: repo['UserName'],
                                      userType: repo['UserType'],
                                      email: repo['Email'],
                                      phone: repo['PhoneNumber'],
                                    );
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "EDIT VALUES",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void launchURL(url) async {
  await launch(url);
}
