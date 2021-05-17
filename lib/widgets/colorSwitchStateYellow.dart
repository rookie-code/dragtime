import 'package:dragtime/models/bottomSheetState.dart';
import 'package:flutter/material.dart';
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
          child: SwitchListTile(
            activeColor: Colors.yellow,
            inactiveTrackColor: Colors.grey,
            value: _actualState,
            onChanged: (bool val) {
              Provider.of<BottomSheetState>(context, listen: false)
                  .changeToYellowState(val);
            },
          ),
        ),
      ],
    );
  }
}
