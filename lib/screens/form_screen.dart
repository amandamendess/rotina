import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

class FormScren extends StatefulWidget {
  const FormScren ({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScren> createState() => _FormScrenState();
}

class _FormScrenState extends State<FormScren> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imagemController = TextEditingController();
  // ValueNotifier<List<Task>> taskListNotifier = ValueNotifier<List<Task>>([]);

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value){
    if(value != null && value.isEmpty){
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value){
    if(value != null && value.isEmpty){
      if(int.parse(value) > 5 || 
      int.parse(value) < 1){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: ( value) {
                      if ( valueValidator(value)) {
                        return 'insira o nome da Tarefa';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                          ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if(difficultyValidator(value)){
                        return 'Insira um valor para dificuldade entre 1 e 5';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: difficultyController,
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Dificuldade de 1 a 5',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                          ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {
                        
                      });
                    },
                    validator: (value) {
                      if( valueValidator(value)){
                        return 'Insira a url da imagem';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.url,
                    controller: imagemController,
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'imagem',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                          ),
                ),
                Container(
                  height: 100,
                  width: 72,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.blue),
                  
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imagemController.text, 
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                      return Image.asset('assets/images/ler.jpg');
                    } ,
                    fit: BoxFit.cover,),),
                ),
                ElevatedButton(
                  onPressed: () {
                  if(_formKey.currentState!.validate()){
                  TaskDao().save(Task(
                    nome: nameController.text, 
                    imagem: imagemController.text, 
                    dificuldade: int.parse(difficultyController.text
                    ),
                  ),
                  
                );                
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Criando uma nova tarefa'),
                    ),
                  );
                  Navigator.pop(context);
                  }
    //             onPressed: () {
    // if(_formKey.currentState!.validate()){
    //   Task newTask = Task(
    //     nome: nameController.text, 
    //     imagem: imagemController.text, 
    //     dificuldade: int.parse(difficultyController.text),
    //   );
    //   TaskDao().save(newTask);
    //   taskListNotifier.value = [...taskListNotifier.value, newTask];
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Criando uma nova tarefa')),
    //   );
    // }
  
                }, child: const Text('Adicionar'),),
              ],
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}