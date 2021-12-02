import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
final double radius;
final List<Color> colors;

const Circle({required key, required this.radius, required this.colors}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Container(
    width: radius*2,
    height: radius*2,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.radius),
        gradient: LinearGradient(colors: this.colors, begin: Alignment.topRight, end: Alignment.bottomLeft)),

  );
}
}

class Circle1 extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  const Circle1({required key, required this.radius, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius*0.5,
      height: radius*0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.radius),
          gradient: LinearGradient(colors: this.colors, begin: Alignment.topRight, end: Alignment.bottomLeft)),

    );
  }
}

class Circle2 extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  const Circle2({required key, required this.radius, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius*0.5,
      height: radius*0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.radius),
          gradient: LinearGradient(colors: this.colors, begin: Alignment.topRight, end: Alignment.bottomLeft)),

    );
  }
}
