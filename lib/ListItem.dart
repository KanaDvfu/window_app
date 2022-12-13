import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final String text;
  const ListItem({super.key, required this.text});

  @override
  State<StatefulWidget> createState() => ListItemState();
}

class ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }
}