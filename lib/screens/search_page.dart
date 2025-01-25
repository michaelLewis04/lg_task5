import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  late AnimationController _animationController;
  List<double> _rectangleWidths = [75, 75, 75, 75];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_isListening) {
          _updateWidths();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Text(
                _text,
                style: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 200),
          AvatarGlow(
            animate: _isListening,
            glowColor: const Color.fromARGB(255, 249, 249, 249),
            duration: const Duration(milliseconds: 2000),
            repeat: true,
            glowRadiusFactor: 1.7,
            child: FloatingActionButton(
              onPressed: _listen,
              shape: const CircleBorder(),
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 36,
              ),
            ),
          ),
          if (_isListening)
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final colors = [
                      Colors.blue,
                      Colors.red,
                      Colors.yellow,
                      Colors.green
                    ];
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Container(
                          height: 10,
                          width: _rectangleWidths[index],
                          color: colors[index],
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _updateWidths() {
    final random = Random();

    final screenWidth = MediaQuery.of(context).size.width;

    final weights = List.generate(
        4,
        (_) =>
            random.nextDouble() * 10); 
    final totalWeight = weights.reduce((a, b) => a + b);

    setState(() {
      _rectangleWidths = weights
          .map((weight) => (screenWidth * weight / totalWeight))
          .toList();
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _animationController.repeat(); 
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _animationController.stop(); 
      _speech!.stop();
    }
  }
}
