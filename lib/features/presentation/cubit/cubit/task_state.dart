// ignore_for_file: prefer_const_constructors_in_immutables

part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> taskData;

  TaskLoadedState({required this.taskData});
  @override
  List<Object> get props => [];
}

class TaskFailureState extends TaskState {
  @override
  List<Object> get props => [];
}
