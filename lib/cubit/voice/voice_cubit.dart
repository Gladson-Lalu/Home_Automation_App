import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/speech/speech_repository.dart';

part 'voice_state.dart';

class VoiceCubit extends Cubit<VoiceState> {
  final SpeechRepository _speechRepository;
  VoiceCubit(this._speechRepository)
      : super(const VoiceInitial());
  String recognizedWords = '';
  void startListening() {
    try {
      recognizedWords = '';
      emit(const VoiceInitial());
      _speechRepository.startListening();
      _speechRepository.listeningState.listen((event) {
        if (event == SpeechState.listening) {
          emit(const VoiceListening());
        } else if (event == SpeechState.done) {
          Future.delayed(const Duration(seconds: 1), () {
            if (recognizedWords.isNotEmpty) {
              print(recognizedWords);
              emit(VoiceProcessing());
            } else {
              emit(const VoiceInitial());
            }
          });
        }
      });
      _speechRepository.recognizedWords.listen((event) {
        recognizedWords = event;
        emit(VoiceRecognized(event));
      });
    } catch (e) {
      emit(VoiceError(e.toString()));
    }
  }

  void stopListening() {
    _speechRepository.stopListening();
    emit(const VoiceDone());
  }
}
