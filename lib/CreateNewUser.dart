import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_1/widget/MyTextField.dart';

void main() => runApp(
      MaterialApp(
        home: CreateNewUser(),
        debugShowCheckedModeBanner: false,
      ),
    );

class CreateNewUser extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerRole = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.add_a_photo,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                label: "Name",
                controller: controllerName,
              ),
              MyTextField(
                label: "Role",
                controller: controllerRole,
              ),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextButton(
                  onPressed: () {
                    String name = controllerName.text;
                    String role = controllerRole.text;
                    final dict = {"name": name, "role": role};
                    Navigator.pop(context, dict);
                  },
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
