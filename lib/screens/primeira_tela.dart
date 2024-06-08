import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
color: Colors.white,
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Stack(
alignment: AlignmentDirectional.center,
children: [
Container(color: Colors.red, width: 100, height: 100,),
Container(color: Colors.blue, width: 50, height: 50,)
],

),
Stack(alignment: AlignmentDirectional.center,
children: [
Container(color: Colors.blue, width: 100, height: 100,),
Container(color: Colors.red, width: 50, height: 50,)
],
),
Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Container(color: Colors.pink, width: 50, height: 50,),
Container(color: Colors.purple, width: 50, height: 50,),
Container(color: Colors.blueAccent, width: 50, height: 50,),
],),
Container(color: Colors.amber, height: 30, width: 300,
child: const Text('Texto do curso',
style: TextStyle(color: Colors.black, fontSize: 24,
),
textAlign: TextAlign.center,)
),
ElevatedButton(onPressed: () {
  //print('o botão funciona');
  },
child: const Text('Aperte o batão'),)
],
),
);
  }
}
