import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerComp extends StatelessWidget {
  final childWidget;
  final onPressed;

  ContainerComp({this.childWidget, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: childWidget,
            ),
          ),
        ),
      ),
    );
  }
}
