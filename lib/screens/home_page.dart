import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(onPressed: (){
            setState(() {});
          }, 
          icon: const Icon(Icons.refresh)),
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: 
        FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder:(context, snapshot) {
          List<Task>? items = snapshot.data ;
          switch(snapshot.connectionState){
            case ConnectionState.none:
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Carregando'),
                ],
              ),
            );
           
            case ConnectionState.waiting:
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Carregando'),
                ],
              ),
            );
            
            case ConnectionState.active:
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Carregando'),
                ],
              ),
            );
            case ConnectionState.done:
            if(snapshot.hasData && items != null){
              if(items.isNotEmpty){
                // ValueListenableBuilder(
                //   valueListenable: taskListNotifier,
                //   builder: (context, ),
                // )
                return ListView.builder(
                  itemCount: items.length, 
                  itemBuilder: (BuildContext context, int index) {
                    final Task tarefa = items[index];         
                    return Task(nome: tarefa.nome, imagem: tarefa.imagem, dificuldade: tarefa.dificuldade);
                });
              }
              return const Center(child: Column(children: [
                Icon(Icons.error_outline, size: 128,),
                Text('Nenhuma tarefa cadastrada!',
                style: TextStyle(fontSize: 32),)
              ],),);
            }
            return const Text('Erro ao carregar tarefas');
            
          }
          
        }
  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (contextNew) => FormScren(
              taskContext: context,
              ),
            ),
            ).then((value) => setState( (){
            }));

        },
        child: const Icon(Icons.add),),
    );
  }
}