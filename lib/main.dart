import 'dart:convert';

import 'package:dragtime/models/lightStep.dart';
import 'package:dragtime/models/bottomSheetState.dart';
import 'package:dragtime/models/lightStepState.dart';
import 'package:dragtime/views/playScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dragtime/widgets/mainBottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomSheetState()),
        ChangeNotifierProvider(create: (context) => LightStepState()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  static const page = '/mainMenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    initSharedPreferences();

    super.initState();
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData() {
    var listFromProvider =
        Provider.of<BottomSheetState>(context, listen: false).lightSteps;
    List<String> spList =
        listFromProvider.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('lightList', spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('lightList');
    Provider.of<BottomSheetState>(context, listen: false).setLightSteps(
        spList.map((item) => LightStep.fromMap(json.decode(item))).toList());
    setState(() {});
  }

  void refrashMainPage() {
    saveData();
    setState(() {});
  }

  Widget buildNewBottomSheet(BuildContext context) {
    return MainBottomSheet(
      lightSteps:
          Provider.of<BottomSheetState>(context, listen: false).lightSteps,
      callback: refrashMainPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                child: Provider.of<BottomSheetState>(context, listen: false)
                        .lightSteps
                        .isEmpty
                    ? Center(child: Text('empty list'))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.circle,
                                  color: Color(Provider.of<BottomSheetState>(
                                          context,
                                          listen: false)
                                      .lightSteps[index]
                                      .colore),
                                ),
                                title: Text(
                                    'Timer: ${Provider.of<BottomSheetState>(context, listen: false).lightSteps[index].time} min'),
                                tileColor: Colors.white,
                                onTap: () => print('modify this element'),
                              ),
                            ),
                          );
                        },
                        itemCount: Provider.of<BottomSheetState>(context,
                                listen: false)
                            .lightSteps
                            .length,
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent &&
                            event.data is RawKeyEventDataAndroid) {
                          RawKeyDownEvent rawKeyDownEvent = event;
                          RawKeyEventDataAndroid rawKeyEventDataAndroid =
                              rawKeyDownEvent.data;
                          if (rawKeyEventDataAndroid.keyCode == 23) {
                            showModalBottomSheet(
                              context: context,
                              builder: buildNewBottomSheet,
                            );
                          }
                        }
                      },
                      child: FloatingActionButton(
                        focusColor: Colors.black,
                        heroTag: 'addLight',
                        child: Icon(Icons.add),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: buildNewBottomSheet,
                          );
                        },
                      ),
                    ),
                    RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent &&
                            event.data is RawKeyEventDataAndroid) {
                          RawKeyDownEvent rawKeyDownEvent = event;
                          RawKeyEventDataAndroid rawKeyEventDataAndroid =
                              rawKeyDownEvent.data;
                          if (rawKeyEventDataAndroid.keyCode == 23) {
                            Provider.of<BottomSheetState>(context,
                                    listen: false)
                                .resetLightSteps();
                            saveData();
                            setState(() {});
                          }
                        }
                      },
                      child: FloatingActionButton(
                        focusColor: Colors.black,
                        heroTag: 'reset',
                        child: Icon(Icons.restore_sharp),
                        onPressed: () {
                          Provider.of<BottomSheetState>(context, listen: false)
                              .resetLightSteps();
                          saveData();
                          setState(() {});
                        },
                      ),
                    ),
                    RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent &&
                            event.data is RawKeyEventDataAndroid) {
                          RawKeyDownEvent rawKeyDownEvent = event;
                          RawKeyEventDataAndroid rawKeyEventDataAndroid =
                              rawKeyDownEvent.data;
                          if (rawKeyEventDataAndroid.keyCode == 23) {
                            Provider.of<LightStepState>(context, listen: false)
                                .initLightStepState(
                                    Provider.of<BottomSheetState>(context,
                                            listen: false)
                                        .lightSteps);
                            Navigator.pushNamed(context, PlayScreen.page);
                          }
                        }
                      },
                      child: FloatingActionButton(
                        focusColor: Colors.black,
                        heroTag: 'play',
                        child: Icon(Icons.play_arrow_rounded),
                        onPressed: () {
                          Provider.of<LightStepState>(context, listen: false)
                              .initLightStepState(Provider.of<BottomSheetState>(
                                      context,
                                      listen: false)
                                  .lightSteps);
                          Navigator.pushNamed(context, PlayScreen.page);
                        },
                      ),
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
