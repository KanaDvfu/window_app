import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:window_app/customAppBar/custom_app_bar.dart';
import 'listItem/task.dart';
import 'listItem/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> taskList = [];
  List<Task> secondaryTaskList = [];
  bool isCompleted = false;
  bool isFavorite = false;
  String branchName = 'Тут могла быть ваша реклама';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        branchName: branchName,
        onEditBranch: openEditBranchDialog,
        onDeleteDone: openDeleteDoneDialog,
        showCompleted: isCompleted,
        onSwitchCompleted: switchCompleted,
        showFavorite: isFavorite,
        onSwitchFavorite: switchFavorite,
      ),
      backgroundColor: const Color.fromARGB(255, 175, 196, 247),
      body: Center(
        child: secondaryTaskList.isEmpty
            ? (emptyList)
            : ListView.builder(
                itemCount: secondaryTaskList.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    text: secondaryTaskList[index].text,
                    index: index,
                    task: secondaryTaskList[index],
                    onComplete: (_) => completeListElement(secondaryTaskList[index].id),
                    onFavorite: () => favoriteListElement(secondaryTaskList[index].id),
                    onDelete: (_) => deleteListElement(secondaryTaskList[index].id),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openCreateTaskDialog();
        },
        child: const Icon(
          CupertinoIcons.plus_square_fill_on_square_fill,
        ),
      ),
    );
  }

  /// on empty list
  final Widget emptyList = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          SvgPicture.asset("assets/images/todolist_background.svg"),
          SvgPicture.asset("assets/images/todolist.svg"),
        ],
      ),
      const SizedBox(
        width: 181,
        child: Text(
          "На данный момент задачи отсутствуют",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    ],
  );

  /// appbar interactions
  void switchCompleted() {
    setState(() {
      isCompleted = !isCompleted;
      filter();
    });
  }

  void switchFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      filter();
    });
  }

  Future<void> openDeleteDoneDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Подтвердите удаление'),
          content: const Text('Удалить выполненыне задачи? Это действие необратимо.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                taskList.removeWhere((task) => task.isCompleted);
                filter();
                Navigator.of(context).pop();
              },
              child: const Text('Подтвердить'),
            ),
          ],
        ),
      );

  Future<void> openEditBranchDialog() async {
    final controller = TextEditingController();
    controller.text = branchName;
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать ветку'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            maxLength: 40,
            validator: (text) {
              return (text!.trimLeft().isEmpty) ? ('Название не может быть пустым') : (null);
            },
            decoration: const InputDecoration(
              hintText: 'Введите название ветки',
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Ок'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(controller.text);
                setState(() {
                  branchName = controller.text.trimLeft();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void filter() {
    Iterable<Task> it = taskList;
    if (isCompleted) {
      it = it.where((task) => !task.isCompleted);
    }
    if (isFavorite) {
      it = it.where((task) => task.isFavorite);
    }
    setState(() {
      secondaryTaskList = it.toList();
    });
  }

  /// element interactions
  void deleteListElement(String id) {
    taskList.removeWhere((task) => id == task.id);
    filter();
  }

  void completeListElement(String id) {
    final index = taskList.indexWhere((task) => task.id == id);
    taskList[index] = Task(
      isCompleted: !taskList[index].isCompleted,
      text: taskList[index].text,
      isFavorite: taskList[index].isFavorite,
    );
    filter();
  }

  void favoriteListElement(String id) {
    final index = taskList.indexWhere((task) => task.id == id);
    taskList[index] = Task(
      isCompleted: taskList[index].isCompleted,
      text: taskList[index].text,
      isFavorite: !taskList[index].isFavorite,
    );
    filter();
  }

  /// on press floating action button
  Future<void> openCreateTaskDialog() {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Создать задачу'),
        content: Form(
          key: formKey,
          child: TextFormField(
            autofocus: true,
            validator: (text) {
              return (text!.trimLeft().isEmpty) ? ('Название не может быть пустым') : (null);
            },
            controller: controller,
            decoration: const InputDecoration(hintText: 'Введите название задачи'),
            maxLength: 40,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  taskList.add(Task(
                    isCompleted: false,
                    text: controller.value.text.trimLeft(),
                    isFavorite: false,
                  ));
                });
                filter();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Ок'),
          ),
        ],
      ),
    );
  }
}
