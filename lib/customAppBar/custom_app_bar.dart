import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:window_app/customAppBar/popup_menu_item.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String branchName;
  final AsyncCallback onEditBranch;
  final AsyncCallback onDeleteDone;
  final bool showCompleted;
  final Function onSwitchCompleted;
  final bool showFavorite;
  final Function onSwitchFavorite;

  const CustomAppBar({
    Key? key,
    required this.branchName,
    required this.onEditBranch,
    required this.onDeleteDone,
    required this.showCompleted,
    required this.onSwitchCompleted,
    required this.showFavorite,
    required this.onSwitchFavorite,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(branchName),
      actions: [
        PopupMenuButton(
          onSelected: (value) => value(),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: onSwitchCompleted,
              child: showCompleted
                  ? const CustomPopupMenuItem(
                      popupItemIcon: CupertinoIcons.xmark_seal,
                      popupItemText: 'Показать выполненные',
                    )
                  : const CustomPopupMenuItem(
                      popupItemIcon: CupertinoIcons.checkmark_seal_fill,
                      popupItemText: 'Скрыть выполненные',
                    ),
            ),
            PopupMenuItem(
              value: onSwitchFavorite,
              child: showFavorite
                  ? const CustomPopupMenuItem(
                      popupItemIcon: CupertinoIcons.bookmark,
                      popupItemText: 'Все задачи',
                    )
                  : const CustomPopupMenuItem(
                      popupItemIcon: CupertinoIcons.bookmark_solid,
                      popupItemText: 'Только избранные',
                    ),
            ),
            PopupMenuItem(
              value: onDeleteDone,
              child: const CustomPopupMenuItem(
                popupItemIcon: CupertinoIcons.delete_solid,
                popupItemText: 'Удалить выполненные',
              ),
            ),
            PopupMenuItem(
              value: onEditBranch,
              child: const CustomPopupMenuItem(
                popupItemIcon: CupertinoIcons.textformat_abc_dottedunderline,
                popupItemText: 'Редактировать ветку',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
