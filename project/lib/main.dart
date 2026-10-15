import 'package:flutter/material.dart';
import 'ImplicitScreen.dart';
import 'explicit.dart';
import 'custom.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Flutter Animations',
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.blue,
),
useMaterial3: true,
),
home: const HomeScreen(),
);
}
}

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Flutter Demo Projects'),
backgroundColor: Colors.blue,
foregroundColor: Colors.white,
),
body: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.animation,
size: 70,
color: Colors.blue,
),
const SizedBox(height: 16),
const Text(
'Flutter Animations & UI',
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 25,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 30),

SizedBox(
width: double.infinity,
child: ElevatedButton.icon(
icon: const Icon(Icons.animation),
label: const Text('Implicit Animations'),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const ImplicitScreen(),
),
);
},
),
),

const SizedBox(height: 14),

SizedBox(
width: double.infinity,
child: ElevatedButton.icon(
icon: const Icon(Icons.play_circle_outline),
label: const Text('Explicit Animations'),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const ExplicitScreen(),
),
);
},
),
),

const SizedBox(height: 14),

SizedBox(
width: double.infinity,
child: ElevatedButton.icon(
icon: const Icon(Icons.brush),
label: const Text(
'CustomPainter & Advanced UI',
),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(
vertical: 16,
),
),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const CustomScreen(),
),
);
},
),
),
],
),
),
),
);
}
}