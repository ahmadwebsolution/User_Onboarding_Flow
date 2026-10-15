import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomScreen extends StatefulWidget {
const CustomScreen({super.key});

@override
State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen>
with TickerProviderStateMixin {
late AnimationController _animationController;
late AnimationController _particleController;

final List<Offset> _signaturePoints = [];
final List<Offset> _whiteboardPoints = [];

Color _brushColor = Colors.blue;
double _brushSize = 4;

@override
void initState() {
super.initState();

_animationController = AnimationController(
vsync: this,
duration: const Duration(seconds: 2),
)..repeat();

_particleController = AnimationController(
vsync: this,
duration: const Duration(seconds: 4),
)..repeat();
}

@override
void dispose() {
_animationController.dispose();
_particleController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('CustomPainter & Advanced UI'),
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
_sectionTitle('1. Signature Pad'),
_signaturePad(),

_sectionTitle('2. Bar Chart'),
_barChart(),

_sectionTitle('3. Animated Progress Ring'),
_progressRing(),

_sectionTitle('4. Line Chart'),
_lineChart(),

_sectionTitle('5. Donut Chart'),
_donutChart(),

_sectionTitle('6. Speedometer / Gauge'),
_gauge(),

_sectionTitle('7. Wave Animation'),
_waveAnimation(),

_sectionTitle('8. Custom Loader'),
_customLoader(),

_sectionTitle('9. Whiteboard'),
_whiteboard(),

_sectionTitle('10. Particle Effect'),
_particleEffect(),
],
),
);
}

Widget _sectionTitle(String title) {
return Padding(
padding: const EdgeInsets.only(top: 24, bottom: 12),
child: Text(
title,
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
);
}

// 1. SIGNATURE PAD

Widget _signaturePad() {
return Card(
clipBehavior: Clip.antiAlias,
child: Column(
children: [
Container(
height: 180,
width: double.infinity,
color: Colors.grey.shade100,
child: GestureDetector(
onPanUpdate: (details) {
setState(() {
_signaturePoints.add(details.localPosition);
});
},
onPanEnd: (_) {
_signaturePoints.add(Offset.infinite);
},
child: CustomPaint(
painter: SignaturePainter(_signaturePoints),
child: const SizedBox.expand(),
),
),
),
Align(
alignment: Alignment.centerRight,
child: TextButton.icon(
onPressed: () {
setState(() {
_signaturePoints.clear();
});
},
icon: const Icon(Icons.delete_outline),
label: const Text('Clear Signature'),
),
),
],
),
);
}

// 2. BAR CHART

Widget _barChart() {
final values = [40.0, 80.0, 55.0, 110.0, 70.0];
final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

return Card(
child: Padding(
padding: const EdgeInsets.all(16),
child: SizedBox(
height: 180,
child: Row(
crossAxisAlignment: CrossAxisAlignment.end,
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: List.generate(values.length, (index) {
return Column(
mainAxisAlignment: MainAxisAlignment.end,
children: [
Container(
width: 34,
height: values[index],
decoration: BoxDecoration(
color: Colors.deepPurple,
borderRadius: BorderRadius.circular(8),
),
),
const SizedBox(height: 8),
Text(labels[index]),
],
);
}),
),
),
),
);
}

// 3. ANIMATED PROGRESS RING

Widget _progressRing() {
return Card(
child: Padding(
padding: const EdgeInsets.all(20),
child: Center(
child: AnimatedBuilder(
animation: _animationController,
builder: (context, child) {
final progress =
0.25 + (_animationController.value * 0.7);

return SizedBox(
height: 150,
width: 150,
child: CustomPaint(
painter: ProgressRingPainter(progress),
child: Center(
child: Text(
'${(progress * 100).toInt()}%',
style: const TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),
),
),
);
},
),
),
),
);
}

// 4. LINE CHART

Widget _lineChart() {
return Card(
child: Padding(
padding: const EdgeInsets.all(16),
child: SizedBox(
height: 180,
width: double.infinity,
child: CustomPaint(
painter: LineChartPainter(
const [
Offset(0.0, 0.7),
Offset(0.2, 0.4),
Offset(0.4, 0.55),
Offset(0.6, 0.2),
Offset(0.8, 0.35),
Offset(1.0, 0.1),
],
),
),
),
),
);
}

// 5. DONUT CHART

Widget _donutChart() {
return Card(
child: Padding(
padding: const EdgeInsets.all(20),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
SizedBox(
height: 140,
width: 140,
child: CustomPaint(
painter: DonutChartPainter(),
child: const Center(
child: Text(
'100%',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
),
),
),
const Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_Legend(color: Colors.deepPurple, label: 'Flutter'),
SizedBox(height: 12),
_Legend(color: Colors.orange, label: 'Dart'),
SizedBox(height: 12),
_Legend(color: Colors.green, label: 'UI Design'),
],
),
],
),
),
);
}

// 6. GAUGE

Widget _gauge() {
return Card(
child: Padding(
padding: const EdgeInsets.all(20),
child: Center(
child: SizedBox(
height: 150,
width: 260,
child: CustomPaint(
painter: GaugePainter(value: 72),
child: const Align(
alignment: Alignment.bottomCenter,
child: Padding(
padding: EdgeInsets.only(bottom: 8),
child: Text(
'72 / 100',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
),
),
),
),
),
),
);
}

// 7. WAVE ANIMATION

Widget _waveAnimation() {
return Card(
clipBehavior: Clip.antiAlias,
child: SizedBox(
height: 160,
child: AnimatedBuilder(
animation: _animationController,
builder: (context, child) {
return CustomPaint(
painter: WavePainter(_animationController.value),
child: const SizedBox.expand(),
);
},
),
),
);
}

// 8. CUSTOM LOADER

Widget _customLoader() {
return Card(
child: SizedBox(
height: 130,
child: Center(
child: AnimatedBuilder(
animation: _animationController,
builder: (context, child) {
return Transform.rotate(
angle: _animationController.value * 2 * math.pi,
child: const SizedBox(
height: 60,
width: 60,
child: CircularProgressIndicator(
strokeWidth: 6,
valueColor: AlwaysStoppedAnimation<Color>(
Colors.deepPurple,
),
),
),
);
},
),
),
),
);
}

// 9. WHITEBOARD

Widget _whiteboard() {
return Card(
child: Column(
children: [
Container(
height: 180,
width: double.infinity,
color: Colors.white,
child: GestureDetector(
onPanUpdate: (details) {
setState(() {
_whiteboardPoints.add(details.localPosition);
});
},
onPanEnd: (_) {
_whiteboardPoints.add(Offset.infinite);
},
child: CustomPaint(
painter: WhiteboardPainter(
points: _whiteboardPoints,
color: _brushColor,
brushSize: _brushSize,
),
child: const SizedBox.expand(),
),
),
),
Padding(
padding: const EdgeInsets.all(12),
child: Column(
children: [
Wrap(
spacing: 12,
children: [
_colorButton(Colors.blue),
_colorButton(Colors.red),
_colorButton(Colors.green),
_colorButton(Colors.black),
_colorButton(Colors.orange),
],
),
Row(
children: [
const Text('Brush size'),
Expanded(
child: Slider(
value: _brushSize,
min: 2,
max: 15,
onChanged: (value) {
setState(() {
_brushSize = value;
});
},
),
),
IconButton(
onPressed: () {
setState(() {
_whiteboardPoints.clear();
});
},
icon: const Icon(Icons.delete_outline),
),
],
),
],
),
),
],
),
);
}

Widget _colorButton(Color color) {
return GestureDetector(
onTap: () {
setState(() {
_brushColor = color;
});
},
child: Container(
height: 30,
width: 30,
decoration: BoxDecoration(
color: color,
shape: BoxShape.circle,
border: Border.all(
color: _brushColor == color
? Colors.deepPurple
    : Colors.grey,
width: _brushColor == color ? 3 : 1,
),
),
),
);
}

// 10. PARTICLE EFFECT

Widget _particleEffect() {
return Card(
clipBehavior: Clip.antiAlias,
child: SizedBox(
height: 180,
child: AnimatedBuilder(
animation: _particleController,
builder: (context, child) {
return CustomPaint(
painter: ParticlePainter(_particleController.value),
child: const SizedBox.expand(),
);
},
),
),
);
}
}

// LEGEND

class _Legend extends StatelessWidget {
final Color color;
final String label;

const _Legend({
required this.color,
required this.label,
});

@override
Widget build(BuildContext context) {
return Row(
children: [
Container(
height: 12,
width: 12,
decoration: BoxDecoration(
color: color,
shape: BoxShape.circle,
),
),
const SizedBox(width: 8),
Text(label),
],
);
}
}

// SIGNATURE PAINTER

class SignaturePainter extends CustomPainter {
final List<Offset> points;

SignaturePainter(this.points);

@override
void paint(Canvas canvas, Size size) {
final paint = Paint()
..color = Colors.black
..strokeWidth = 3
..strokeCap = StrokeCap.round
..style = PaintingStyle.stroke;

for (int i = 0; i < points.length - 1; i++) {
if (points[i] != Offset.infinite &&
points[i + 1] != Offset.infinite) {
canvas.drawLine(points[i], points[i + 1], paint);
}
}
}

@override
bool shouldRepaint(covariant SignaturePainter oldDelegate) => true;
}

// PROGRESS RING PAINTER

class ProgressRingPainter extends CustomPainter {
final double progress;

ProgressRingPainter(this.progress);

@override
void paint(Canvas canvas, Size size) {
final center = Offset(size.width / 2, size.height / 2);
final radius = math.min(size.width, size.height) / 2 - 12;

final backgroundPaint = Paint()
..color = Colors.grey.shade300
..strokeWidth = 12
..style = PaintingStyle.stroke;

final progressPaint = Paint()
..color = Colors.deepPurple
..strokeWidth = 12
..strokeCap = StrokeCap.round
..style = PaintingStyle.stroke;

canvas.drawCircle(center, radius, backgroundPaint);

canvas.drawArc(
Rect.fromCircle(center: center, radius: radius),
-math.pi / 2,
2 * math.pi * progress,
false,
progressPaint,
);
}

@override
bool shouldRepaint(covariant ProgressRingPainter oldDelegate) {
return oldDelegate.progress != progress;
}
}

// LINE CHART PAINTER

class LineChartPainter extends CustomPainter {
final List<Offset> points;

LineChartPainter(this.points);

@override
void paint(Canvas canvas, Size size) {
final gridPaint = Paint()
..color = Colors.grey.shade300
..strokeWidth = 1;

for (int i = 0; i < 5; i++) {
final y = size.height * i / 4;
canvas.drawLine(
Offset(0, y),
Offset(size.width, y),
gridPaint,
);
}

final chartPoints = points
    .map(
(point) => Offset(
point.dx * size.width,
point.dy * size.height,
),
)
    .toList();

final linePaint = Paint()
..color = Colors.deepPurple
..strokeWidth = 3
..strokeCap = StrokeCap.round
..style = PaintingStyle.stroke;

final path = Path();

if (chartPoints.isNotEmpty) {
path.moveTo(chartPoints.first.dx, chartPoints.first.dy);

for (int i = 1; i < chartPoints.length; i++) {
path.lineTo(chartPoints[i].dx, chartPoints[i].dy);
}

canvas.drawPath(path, linePaint);
}

final dotPaint = Paint()..color = Colors.orange;

for (final point in chartPoints) {
canvas.drawCircle(point, 5, dotPaint);
}
}

@override
bool shouldRepaint(covariant LineChartPainter oldDelegate) => false;
}

// DONUT CHART PAINTER

class DonutChartPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {
final center = Offset(size.width / 2, size.height / 2);
final radius = math.min(size.width, size.height) / 2 - 8;

final colors = [
Colors.deepPurple,
Colors.orange,
Colors.green,
];

final values = [0.5, 0.3, 0.2];
double startAngle = -math.pi / 2;

for (int i = 0; i < values.length; i++) {
final paint = Paint()
..color = colors[i]
..style = PaintingStyle.stroke
..strokeWidth = 22;

final sweepAngle = 2 * math.pi * values[i];

canvas.drawArc(
Rect.fromCircle(center: center, radius: radius),
startAngle,
sweepAngle,
false,
paint,
);

startAngle += sweepAngle;
}
}

@override
bool shouldRepaint(covariant DonutChartPainter oldDelegate) => false;
}

// GAUGE PAINTER

class GaugePainter extends CustomPainter {
final double value;

GaugePainter({required this.value});

@override
void paint(Canvas canvas, Size size) {
final center = Offset(size.width / 2, size.height * 0.85);
final radius = math.min(size.width / 2 - 15, size.height * 0.75);

final backgroundPaint = Paint()
..color = Colors.grey.shade300
..strokeWidth = 18
..style = PaintingStyle.stroke
..strokeCap = StrokeCap.round;

final valuePaint = Paint()
..color = Colors.deepPurple
..strokeWidth = 18
..style = PaintingStyle.stroke
..strokeCap = StrokeCap.round;

final rect = Rect.fromCircle(center: center, radius: radius);

canvas.drawArc(rect, math.pi, math.pi, false, backgroundPaint);

canvas.drawArc(
rect,
math.pi,
math.pi * (value / 100),
false,
valuePaint,
);

final angle = math.pi + math.pi * (value / 100);

final needleEnd = Offset(
center.dx + radius * 0.75 * math.cos(angle),
center.dy + radius * 0.75 * math.sin(angle),
);

final needlePaint = Paint()
..color = Colors.red
..strokeWidth = 4
..strokeCap = StrokeCap.round;

canvas.drawLine(center, needleEnd, needlePaint);
canvas.drawCircle(
center,
7,
Paint()..color = Colors.black,
);
}

@override
bool shouldRepaint(covariant GaugePainter oldDelegate) {
return oldDelegate.value != value;
}
}

// WAVE PAINTER

class WavePainter extends CustomPainter {
final double animationValue;

WavePainter(this.animationValue);

@override
void paint(Canvas canvas, Size size) {
final paint1 = Paint()
..color = Colors.blue.withValues(alpha: 0.5)
..style = PaintingStyle.fill;

final paint2 = Paint()
..color = Colors.deepPurple.withValues(alpha: 0.35)
..style = PaintingStyle.fill;

_drawWave(canvas, size, paint1, 0);
_drawWave(canvas, size, paint2, math.pi);
}

void _drawWave(
Canvas canvas,
Size size,
Paint paint,
double phase,
) {
final path = Path();
path.moveTo(0, size.height * 0.5);

for (double x = 0; x <= size.width; x++) {
final y = size.height * 0.5 +
math.sin(
(x / size.width * 2 * math.pi) +
animationValue * 2 * math.pi +
phase,
) *
25;

path.lineTo(x, y);
}

path.lineTo(size.width, size.height);
path.lineTo(0, size.height);
path.close();

canvas.drawPath(path, paint);
}

@override
bool shouldRepaint(covariant WavePainter oldDelegate) {
return oldDelegate.animationValue != animationValue;
}
}

// WHITEBOARD PAINTER

class WhiteboardPainter extends CustomPainter {
final List<Offset> points;
final Color color;
final double brushSize;

WhiteboardPainter({
required this.points,
required this.color,
required this.brushSize,
});

@override
void paint(Canvas canvas, Size size) {
final paint = Paint()
..color = color
..strokeWidth = brushSize
..strokeCap = StrokeCap.round
..style = PaintingStyle.stroke;

for (int i = 0; i < points.length - 1; i++) {
if (points[i] != Offset.infinite &&
points[i + 1] != Offset.infinite) {
canvas.drawLine(points[i], points[i + 1], paint);
}
}
}

@override
bool shouldRepaint(covariant WhiteboardPainter oldDelegate) {
return true;
}
}

// PARTICLE PAINTER

class ParticlePainter extends CustomPainter {
final double animationValue;

ParticlePainter(this.animationValue);

@override
void paint(Canvas canvas, Size size) {
final random = math.Random(10);

for (int i = 0; i < 45; i++) {
final x = random.nextDouble() * size.width;

final baseY = random.nextDouble() * size.height;
final travel = animationValue * size.height;
final y = (baseY - travel) % size.height;

final radius = 2 + random.nextDouble() * 4;

final paint = Paint()
..color = [
Colors.deepPurple,
Colors.blue,
Colors.orange,
Colors.pink,
][i % 4]
..style = PaintingStyle.fill;

canvas.drawCircle(
Offset(x, y),
radius,
paint,
);
}
}

@override
bool shouldRepaint(covariant ParticlePainter oldDelegate) {
return oldDelegate.animationValue != animationValue;
}
}