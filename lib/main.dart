import 'package:dragtime/models/lightStep.dart';
import 'package:dragtime/models/bottomSheetState.dart';
import 'package:dragtime/models/lightStepState.dart';
import 'package:dragtime/views/playScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dragtime/widgets/mainBottomSheet.dart';

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
  void refrashMainPage() {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 500,
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
                                title: Text(
                                    '${Provider.of<BottomSheetState>(context, listen: false).lightSteps[index].ID}'),
                                tileColor: Provider.of<BottomSheetState>(
                                        context,
                                        listen: false)
                                    .lightSteps[index]
                                    .colore,
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
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: buildNewBottomSheet,
                        );
                      },
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.restore_sharp),
                      onPressed: () {
                        Provider.of<BottomSheetState>(context, listen: false)
                            .resetLightSteps();
                        setState(() {});
                      },
                    ),
                    FloatingActionButton(
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
