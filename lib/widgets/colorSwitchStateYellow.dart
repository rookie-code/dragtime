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
                        .changeToYellowState();
                  },
                ),
              },
              child: Switch(
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
        ),
      ],
    );
  }
}
