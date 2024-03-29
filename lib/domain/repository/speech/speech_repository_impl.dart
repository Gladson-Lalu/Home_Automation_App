import '../../service/speech_service.dart';
import 'speech_repository.dart';

class SpeechRepositoryImpl implements SpeechRepository {
  final SpeechToTextService _speechAPIClient;

  const SpeechRepositoryImpl(this._speechAPIClient);

  @override
  Stream<String> get recognizedWords =>
      _speechAPIClient.recognizedWords;

  @override
  Future<void> startListening() {
    return _speechAPIClient.startListening();
  }

  @override
  Future<void> stopListening() {
    return _speechAPIClient.stopListening();
  }

  @override
  Stream<SpeechState> get listeningState =>
      _speechAPIClient.listeningState.map((event) {
        switch (event) {
          case 'listening':
            return SpeechState.listening;
          case 'notListening':
            return SpeechState.notListening;
          case 'done':
            return SpeechState.done;
          default:
            return SpeechState.notListening;
        }
      });
}
