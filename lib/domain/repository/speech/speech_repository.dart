enum SpeechState { listening, notListening, done }

abstract class SpeechRepository {
  Future<void> startListening();
  Future<void> stopListening();
  Stream<String> get recognizedWords;
  Stream<SpeechState> get listeningState;
}
