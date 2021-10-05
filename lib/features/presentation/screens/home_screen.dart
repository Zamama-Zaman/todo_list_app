// ignore_for_file: prefer_const_constructors

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:todo_list_app/features/presentation/cubit/cubit/task_cubit.dart';
import 'package:todo_list_app/features/presentation/pages/complete_task_page.dart';
import 'package:todo_list_app/features/presentation/pages/home_page.dart';

import '../../../app_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final iconList = <IconData>[FontAwesome.home, FontAwesome.tasks];
  List<Widget> get _pages => [HomePage(), CompleteTaskPage()];
  int _pageNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          // backgroundColor: colorC80863,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, PageConst.addNewTaskPage)
                .then((value) {
              BlocProvider.of<TaskCubit>(context).getAllTask();
            });
          },
          //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomNavBar(),
        body: _pages[_pageNavIndex],
      ),
    );
  }

  Widget _bottomNavBar() {
    return AnimatedBottomNavigationBar(
      activeColor: Colors.red.shade300,
      gapLocation: GapLocation.center,
      icons: iconList,
      activeIndex: _pageNavIndex,
      onTap: (index) {
        setState(() {
          _pageNavIndex = index;
        });
      },
    );
  }
}
