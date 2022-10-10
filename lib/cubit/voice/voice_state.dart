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

class VoiceProcessing extends VoiceState {
  const VoiceProcessing();
}

class VoiceResponse extends VoiceState {
  final String response;
  const VoiceResponse(this.response);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoiceResponse &&
        other.response == response;
  }

  @override
  int get hashCode => response.hashCode;

  @override
  String toString() => 'VoiceResponse(response: $response)';
}

class VoiceError extends VoiceState {
  final String error;
  const VoiceError(this.error);
}

class VoiceDone extends VoiceState {
  const VoiceDone();
}
