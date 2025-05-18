import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomActionButton extends StatelessWidget {
  final Color focusColor;
  final String heroTag;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomActionButton({
    Key? key,
    required this.focusColor,
    this.heroTag = '',
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<Intent>(
            onInvoke: (Intent intent) {
              onPressed();
              return null;
            },
          ),
        },
        child: FloatingActionButton(
          focusColor: focusColor,
          heroTag: heroTag,
          child: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
