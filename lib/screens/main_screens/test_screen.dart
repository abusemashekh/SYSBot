import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';

class VisemeAnimationScreen extends StatefulWidget {
  const VisemeAnimationScreen({Key? key}) : super(key: key);

  @override
  _VisemeAnimationScreenState createState() => _VisemeAnimationScreenState();
}

class _VisemeAnimationScreenState extends State<VisemeAnimationScreen> {
  // Phoneme to Viseme mapping
  final Map<String, int> phonemeToViseme = {
    'aa': 1,
    'ae': 1,
    'ah': 1,
    'ax': 1,
    'ao': 2,
    'aw': 2,
    'ow': 2,
    'uh': 2,
    'l': 3,
    'el': 3,
    'd': 4,
    't': 4,
    's': 4,
    'z': 4,
    'n': 4,
    'th': 4,
    'dh': 4,
    'jh': 4,
    'ch': 4,
    'sh': 5,
    'zh': 5,
    'f': 6,
    'v': 6,
    'iy': 7,
    'ih': 7,
    'eh': 7,
    'b': 8,
    'p': 8,
    'm': 8,
    'w': 9,
    'r': 10,
    'oy': 11,
    'er': 11,
    'y': 12,
    'ey': 12,
    'ay': 12
  };

  // Word to Phoneme mapping
  final Map<String, List<String>> wordToPhonemes = {
    'hey': ['hh', 'ey'],
    'baby': ['b', 'ey', 'b', 'iy'],
    'i': ['ay'],
    'like': ['l', 'ay', 'k'],
    'your': ['y', 'uh', 'r'],
    'style': ['s', 't', 'ay', 'l']
  };

  // Dummy text data
  final List<String> dummyText = ["hey", "baby", "i", "like", "your", "style"];

  // Store animation state
  int currentVisemeId = 4; // Default to neutral
  List<String> animationLog = [];
  bool isAnimating = false;
  String? errorMessage;

  // Rive state machine controller
  StateMachineController? _controller;
  SMIInput<double>? _mouthInput;
  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    // Initialize Rive animation
    _loadRiveAnimation();
  }

  // Load Rive animation file
  Future<void> _loadRiveAnimation() async {
    try {
      final file =
          await RiveFile.asset('assets/animations/robot_with_mouth_rig.riv');
      final artboard = file.mainArtboard;
      final controller = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1', // Name of the state machine in the Rive file
      );
      if (controller != null) {
        artboard.addController(controller);
        final mouthInput = controller.findInput<double>('mouthShape');
        setState(() {
          _artboard = artboard;
          _controller = controller;
          _mouthInput = mouthInput;
          if (mouthInput != null) {
            _mouthInput!.value = 4; // Set default to neutral viseme
            animationLog.add('Rive animation loaded successfully');
            errorMessage = null;
          } else {
            errorMessage =
                'Error: Input "mouthInput" not found in State Machine 1';
            animationLog
                .add('Error: Input "mouthInput" not found in State Machine 1');
            animationLog.add(
                'Available inputs: ${controller.inputs.map((i) => i.name).join(", ")}');
          }
        });
      } else {
        setState(() {
          errorMessage = 'Error: State Machine 1 not found in Rive file';
          animationLog.add('Error: State Machine 1 not found in Rive file');
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load Rive file: $e';
        animationLog.add('Failed to load Rive file: $e');
      });
    }
  }

  // Process dummy text for animation
  Future<void> startMouthAnimation() async {
    if (isAnimating) return;

    setState(() {
      isAnimating = true;
      animationLog.clear();
      animationLog.add('Starting animation with text: ${dummyText.join(" ")}');
    });

    for (final word in dummyText) {
      final lower = word.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
      final phonemes = wordToPhonemes[lower] ?? [];

      for (final p in phonemes) {
        final visemeId = phonemeToViseme[p] ?? 4;
        sendToMouthRig(visemeId);
        setState(() {
          currentVisemeId = visemeId;
          animationLog.add('Word: $lower → Phoneme: $p → Viseme: $visemeId');
        });
        await Future.delayed(const Duration(milliseconds: 120));
      }
      // Add slight pause between words
      await Future.delayed(const Duration(milliseconds: 50));
    }

    // Reset to neutral viseme after animation
    sendToMouthRig(4);
    setState(() {
      isAnimating = false;
      currentVisemeId = 4;
      animationLog.add('Animation complete, reset to neutral viseme (4)');
    });
  }

  // Update Rive animation input
  void sendToMouthRig(int visemeId) {
    if (_mouthInput != null) {
      _mouthInput!.value = visemeId.toDouble();
      print('Setting mouthInput to $visemeId');
    } else {
      print('mouthInput is null, simulating viseme $visemeId');
      animationLog
          .add('Warning: mouthInput is null, simulating viseme $visemeId');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Viseme Animation Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: isAnimating ? null : startMouthAnimation,
              child: Text(isAnimating ? 'Animating...' : 'Start Animation'),
            ),
            const SizedBox(height: 20),
            Text(
              'Current Viseme ID: $currentVisemeId',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Input Text: ${dummyText.join(" ")}',
              style: const TextStyle(fontSize: 16),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
            const SizedBox(height: 20),
            // Rive animation display
            Expanded(
              flex: 2,
              child: _artboard == null
                  ? const Center(
                      child: Text('Loading Rive animation or failed to load'))
                  : Rive(
                      artboard: _artboard!,
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Animation Log:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: animationLog.length,
                itemBuilder: (context, index) {
                  return Text(animationLog[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
