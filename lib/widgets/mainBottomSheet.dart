import 'package:dragtime/models/bottomSheetState.dart';
import 'package:dragtime/models/lightStep.dart';
import 'package:dragtime/widgets/colorSwitchStateGreen.dart';
import 'package:dragtime/widgets/colorSwitchStateRed.dart';
import 'package:dragtime/widgets/colorSwitchStateYellow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBottomSheet extends StatelessWidget {
  const MainBottomSheet({
    Key key,
    @required this.lightSteps,
    @required this.callback,
  }) : super(key: key);

  final List<LightStep> lightSteps;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorSwitchRed(),
                    ColorSwitchYellow(),
                    ColorSwitchGreen(),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: 500,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'insert timer',
                  ),
                  onChanged: (tempTimer) =>
                      Provider.of<BottomSheetState>(context, listen: false)
                          .timer = int.parse(tempTimer),
                ),
              ),
            ),
            Container(
              width: 500,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Add'),
                      onPressed: () {
                        lightSteps.add(Provider.of<BottomSheetState>(context,
                                listen: false)
                            .bottomSheetResult);
                        callback();
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Cancell'),
                      onPressed: () => Navigator.pop(context),
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
