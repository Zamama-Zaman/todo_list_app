// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/features/domain/entities/task_entity.dart';
import 'package:todo_list_app/features/presentation/cubit/cubit/task_cubit.dart';
import 'package:todo_list_app/features/presentation/widgets/common.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController _taskTextController = TextEditingController();
  int _selectedTaskTypeIndex = 0;
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _taskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          title: const Text("Add New Task"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addNewTaskWidget(),
              _divider(),
              _taskTypeWidget(),
              _divider(),
              _chooseTimeWidget(),
              _addTaskButtonWidget(),
            ],
          ),
        ));
  }

  _addNewTaskWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.blueGrey.withOpacity(.2)),
      child: Scrollbar(
        thickness: 6,
        child: TextField(
          controller: _taskTextController,
          maxLines: 4,
          decoration: const InputDecoration(
              hintText: "e.g morning walk", border: InputBorder.none),
        ),
      ),
    );
  }

  _divider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1.5,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _taskTypeWidget() {
    return SizedBox(
      height: 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: taskTypeList.map((name) {
          var index = taskTypeList.indexOf(name);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTaskTypeIndex = index;
              });
            },
            child: _selectedTaskTypeIndex == index
                ? Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: taskTypeListColor[index],
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: taskTypeListColor[index],
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null &&
        picked_s !=
            TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute))
      setState(() {
        _selectedTime = DateTime(_selectedTime.year, _selectedTime.month,
            _selectedTime.day, picked_s.hour, picked_s.minute);
      });
  }

  _chooseTimeWidget() {
    return GestureDetector(
      onTap: () {
        _selectTime();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Time",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
              "${DateFormat("hh:mm a").format(DateTime.now())} - ${DateFormat("hh:mm a").format(_selectedTime)}"),
        ],
      ),
    );
  }

  _addTaskButtonWidget() {
    return Expanded(
      child: GestureDetector(
        onTap: submitNewTask,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // ignore:
              gradient: LinearGradient(colors: [
                // Colors.indigo,
                // color6FADE4,
                Colors.red,
                Colors.redAccent,
              ], end: Alignment.topLeft, begin: Alignment.topRight),
            ),
            child: Text(
              "Add task",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  void submitNewTask() {
    if (_taskTextController.text.isEmpty) {
      return;
    }
    BlocProvider.of<TaskCubit>(context).addNewTask(
        task: TaskEntity(
      title: _taskTextController.text,
      taskType: taskTypeList[_selectedTaskTypeIndex],
      isNotification: false,
      isCompleteTask: false,
      colorIndex: _selectedTaskTypeIndex,
      time: _selectedTime.toString(),
    ));
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "New Task Added Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
