import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  final String? name;
  const UnknownScreen(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Неизвестный экран: $name"),
      ),
    );
  }
}
