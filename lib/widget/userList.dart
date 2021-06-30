import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  final colour;
  final userName;
  final statusColor;
  final role;
  final onPressed;
  final authorization;

  UserRow(
      {@required this.authorization,
      @required this.colour,
      @required this.userName,
      @required this.statusColor,
      @required this.role,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 5,
              color: colour,
              height: 80,
            ),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      //This container shows active status using red green yellow color
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: statusColor,
                          ),
                        ),
                        width: 15,
                        height: 15,
                      ),
                      //This widget will work as divider
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 50,
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      //This column contains all info about user.
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(role),
                            Text(
                              authorization.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
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
    );
  }
}
