import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_1/CreateNewUser.dart';
import 'package:project_1/ShowUser.dart';
import 'package:project_1/main.dart';

class UserCreator extends StatefulWidget {
  final name, email, userType, phone;

  @override
  _UserCreatorState createState() =>
      _UserCreatorState(this.name, this.email, this.userType, this.phone);

  UserCreator({this.name, this.email, this.userType, this.phone});
}

class _UserCreatorState extends State<UserCreator> {
  ImagePicker _picker = ImagePicker();
  Widget imageChild = Icon(Icons.add_a_photo, color: Colors.teal);
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String dropDownValue = 'Queue Operator';

  final name, email, userType, phone;

  _UserCreatorState(this.name, this.email, this.userType, this.phone);

  @override
  void initState() {
    super.initState();
    print(this.userType);
    if (this.name != null) {
      controllers[0].text = this.email;
      controllers[1].text = this.name;
      controllers[2].text = this.phone;
      dropDownValue = this.userType;
    }
  }

  bool noMail = false, noName = false, noPhone = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final PickedFile? pickedFile =
                            await _picker.getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            //TODO:Show picture picked from gallery here.
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Material(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: imageChild,
                                ),
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            items: <String>['admin', 'Queue Operator']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                dropDownValue = _!;
                              });
                            },
                            value: dropDownValue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TextFieldWidget(
                            label: "Email",
                            controller: controllers[0],
                            showError: noMail,
                          ),
                          TextFieldWidget(
                            label: "Name",
                            controller: controllers[1],
                            showError: noName,
                          ),
                          TextFieldWidget(
                            label: "Phone Number",
                            controller: controllers[2],
                            showError: noPhone,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              createUser();
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.teal),
                              child: Center(
                                child: Text(
                                  'ADD',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void createUser() async {
    if (isOkay()) {
      Uri uri =
          Uri.parse('https://shoeboxtx.veloxe.com:36251/api/UpdateUserPost');

      var params = {
        'Email': controllers[0].text,
        'PhoneNumber': '${controllers[2].text}',
        'AuthorizedLocationID': "C29CDF52-7D14-4155-AADD-C35682B62906",
        'AuthorizationStatus': "pendingAcceptance",
        'UserType': dropDownValue,
        'DeviceID': "tempgcbbcfgj2",
        'UserName': controllers[1].text
      };

      String body = json.encode(params);

      var response = await http.post(
        uri,
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) {return MyApp();}));
    }
  }

  bool isOkay() {
    bool textsThere = true;
    if (controllers[0].text.isEmpty) {
      textsThere = false;
      setState(() {
        noMail = true;
      });
    } else if (controllers[1].text.isEmpty) {
      textsThere = false;
      setState(() {
        noName = true;
      });
    } else if (controllers[2].text.isEmpty) {
      textsThere = false;
      setState(() {
        noPhone = true;
      });
    }
    return textsThere;
  }
}

class TextFieldWidget extends StatelessWidget {
  final controller;
  final label;
  final showError;

  TextFieldWidget({this.controller, this.label, @required this.showError});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: label,
          errorText: showError ? "Mandatory Field" : null,
        ),
      ),
    );
  }
}
