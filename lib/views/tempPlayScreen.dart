// import 'package:circular_countdown/circular_countdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class PlayScreen extends StatefulWidget {
//   static const page = '/playScreen';
//   PlayScreen({Key key}) : super(key: key);

//   @override
//   _PlayScreenState createState() => _PlayScreenState();
// }

// class _PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
//   AnimationController circleController;
//   int status = 0;
//   Color actualColor = Colors.lightGreenAccent[400];
//   double counterMin = 25.0;

//   @override
//   void initState() {
//     super.initState();

//     circleController = AnimationController(
//       duration: Duration(seconds: 60),
//       vsync: this,
//       upperBound: 60.0,
//       lowerBound: 0.0,
//     );

//     circleController.addStatusListener((listener) {
//       if (listener == AnimationStatus.completed) {
//         circleController.value = 0.0;
//         --counterMin;
//         if (counterMin <= 0) {
//           switchColorTimer();
//         }
//         circleController.forward();
//       }
//     });

//     circleController.addListener(() {
//       setState(() {});
//     });

//     circleController.forward();
//   }

//   void switchColorTimer() {
//     switch (status) {
//       case 0:
//         status = 1;
//         actualColor = Colors.yellowAccent[400];
//         counterMin = 11.0;
//         circleController.forward(from: 60);
//         setState(() {});
//         break;

//       case 1:
//         status = 2;
//         actualColor = Colors.redAccent;
//         counterMin = 26.0;
//         circleController.forward(from: 60);
//         setState(() {});
//         break;

//       case 2:
//         status = 0;
//         actualColor = Colors.lightGreenAccent[400];
//         counterMin = 26.0;
//         circleController.forward(from: 60);
//         setState(() {});
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Scaffold(
//           backgroundColor: actualColor,
//           body: Column(
//             children: <Widget>[
//               Expanded(
//                 child: CircularCountdown(
//                   textSpan: TextSpan(
//                     text: '${counterMin.toInt().toString()}',
//                     style: TextStyle(
//                       backgroundColor: null,
//                       fontSize: 500,
//                       color: Colors.black,
//                     ),
//                   ),
//                   countdownRemaining: circleController.value.toInt(),
//                   countdownTotal: 60,
//                   diameter: 650,
//                   strokeWidth: 20,
//                   countdownCurrentColor: Colors.black,
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   RawKeyboardListener(
//                     focusNode: FocusNode(),
//                     onKey: (RawKeyEvent event) {
//                       if (event is RawKeyDownEvent &&
//                           event.data is RawKeyEventDataAndroid) {
//                         RawKeyDownEvent rawKeyDownEvent = event;
//                         RawKeyEventDataAndroid rawKeyEventDataAndroid =
//                             rawKeyDownEvent.data;
//                         if (rawKeyEventDataAndroid.keyCode == 23) {
//                           circleController.forward(from: 60);
//                           setState(() {});
//                         }
//                       }
//                     },
//                     child: FloatingActionButton(
//                       focusColor: Colors.black,
//                       onPressed: () {
//                         circleController.forward(from: 60);
//                         setState(() {});
//                       },
//                       child: Icon(Icons.remove),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   RawKeyboardListener(
//                     focusNode: FocusNode(),
//                     onKey: (RawKeyEvent event) {
//                       if (event is RawKeyDownEvent &&
//                           event.data is RawKeyEventDataAndroid) {
//                         RawKeyDownEvent rawKeyDownEvent = event;
//                         RawKeyEventDataAndroid rawKeyEventDataAndroid =
//                             rawKeyDownEvent.data;
//                         if (rawKeyEventDataAndroid.keyCode == 23) {
//                           counterMin = counterMin + 2;
//                           if (status == 0 || status == 2) {
//                             if (counterMin >= 26) {
//                               counterMin = 26;
//                             }
//                           }
//                           if (status == 1 && counterMin >= 11) {
//                             counterMin = 11;
//                           }
//                           circleController.forward(from: 60);
//                           setState(() {});
//                         }
//                       }
//                     },
//                     child: FloatingActionButton(
//                         focusColor: Colors.black,
//                         child: Icon(Icons.add),
//                         onPressed: () {
//                           counterMin = counterMin + 2;
//                           if (status == 0 || status == 2) {
//                             if (counterMin >= 26) {
//                               counterMin = 26;
//                             }
//                           }
//                           if (status == 1 && counterMin >= 11) {
//                             counterMin = 11;
//                           }
//                           circleController.forward(from: 60);
//                           setState(() {});
//                         }),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   RawKeyboardListener(
//                     focusNode: FocusNode(),
//                     onKey: (RawKeyEvent event) {
//                       if (event is RawKeyDownEvent &&
//                           event.data is RawKeyEventDataAndroid) {
//                         RawKeyDownEvent rawKeyDownEvent = event;
//                         RawKeyEventDataAndroid rawKeyEventDataAndroid =
//                             rawKeyDownEvent.data;
//                         if (rawKeyEventDataAndroid.keyCode == 23) {
//                           switchColorTimer();
//                         }
//                       }
//                     },
//                     child: FloatingActionButton(
//                       focusColor: Colors.black,
//                       child: Icon(Icons.screen_share),
//                       onPressed: () {
//                         switchColorTimer();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
