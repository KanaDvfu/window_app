import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task.dart';

class ListItem extends StatelessWidget {
  final String text;
  final int index;
  final Task task;
  final Function(bool?) onComplete;
  final Function() onFavorite;
  final Function(DismissDirection) onDelete;

  const ListItem({
    super.key,
    required this.text,
    required this.index,
    required this.task,
    required this.onComplete,
    required this.onFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, bottom: 0, left: 10, top: 10),
      child: Dismissible(
        onDismissed: onDelete,
        background: Container(
          color: const Color.fromARGB(255, 255, 0, 35),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          child: const Icon(
            CupertinoIcons.delete,
            color: CupertinoColors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        key: UniqueKey(),
        child: Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7),
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                shape: const CircleBorder(),
                value: task.isCompleted,
                onChanged: onComplete,
              ),
              Expanded(
                child: Text(text),
              ),
              IconButton(
                color: const Color.fromARGB(255, 255, 175, 73),
                splashRadius: 15,
                icon: (task.isFavorite) ? (const Icon(CupertinoIcons.star_fill)) : (const Icon(CupertinoIcons.star)),
                onPressed: onFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
