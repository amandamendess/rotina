import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class  TaskInherited extends InheritedWidget {
  TaskInherited ({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
     Task(
            nome: 'Curso de Flutter',
            imagem:
            'assets/images/flutter.png',
            dificuldade: 4,
          ),
           Task(
              nome: 'Inglês',
              imagem:
              'assets/images/ingles.jpg',
              dificuldade: 3),
           Task(
              nome: 'Meditar',
              imagem:
              'assets/images/meditar.jpeg',
              dificuldade: 2),
           Task(
              nome: 'Ler',
              imagem:
              'assets/images/ler.jpg',
              dificuldade: 3),
           Task(
              nome: 'Andar de Bike',
              imagem:
              'assets/images/bike.jpg',
              dificuldade: 5),];

  void newTask(String nome, String imagem, int dificuldade){
    taskList.add(Task(nome: nome, imagem: imagem, dificuldade: dificuldade));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No found in cintext');
    return result!;
  }
  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}