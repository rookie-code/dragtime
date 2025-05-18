import 'package:dragtime/models/bottomSheetState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ColorSwitchGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _actualState = Provider.of<BottomSheetState>(context).greenState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          child: Text(
            'Green',
            textAlign: TextAlign.center,
          ),
        ),
        Focus(
          autofocus: true,
          child: Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                ActivateIntent: CallbackAction<Intent>(
                  onInvoke: (Intent intent) {
                    Provider.of<BottomSheetState>(context, listen: false)
                        .changeToGreenState();
                    return null;
                  },
                ),
              },
              child: Switch(
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                value: _actualState,
                onChanged: (bool val) {
                  Provider.of<BottomSheetState>(context, listen: false)
                      .changeToGreenState();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
