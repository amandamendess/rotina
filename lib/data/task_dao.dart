import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao{
  static const String tabelaSql = 'CREATE TABLE $_tablename('
    '$_name TEXT,'
    '$_difficulty INTEGER,'
    '$_image TEXT)';
  
static const String _tablename = 'tasksTable';
static const String _name = 'name';
static const String _difficulty= 'difficulty';
static const String _image = 'image';

save(Task tarefa) async{
  final Database bancoDeDados = await getDatabase();
  var itemExist = await find(tarefa.nome);
  final Map<String, dynamic> taskMap = toMap(tarefa);
  if(itemExist.isEmpty){
    return await bancoDeDados.insert(_tablename, taskMap);
  } else {
    return await bancoDeDados.update(
      _tablename, 
      taskMap, 
      where: '$_name = ?', 
      whereArgs: [tarefa.nome],
    );
  }
}

Map<String, dynamic>toMap(Task tarefa){
  final Map<String, dynamic> mapaDeTarefas = Map(); 
  mapaDeTarefas[_name] = tarefa.nome;
  mapaDeTarefas[_difficulty] = tarefa.dificuldade;
  mapaDeTarefas[_image] = tarefa.imagem;
  return mapaDeTarefas;
}

Future<List<Task>>findAll() async{
  print('Acessando o findAll: ');
  final Database bancoDeDados = await getDatabase();
  final List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename);
  print('Encontrado: $result');
  return toList(result  );
}

List<Task>toList(List<Map<String, dynamic>> mapaDeTarefas){
  final List<Task> tarefas = [];
  for(Map<String, dynamic> linha in mapaDeTarefas){
    final Task tarefa = Task(
      nome: linha[_name],
      dificuldade: linha[_difficulty],
      imagem: linha[_image],
    );
    tarefas.add(tarefa);
  }
  return tarefas;
}


Future<List<Task>>find(String nomeDaTarefa) async{
  final Database bancoDeDados = await getDatabase();
  final List<Map<String, dynamic>> result = await bancoDeDados.query(
    _tablename, 
    where: '$_name = ?', 
    whereArgs: [nomeDaTarefa],
  );
  return toList(result);
}



atualiza(Task tarefa, String nomeTarefa) async {
  final Database bancoDeDados = await getDatabase();
  final Map<String, dynamic> taskMap = toMap(tarefa);
  return await bancoDeDados.update(
    _tablename, 
    taskMap, 
    where: '$_name = ?', 
    whereArgs: [nomeTarefa],
  );
}

delete(String nomeDaTarefa) async{
  final Database bancoDeDados = await getDatabase();
  return bancoDeDados.delete(_tablename, where: '$_name = ?',whereArgs: [nomeDaTarefa] );
}
}