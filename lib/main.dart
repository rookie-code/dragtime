import 'dart:math';

import 'package:dragtime/models/lightStep.dart';
import 'package:dragtime/views/playScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drag Time',
      initialRoute: MainMenu.page,
      routes: {
        MainMenu.page: (context) => MainMenu(),
        PlayScreen.page: (context) => PlayScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  static const page = '/mainMenu';
  final List<LightStep> lightSteps = [
    LightStep(1, Colors.red, 25),
    LightStep(2, Colors.yellow, 10),
    LightStep(3, Colors.green, 25),
  ];

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'sequence number'),
              ),
            ),
            Card(
                elevation: 5,
                child: Container(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SwitchListTile(
                          value: true,
                          onChanged: null,
                        ),
                      ),
                      Flexible(
                        child: SwitchListTile(
                          value: true,
                          onChanged: null,
                        ),
                      ),
                      Flexible(
                        child: SwitchListTile(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 500,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: ListTile(
                          title: Text('${lightSteps[index].ID}'),
                          tileColor: lightSteps[index].colore,
                        ),
                      ),
                    );
                  },
                  itemCount: lightSteps.length,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: buildBottomSheet,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
