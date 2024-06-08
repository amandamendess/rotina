import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/difficulty.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen_edit.dart';

class Task extends StatefulWidget {
  final String nome;
  final String imagem;
  final int dificuldade;

  const Task({
    required this.nome,
    required this.imagem,
    required this.dificuldade,
    super.key,
  });

final int nivel = 0;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool assetOrNetwork(){
    if(widget.imagem.contains('http')){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.blue.withOpacity(0.2),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              width: 375,
              height: 170,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  width: 375,
                  height: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5)),
                        width: 75,
                        height: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: assetOrNetwork() ?
                            Image.asset(
                              widget.imagem,
                              fit: BoxFit.cover,
                            ) : Image.network(widget.imagem,
                            fit: BoxFit.cover,)
                            ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style:const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Difficulty(difficultyLevel: widget.dificuldade,),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 52,
                            width: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                print(widget.nome);
                                confirmEdit(context, widget);
                              },
                                
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.edit, color: Colors.white),
                                    
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 52,
                            width: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                confirmDelete(context, widget.nome);
                              },
                                
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.delete, color: Colors.white),
                                    
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          value: (widget.dificuldade > 0)
                              ? (widget.nivel / widget.dificuldade) / 10
                              : 1,
                        ),
                      ),
                      Text(
                        'Nivel: ${widget.dificuldade}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

confirmDelete(context, tarefaNome){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return  Column(
        children: [
           AlertDialog(
            title: const Text('Certeza que deseja deletar essa tarefa?'),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();},
                child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  TaskDao().delete(tarefaNome);
                  Navigator.of(context).pop();
                }, 
                child: const Text('Deletar')),
              
            ],
          ),
        ],
      );
  });
}

 confirmEdit(context, tarefa){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return  Column(
        children: [
           AlertDialog(
            title: const Text('Certeza que deseja editar essa tarefa?'),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();},
                child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreenEdit(tarefa: tarefa,)));
                }, 
                child: const Text('Editar')),
              
            ],
          ),
        ],
      );
  });
 }