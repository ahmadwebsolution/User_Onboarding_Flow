
import 'package:flutter/material.dart';

class ImplicitScreen extends StatefulWidget {
  const ImplicitScreen({super.key});

  @override
  State<ImplicitScreen> createState() => _ImplicitScreenState();
}

class _ImplicitScreenState extends State<ImplicitScreen> {
  // AnimatedOpacity
  bool isVisible = true;

  // AnimatedSwitcher
  bool showFirst = true;

  // AnimatedAlign
  bool isAlignedRight = false;

  // AnimatedPositioned
  bool isMoved = false;

  // AnimatedCrossFade
  bool showIcon = true;

  // TweenAnimationBuilder
  double targetSize = 80;

  int animationKey = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animation Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. AnimatedOpacity
          demoTitle('1. AnimatedOpacity'),

          Container(
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 700),
              child: const Text(
                'Hello Flutter!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),

          button(
            isVisible ? 'Fade Out' : 'Fade In',
                () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),

          const Divider(height: 32),

          // 2. AnimatedSwitcher
          demoTitle('2. AnimatedSwitcher'),

          Container(
            height: 130,
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: showFirst
                  ? const Icon(
                Icons.wb_sunny,
                key: ValueKey('sun'),
                color: Colors.orange,
                size: 80,
              )
                  : const Text(
                'Good Morning!',
                key: ValueKey('text'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          button('Switch Text / Icon', () {
            setState(() {
              showFirst = !showFirst;
            });
          }),

          const Divider(height: 32),

          // 3. AnimatedAlign
          demoTitle('3. AnimatedAlign'),

          Container(
            height: 120,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AnimatedAlign(
              alignment: isAlignedRight
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: const Icon(
                Icons.directions_run,
                color: Colors.green,
                size: 55,
              ),
            ),
          ),

          button('Move Left / Right', () {
            setState(() {
              isAlignedRight = !isAlignedRight;
            });
          }),

          const SizedBox(height: 12),

          // AnimatedPositioned
          demoTitle('Bonus: AnimatedPositioned'),

          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      left: isMoved
                          ? constraints.maxWidth - 70
                          : 0,
                      top: isMoved ? 85 : 0,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          button('Move Box', () {
            setState(() {
              isMoved = !isMoved;
            });
          }),

          const Divider(height: 32),

          // 4. AnimatedCrossFade
          demoTitle('4. AnimatedCrossFade'),

          Container(
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 600),
              crossFadeState: showIcon
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 80,
              ),
              secondChild: const Text(
                'You are awesome!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          button('Show Icon / Text', () {
            setState(() {
              showIcon = !showIcon;
            });
          }),

          const Divider(height: 32),

          // 5. TweenAnimationBuilder
          demoTitle('5. TweenAnimationBuilder'),

          Container(
            height: 180,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TweenAnimationBuilder<double>(
              key: ValueKey(animationKey),
              tween: Tween<double>(
                begin: 0,
                end: targetSize,
              ),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              builder: (context, size, child) {
                return Container(
                  width: size + 40,
                  height: size + 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    size.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          button('Animate Size', () {
            setState(() {
              targetSize = targetSize == 80 ? 120 : 80;
              animationKey++;
            });
          }),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget demoTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
