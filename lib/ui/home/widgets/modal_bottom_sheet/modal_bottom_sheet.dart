import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/voice/voice_cubit.dart';
import '../../../../extensions/capitalize.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VoiceBottomSheet extends StatelessWidget {
  const VoiceBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocConsumer<VoiceCubit, VoiceState>(
          listener: (context, state) {
        if (state is VoiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is VoiceDone) {
          Navigator.of(context).pop();
        }
      }, builder: (context, VoiceState state) {
        const animationDuration =
            Duration(milliseconds: 3000);
        return Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
            child: Center(
              child: state is VoiceInitial
                  ? const AnimatedSwitcher(
                      duration: animationDuration,
                      child: Text(
                        'Say something like "Turn on the light in living room"',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : state is VoiceListening
                      ? const Text(
                          'Listening...',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      : state is VoiceRecognized
                          ? AnimatedSwitcher(
                              duration: animationDuration,
                              child: Text(
                                state.recognizedText
                                    .capitalize(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold),
                              ),
                            )
                          : state is VoiceProcessing
                              ? AnimatedTextKit(
                                  animatedTexts: [
                                    FadeAnimatedText(
                                      'Processing...',
                                      textStyle:
                                          const TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                                  FontWeight
                                                      .bold),
                                      duration:
                                          animationDuration,
                                    ),
                                    FadeAnimatedText(
                                      'Wait a moment',
                                      textStyle:
                                          const TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                                  FontWeight
                                                      .bold),
                                      duration:
                                          animationDuration,
                                    ),
                                    FadeAnimatedText(
                                      'Almost done!',
                                      textStyle:
                                          const TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                                  FontWeight
                                                      .bold),
                                      duration:
                                          animationDuration,
                                    ),
                                    FadeAnimatedText(
                                      'Just a second',
                                      textStyle:
                                          const TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                                  FontWeight
                                                      .bold),
                                      duration:
                                          animationDuration,
                                    ),
                                  ],
                                  isRepeatingAnimation:
                                      true,
                                )
                              : state is VoiceResponse
                                  ? Text(
                                      state.response
                                          .capitalize(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight:
                                              FontWeight
                                                  .bold),
                                    )
                                  : state is VoiceError
                                      // ignore: prefer_const_constructors
                                      ? AnimatedSwitcher(
                                          duration:
                                              animationDuration,
                                          child: const Text(
                                            "something went wrong",
                                            style: TextStyle(
                                                fontSize:
                                                    20,
                                                fontWeight:
                                                    FontWeight
                                                        .bold),
                                          ),
                                        )
                                      : const AnimatedSwitcher(
                                          duration:
                                              animationDuration,
                                          child: Text(
                                            'Say something like "Turn on the light in the living room"',
                                            style: TextStyle(
                                                fontSize:
                                                    20,
                                                fontWeight:
                                                    FontWeight
                                                        .bold),
                                          ),
                                        ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<VoiceCubit>(context)
                      .stopListening();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).focusColor,
                )),
          ),
          //bottom center voice assistant button
          Align(
            alignment: Alignment.bottomCenter,
            child: state is VoiceInitial ||
                    state is VoiceResponse
                ? Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10),
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<VoiceCubit>(context)
                            .startListening();
                      },
                      icon: Icon(Icons.mic,
                          color:
                              Theme.of(context).focusColor,
                          size: 30),
                    ),
                  )
                : state is VoiceListening ||
                        state is VoiceRecognized
                    ? Padding(
                        padding: const EdgeInsets.only(
                            bottom: 25),
                        //show voice assistant animation
                        child:
                            LoadingAnimationWidget.waveDots(
                                color: Theme.of(context)
                                    .cardColor,
                                size: 50))
                    : state is VoiceProcessing
                        ? Padding(
                            padding: const EdgeInsets.only(
                                bottom: 25),
                            child: LoadingAnimationWidget
                                .horizontalRotatingDots(
                              size: 40,
                              color: Theme.of(context)
                                  .focusColor,
                            ),
                          )
                        : const SizedBox(),
          ),
        ]);
      }),
    );
  }
}
