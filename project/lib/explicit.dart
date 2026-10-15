
import 'package:flutter/material.dart';

class ExplicitScreen extends StatefulWidget {
const ExplicitScreen({super.key});

@override
State<ExplicitScreen> createState() =>
_ExplicitScreenState();
}

class _ExplicitScreenState extends State<ExplicitScreen>
with SingleTickerProviderStateMixin {
late AnimationController controller;

late Animation<double> fadeAnimation;
late Animation<double> scaleAnimation;
late Animation<double> rotationAnimation;
late Animation<Offset> slideAnimation;
late Animation<double> sizeAnimation;
late Animation<Alignment> alignAnimation;
late Animation<Color?> colorAnimation;
late Animation<TextStyle> textAnimation;

@override
void initState() {
super.initState();

controller = AnimationController(
vsync: this,
duration: const Duration(seconds: 2),
);

fadeAnimation = Tween<double>(
begin: 0,
end: 1,
).animate(controller);

scaleAnimation = Tween<double>(
begin: 0.2,
end: 1,
).animate(controller);

rotationAnimation = Tween<double>(
begin: 0,
end: 2 * 3.14159,
).animate(controller);

slideAnimation = Tween<Offset>(
begin: const Offset(-1, 0),
end: Offset.zero,
).animate(controller);

sizeAnimation = Tween<double>(
begin: 0,
end: 100,
).animate(controller);

alignAnimation = AlignmentTween(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
).animate(controller);

colorAnimation = ColorTween(
begin: Colors.blue,
end: Colors.red,
).animate(controller);

textAnimation = TextStyleTween(
begin: const TextStyle(
fontSize: 14,
color: Colors.blue,
),
end: const TextStyle(
fontSize: 28,
color: Colors.red,
fontWeight: FontWeight.bold,
),
).animate(controller);
}

@override
void dispose() {
controller.dispose();
super.dispose();
}

void playAnimation() {
if (controller.status == AnimationStatus.completed) {
controller.reverse();
} else {
controller.forward();
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Explicit Animations'),
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
children: [
const Text(
'Tap the button to run animations',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 20),

demoTitle('1. FadeTransition'),
SizedBox(
height: 70,
child: Center(
child: FadeTransition(
opacity: fadeAnimation,
child: const Icon(
Icons.favorite,
size: 50,
color: Colors.red,
),
),
),
),

demoTitle('2. ScaleTransition'),
SizedBox(
height: 100,
child: Center(
child: ScaleTransition(
scale: scaleAnimation,
child: const Icon(
Icons.star,
size: 60,
color: Colors.orange,
),
),
),
),

demoTitle('3. RotationTransition'),
SizedBox(
height: 100,
child: Center(
child: RotationTransition(
turns: rotationAnimation,
child: const Icon(
Icons.refresh,
size: 60,
color: Colors.green,
),
),
),
),

demoTitle('4. SlideTransition'),
SizedBox(
height: 80,
child: SlideTransition(
position: slideAnimation,
child: const Icon(
Icons.directions_car,
size: 55,
color: Colors.blue,
),
),
),

demoTitle('5. SizeTransition'),
SizedBox(
height: 100,
child: Center(
child: SizeTransition(
sizeFactor: sizeAnimation,
axis: Axis.horizontal,
child: Container(
width: 100,
height: 60,
color: Colors.purple,
child: const Center(
child: Text(
'Size',
style: TextStyle(color: Colors.white),
),
),
),
),
),
),

demoTitle('6. AlignTransition'),
SizedBox(
height: 150,
width: double.infinity,
child: Container(
color: Colors.grey.shade200,
child: AlignTransition(
alignment: alignAnimation,
child: const Icon(
Icons.circle,
size: 35,
color: Colors.teal,
),
),
),
),

demoTitle('7. DecoratedBoxTransition'),
SizedBox(
height: 100,
child: Center(
child: DecoratedBoxTransition(
decoration: DecorationTween(
begin: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(0),
),
end: BoxDecoration(
color: Colors.red,
borderRadius: BorderRadius.circular(30),
),
).animate(controller),
child: const SizedBox(
width: 100,
height: 60,
child: Center(
child: Text(
'Color',
style: TextStyle(color: Colors.white),
),
),
),
),
),
),

demoTitle('8. DefaultTextStyleTransition'),
SizedBox(
height: 60,
child: Center(
child: DefaultTextStyleTransition(
style: textAnimation,
child: const Text('Flutter'),
),
),
),

const SizedBox(height: 25),

ElevatedButton.icon(
onPressed: playAnimation,
icon: const Icon(Icons.play_arrow),
label: const Text('Play / Reverse Animation'),
),
],
),
),
);
}

Widget demoTitle(String title) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 12),
child: Text(
title,
style: const TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
);
}
}