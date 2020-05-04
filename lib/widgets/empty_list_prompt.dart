import 'package:flutter/material.dart';

class EmptyListPrompt extends StatelessWidget {
  final String text;

  const EmptyListPrompt({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}
