import 'package:dragtime/models/bottomSheetState.dart';
import 'package:dragtime/models/lightStep.dart';
import 'package:dragtime/widgets/action_button.dart';
import 'package:dragtime/widgets/colorSwitchStateGreen.dart';
import 'package:dragtime/widgets/colorSwitchStateRed.dart';
import 'package:dragtime/widgets/colorSwitchStateYellow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainBottomSheet extends StatelessWidget {
  MainBottomSheet({
    Key? key,
    required this.lightSteps,
    required this.callback,
    this.index,
  }) : super(key: key);

  final List<LightStep> lightSteps;
  final Function callback;
  final int? index;

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
                  CustomActionButton(
                    focusColor: Colors.black,
                    icon: Icons.arrow_circle_up,
                    onPressed: () {
                      Provider.of<BottomSheetState>(context, listen: false)
                          .timerAddOne();
                    },
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: Card(
                      elevation: 1,
                      child: Center(
                        child: Text(Provider.of<BottomSheetState>(context)
                            .timer
                            .toString()),
                      ),
                    ),
                  ),
                  CustomActionButton(
                    focusColor: Colors.black,
                    icon: Icons.arrow_circle_down,
                    onPressed: () {
                      Provider.of<BottomSheetState>(context, listen: false)
                          .timerRemoveOne();
                    },
                  ),
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
              Focus(
                autofocus: true,
                child: Shortcuts(
                  shortcuts: <LogicalKeySet, Intent>{
                    LogicalKeySet(LogicalKeyboardKey.enter):
                        const ActivateIntent(),
                  },
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      ActivateIntent: CallbackAction<Intent>(
                        onInvoke: (Intent intent) {
                          lightSteps.add(Provider.of<BottomSheetState>(context,
                                  listen: false)
                              .bottomSheetResult);

                          callback();
                          Provider.of<BottomSheetState>(context, listen: false)
                              .setTimer(0);
                          Navigator.pop(context);
                        },
                      ),
                    },
                    child: IconButton(
                      icon: Icon(Icons.check),
                      focusColor: Colors.black,
                      onPressed: () {
                        if (index != null) {
                          Provider.of<BottomSheetState>(context, listen: false)
                              .updateLightStep(
                            index!,
                            Provider.of<BottomSheetState>(context,
                                    listen: false)
                                .bottomSheetResult,
                          );
                          callback();
                          Provider.of<BottomSheetState>(context, listen: false)
                              .setTimer(0);
                          Navigator.pop(context);
                        } else {
                          lightSteps.add(Provider.of<BottomSheetState>(context,
                                  listen: false)
                              .bottomSheetResult);

                          callback();
                          Provider.of<BottomSheetState>(context, listen: false)
                              .setTimer(0);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Focus(
                autofocus: true,
                child: Shortcuts(
                  shortcuts: <LogicalKeySet, Intent>{
                    LogicalKeySet(LogicalKeyboardKey.enter):
                        const ActivateIntent(),
                  },
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      ActivateIntent: CallbackAction<Intent>(
                        onInvoke: (Intent intent) {
                          if (index != null) {
                            Provider.of<BottomSheetState>(context,
                                    listen: false)
                                .removeLightStep(index!);
                            callback();
                          }
                          Navigator.pop(context);
                        },
                      ),
                    },
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      focusNode: FocusNode(),
                      focusColor: Colors.black,
                      onPressed: () {
                        if (index != null) {
                          Provider.of<BottomSheetState>(context, listen: false)
                              .removeLightStep(index!);
                          callback();
                        }
                        Navigator.pop(context);
                      },
                    ),
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
