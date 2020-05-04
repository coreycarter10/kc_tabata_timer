import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AddExerciseDialog extends StatefulWidget {
  final String exercise;

  const AddExerciseDialog({Key key, this.exercise = ''}) : super(key: key);

  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.text = widget.exercise;
    _textEditingController.selectAll();
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(8),
      title: Text('Exercise'),
      children: <Widget>[
        TextField(
          controller: _textEditingController,
          autofocus: true,
          onSubmitted: (_) => _onSubmitted(),
        ),
        const SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            SimpleDialogOption(
              onPressed: () => _onSubmitted(),
              child: const Text('OK'),
            ),
          ],
        ),
      ],
    );
  }

  _onSubmitted() =>  Navigator.pop(context, _textEditingController.text);
}
