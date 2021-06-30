import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_1/UserCreator.dart';
import 'package:project_1/widget/UserData.dart';
import 'package:project_1/widget/userList.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'ShowUser.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<MyApp> {
  static List<String> nameList = [];
  static List<String> roleList = [];
  static List repo = [];

  var name;
  var role;
  var pic;
  Color shimmerColor = Colors.white;
  List<Widget> realList = [];

  @override
  void initState() {
    super.initState();
    getShimmer();
    print("init called");
    getResponse();
  }

  Widget appbarSearchText =
      Text("Users", style: TextStyle(color: Colors.black));
  Icon searchOrCancel = Icon(
    Icons.search,
    color: Colors.black,
  );
  TextEditingController controllerAuto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFAFAFA),
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        title: appbarSearchText,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  if (searchOrCancel.icon == Icons.search) {
                    appbarSearchText = SizedBox(
                      height: 40,
                      child: Center(
                        child: TypeAheadFormField<String?>(
                          suggestionsCallback: UserData.getSuggestions,
                          itemBuilder: (context, String? suggestion) {
                            return ListTile(
                              title: Text(suggestion!),
                            );
                          },
                          onSuggestionSelected: (String? suggestion) {
                            controllerAuto.text = suggestion!;
                            setState(() {
                              nameList = UserData.getSuggestions(suggestion);
                            });
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controllerAuto,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Queue",
                            ),
                          ),
                        ),
                      ),
                    );
                    searchOrCancel = Icon(
                      Icons.cancel,
                      color: Colors.black,
                    );
                  } else {
                    nameList = UserData.users;
                    searchOrCancel = Icon(
                      Icons.search,
                      color: Colors.black,
                    );
                    appbarSearchText = Text(
                      "Users",
                      style: TextStyle(color: Colors.black),
                    );
                  }
                },
              );
            },
            icon: searchOrCancel,
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final nameAndRole = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return UserCreator();
              }));

              if (nameAndRole != null) {
                getShimmer();
                getResponse();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // MyHead(),
            Expanded(
              child: ListView(
                children: realList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getChildren() {
    int count = 0;
    List<Widget> userModule = [];
    for (String i in nameList) {
      final int c = count;
      Color color = Colors.green;
      if (repo[c]['AuthorizationStatus'] != 'authorized') {
        color = Colors.orange;
      }
      Widget row = UserRow(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ShowUser(
                  repo: repo[c],
                  pic: pic,
                );
              },
            ),
          );
        },
        colour: color,
        role: roleList[c],
        userName: i,
        statusColor: color,
        authorization: repo[c]['AuthorizationStatus'],
      );
      userModule.add(row);
      count++;
    }
    setState(() {
      realList = userModule;
    });
  }

  void getResponse() async {
    Uri uri = Uri.parse(
        'https://shoeboxtx.veloxe.com:36251/api/getLocationAdmins?UserToken=EAB8D7A5-D1AC-40AE-ACE5-2F41CEACAC2B644170606&LocationID=C29CDF52-7D14-4155-AADD-C35682B62906');
    http.Response response = await http.get(uri);
    List list = jsonDecode(response.body);
    nameList = [];
    roleList = [];
    for (var i in list) {
      final name = i['UserName'];
      final type = i['UserType'];
      nameList.add(name);
      roleList.add(type);
      repo.add(i);
    }
    UserData.users = nameList;
    print(nameList);
    getChildren();
  }

  void getShimmer() {
    List<Widget> shimmers = [];
    for (int i = 0; i < 6; i++) {
      Widget listObj = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Shimmer.fromColors(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  baseColor: shimmerColor,
                  highlightColor: Colors.grey,
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 100,
                      child: Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        baseColor: shimmerColor,
                        highlightColor: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 10,
                      width: 200,
                      child: Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        baseColor: shimmerColor,
                        highlightColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      shimmers.add(listObj);
    }
    setState(() {
      realList = shimmers;
    });
  }
}
