part of 'voice_cubit.dart';

@immutable
abstract class VoiceState {
  const VoiceState();
}

class VoiceInitial extends VoiceState {
  const VoiceInitial();
}

class VoiceListening extends VoiceState {
  const VoiceListening();
}

class VoiceRecognized extends VoiceState {
  final String recognizedText;
  const VoiceRecognized(this.recognizedText);
}

class VoiceProcessing extends VoiceState {}

class VoiceError extends VoiceState {
  final String error;
  const VoiceError(this.error);
}

class VoiceDone extends VoiceState {
  const VoiceDone();
}
