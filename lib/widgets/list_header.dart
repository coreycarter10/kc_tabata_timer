import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String text;

  const ListHeader({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline,
    );
  }
}
