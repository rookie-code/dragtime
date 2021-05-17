import 'package:dragtime/models/bottomSheetState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorSwitchRed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _actualState = Provider.of<BottomSheetState>(context).redState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          child: Text(
            'Red',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 100,
          child: SwitchListTile(
            activeColor: Colors.red,
            inactiveTrackColor: Colors.grey,
            value: _actualState,
            onChanged: (bool val) {
              Provider.of<BottomSheetState>(context, listen: false)
                  .changeToRedState(val);
            },
          ),
        ),
      ],
    );
  }
}
