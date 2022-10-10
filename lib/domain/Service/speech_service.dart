import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  final StreamController<String> _recognizedWords =
      StreamController<String>.broadcast();
  Stream<String> get recognizedWords =>
      _recognizedWords.stream;

  final StreamController<String>
      _listeningStatusController =
      StreamController<String>.broadcast();

  Stream<String> get listeningState =>
      _listeningStatusController.stream;

  Future<void> startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        _listeningStatusController.add(val);
      },
      onError: (val) {
        _listeningStatusController.addError(val);
      },
    );
    if (!available) {
      throw Exception(
          'Speech recognition is not available');
    }
    _speech.listen(
      onResult: (result) {
        _recognizedWords.add(result.recognizedWords);
      },
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
      localeId: 'en_US',
      cancelOnError: true,
      partialResults: true,
    );
  }

  Future<void> stopListening() async {
    _speech.stop();
  }
}
