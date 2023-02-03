import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:window_app/customAppBar/popup_menu_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
    required this.toDoTitle,
    required this.isDone,
    required this.isFavorite,
    required this.onTaskCompleted,
  });

  final VoidCallback onTaskCompleted;
  final String toDoTitle;
  final bool isDone;
  final bool isFavorite;

  @override
  State<StatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _isDone = widget.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.toDoTitle),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: CustomPopupMenuItem(
                        popupItemIcon: Icons.catching_pokemon, popupItemText: "Вы поймали покемона"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTaskCompletedSetState,
        child: _isDone ? const Icon(CupertinoIcons.check_mark) : const Icon(CupertinoIcons.xmark),
      ),
    );
  }

  void onTaskCompletedSetState() {
    widget.onTaskCompleted();
    setState(() {
      _isDone = !_isDone;
    });
  }
}
