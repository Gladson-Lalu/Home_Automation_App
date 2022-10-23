import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/service/dialogflow_service.dart';
import '../../domain/repository/speech/speech_repository.dart';

part 'voice_state.dart';

class VoiceCubit extends Cubit<VoiceState> {
  final SpeechRepository _speechRepository;
  final DialogflowService _dialogflowService;
  String recognizedWords = '';

  VoiceCubit(
      this._speechRepository, this._dialogflowService)
      : super(const VoiceInitial()) {
    try {
      _speechRepository.listeningState.listen((event) {
        if (event == SpeechState.listening) {
          emit(const VoiceListening());
        } else if (event == SpeechState.done) {
          Future.delayed(const Duration(seconds: 1),
              () async {
            if (recognizedWords.isNotEmpty) {
              emit(const VoiceProcessing());
              final QueryResult response =
                  await _dialogflowService
                      .getIntent(recognizedWords);

              String replayMessage =
                  'I am sorry, I did not understand that';
              if (response.fulfillmentMessages != null) {
                replayMessage = response
                    .fulfillmentMessages![0].text!.text![0];
              }
              emit(VoiceResponse(replayMessage));
              if (response.action != null &&
                  response.action!
                      .startsWith('smarthome') &&
                  response.allRequiredParamsPresent ==
                      true) {
                // final String action =
                //     response.action!.split('.').last;
                // print(action);
                // print(response.parameters);
                // print(replayMessage);
                emit(const VoiceDone());
              }
            } else {
              emit(const VoiceInitial());
            }
          });
        }
      });
      _speechRepository.recognizedWords.listen((value) {
        recognizedWords = value;
        emit(VoiceRecognized(value));
      });
    } catch (e) {
      VoiceError(e.toString());
    }
  }

  void startListening() {
    try {
      recognizedWords = '';
      emit(const VoiceInitial());
      _speechRepository.startListening();
    } catch (e) {
      emit(VoiceError(e.toString()));
    }
  }

  void stopListening() {
    _speechRepository.stopListening();
    emit(const VoiceDone());
  }
}
