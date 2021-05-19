import 'package:dragtime/models/bottomSheetState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ColorSwitchYellow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _actualState = Provider.of<BottomSheetState>(context).yellowState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 50,
          child: Text(
            'Yellow',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 100,
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (RawKeyEvent event) {
              if (event is RawKeyDownEvent &&
                  event.data is RawKeyEventDataAndroid) {
                RawKeyDownEvent rawKeyDownEvent = event;
                RawKeyEventDataAndroid rawKeyEventDataAndroid =
                    rawKeyDownEvent.data;
                if (rawKeyEventDataAndroid.keyCode == 23) {
                  Provider.of<BottomSheetState>(context, listen: false)
                      .changeToYellowState();
                }
              }
            },
            child: SwitchListTile(
              activeColor: Colors.yellow,
              inactiveTrackColor: Colors.grey,
              value: _actualState,
              onChanged: (bool val) {
                Provider.of<BottomSheetState>(context, listen: false)
                    .changeToYellowState();
              },
            ),
          ),
        ),
      ],
    );
  }
}
