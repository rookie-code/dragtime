import 'package:dragtime/models/bottomSheetState.dart';
import 'package:dragtime/models/lightStep.dart';
import 'package:dragtime/widgets/colorSwitchStateGreen.dart';
import 'package:dragtime/widgets/colorSwitchStateRed.dart';
import 'package:dragtime/widgets/colorSwitchStateYellow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainBottomSheet extends StatelessWidget {
  MainBottomSheet({
    Key key,
    @required this.lightSteps,
    @required this.callback,
  }) : super(key: key);

  final List<LightStep> lightSteps;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
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
                          Provider.of<BottomSheetState>(context, listen: false)
                              .timerAddOne();
                        }
                      }
                    },
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusColor: Colors.black,
                      onPressed: () {
                        Provider.of<BottomSheetState>(context, listen: false)
                            .timerAddOne();
                      },
                      child: Icon(Icons.arrow_circle_up),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: Card(
                      elevation: 1,
                      child: Center(
                          child: Text(Provider.of<BottomSheetState>(context)
                              .timer
                              .toString())),
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
                          Provider.of<BottomSheetState>(context, listen: false)
                              .timerRemoveOne();
                        }
                      }
                    },
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusColor: Colors.black,
                      child: Icon(Icons.arrow_circle_down),
                      onPressed: () {
                        Provider.of<BottomSheetState>(context, listen: false)
                            .timerRemoveOne();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorSwitchRed(),
              ColorSwitchYellow(),
              ColorSwitchGreen(),
            ],
          ),
          Row(
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
                      lightSteps.add(
                          Provider.of<BottomSheetState>(context, listen: false)
                              .bottomSheetResult);
                      callback();
                      Provider.of<BottomSheetState>(context, listen: false)
                          .setTimer(0);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 10),
                  child: FloatingActionButton(
                    child: Text('Add'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusColor: Colors.black,
                    onPressed: () {
                      lightSteps.add(
                          Provider.of<BottomSheetState>(context, listen: false)
                              .bottomSheetResult);

                      callback();
                      Provider.of<BottomSheetState>(context, listen: false)
                          .setTimer(0);
                      Navigator.pop(context);
                    },
                  ),
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
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 20),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusNode: FocusNode(),
                    focusColor: Colors.black,
                    child: Text('Cancell'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
