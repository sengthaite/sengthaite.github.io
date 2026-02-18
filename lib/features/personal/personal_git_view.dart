import 'package:flutter/material.dart';

class PersonalGitView extends StatelessWidget {
  const PersonalGitView({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        shrinkWrap: true,
        children: List.generate(20, (index) {
          return Center(child: Text("Text $index"));
        }),
      ),
    );
  }
}
