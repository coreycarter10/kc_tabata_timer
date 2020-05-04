import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../utils/utils.dart';

class MinSecSelector extends StatelessWidget {
  final Duration duration;
  final ValueChanged<Duration> onChanged;

  const MinSecSelector({Key key, @required this.duration, @required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text(duration.minutes.toString().padLeft(2, '0')),
            onPressed: () {
              showMaterialNumberPicker(
                context: context,
                title: "Minutes",
                minNumber: 0,
                maxNumber: 60,
                selectedNumber: duration.minutes,
                onChanged: (int value) {
                  onChanged(duration.copyWith(minutes: value));
                },
              );
            },
          ),
          const Text(':'),
          FlatButton(
            child: Text(duration.seconds.toString().padLeft(2, '0')),
            onPressed: () {
              showMaterialNumberPicker(
                context: context,
                title: "Seconds",
                minNumber: 0,
                maxNumber: 59,
                selectedNumber: duration.seconds,
                onChanged: (int value) {
                  onChanged(duration.copyWith(seconds: value));
                },
              );
            },
          ),

        ],
      ),
    );
  }
}