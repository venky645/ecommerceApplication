import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
class SampleUiScreen extends StatefulWidget {
  const SampleUiScreen({super.key});

  @override
  State<SampleUiScreen> createState() => _SampleUiScreenState();
}

class _SampleUiScreenState extends State<SampleUiScreen> {
  @override

  Widget build(BuildContext context) {
    StreamController controller = StreamController.broadcast();
    controller.stream.listen((event) {
      print('hello $event');
    });
    int count = 0;
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: controller.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Text(snapshot.data);

                  } else {
                    return Text('Null Data');
                  }
                },

            ),
            SizedBox(height: 20,),
            StreamBuilder(
              stream: controller.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Text(snapshot.data);
                } else {
                  return Text('Null Data');
                }
              }
            ),
            SizedBox(height: 30,),
            Text('hello welcome to Isolates learning'),
            SizedBox(height: 20,),
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){},
                child: Text('substraction')
            ),
            ElevatedButton(
                onPressed: () => useIsolate(),
                child: Text('addition')
            ),

            ElevatedButton(
                onPressed: (){

                  controller.sink.add('${count++}');
                },
                child: Text('streams check')
            )
          ],
        ),
      ),
    );
  }

  void runHeavyTaskWithoutIsolate(){
    int value = 0;
    for(int i=0;i<4000000000;i++){
      value+=i;
    }
    print('execution is done');
  }
}

useIsolate() async {
final ReceivePort receivePort = ReceivePort();

SendPort? isolateSendPort;

try{
  await Isolate.spawn(addition,receivePort.sendPort);
} on Object {
    print('isolate failed');
    receivePort.close();
}


 receivePort.listen((message) {
   if(message is SendPort){
     print('send port recieved');
     isolateSendPort = message;
     isolateSendPort!.send(400000000);
   } else {
     print('result :  $message');
     isolateSendPort!.send('terminate');
   }
 });
}

//Isolates: -


// void substraction(List<dynamic> args){
//  SendPort sendPort = args[0];
//  int number = args[1];
//  for(int i = 0; i<number;i++){
//    number-=i;
//  }
//  sendPort.send(number);
// }
//
// void multiplication(List<dynamic> args){
//   SendPort sendPort = args[0];
//   int number = args[1];
//   for(int i = 0; i<number;i++){
//     number*=i;
//   }
//   sendPort.send(number);
// }

void addition(SendPort mainSendPort){
  ReceivePort receivePort = ReceivePort();

  mainSendPort.send(receivePort.sendPort);

  receivePort.listen((message) {

    if(message == 'terminate'){
      print('isolate terminated successfully');
      receivePort.close();
      Isolate.current.kill(priority: Isolate.immediate);
    } else {
      print('number recieved $message');
      int num = 0;
      for(int i= 0; i < message;i++){
        num+=i;
      }
      mainSendPort.send(num);
    }
  });
}









