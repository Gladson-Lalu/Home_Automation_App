import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_automation/config/sample_devices.dart';
import 'package:home_automation/cubit/voice/voice_cubit.dart';
import 'package:home_automation/domain/model/device.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:home_automation/ui/home/widgets/app_bar/custom_sliver_appbar.dart';

import 'widgets/drawer/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedRoomIndex;
  @override
  void initState() {
    super.initState();
    selectedRoomIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator:
          FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      //voice assistant button at bottom center
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        //voice assistant button
        child: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            BlocProvider.of<VoiceCubit>(context)
                .startListening();
            //show voice assistant in bottom sheet

            showModalBottomSheet(
                isDismissible: false,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                backgroundColor:
                    Theme.of(context).backgroundColor,
                context: context,
                builder: (ctx) {
                  const animationDuration =
                      Duration(milliseconds: 3000);
                  return BlocConsumer<VoiceCubit,
                          VoiceState>(
                      listener: (context, state) {
                    if (state is VoiceError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                        content: Text(state.error),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20)),
                        margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context)
                                    .size
                                    .height -
                                100),
                      ));
                    } else if (state is VoiceDone) {
                      Navigator.of(context).pop();
                    }
                  }, builder: (context, VoiceState state) {
                    return SizedBox(
                      height: 300,
                      child: Stack(children: [
                        Center(
                          child: state is VoiceInitial
                              ? const AnimatedSwitcher(
                                  duration:
                                      animationDuration,
                                  child: Text(
                                    'Say something like "Turn on the light"',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight:
                                            FontWeight
                                                .bold),
                                  ),
                                )
                              : state is VoiceListening
                                  ? const AnimatedSwitcher(
                                      duration:
                                          animationDuration,
                                      child: Text(
                                        'Listening...',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                                FontWeight
                                                    .bold),
                                      ),
                                    )
                                  : state is VoiceRecognized
                                      ? AnimatedSwitcher(
                                          duration:
                                              animationDuration,
                                          child: Text(
                                            state
                                                .recognizedText,
                                            style: const TextStyle(
                                                fontSize:
                                                    20,
                                                fontWeight:
                                                    FontWeight
                                                        .bold),
                                          ),
                                        )
                                      : state is VoiceProcessing
                                          ? AnimatedTextKit(
                                              animatedTexts: [
                                                FadeAnimatedText(
                                                  'Processing...',
                                                  textStyle: const TextStyle(
                                                      fontSize:
                                                          20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  duration:
                                                      animationDuration,
                                                ),
                                                FadeAnimatedText(
                                                  'Wait a moment',
                                                  textStyle: const TextStyle(
                                                      fontSize:
                                                          20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  duration:
                                                      animationDuration,
                                                ),
                                                FadeAnimatedText(
                                                  'Almost done!',
                                                  textStyle: const TextStyle(
                                                      fontSize:
                                                          20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  duration:
                                                      animationDuration,
                                                ),
                                                FadeAnimatedText(
                                                  'Just a second',
                                                  textStyle: const TextStyle(
                                                      fontSize:
                                                          20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  duration:
                                                      animationDuration,
                                                ),
                                              ],
                                              isRepeatingAnimation:
                                                  true,
                                            )
                                          : state is VoiceError
                                              ? Text(
                                                  state
                                                      .error,
                                                  style: const TextStyle(
                                                      fontSize:
                                                          20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : const Text(
                                                  'Say something like "Turn on the light"',
                                                  style: TextStyle(
                                                      fontSize:
                                                          20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                BlocProvider.of<VoiceCubit>(
                                        context)
                                    .stopListening();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context)
                                    .focusColor,
                              )),
                        ),
                        //bottom center voice assistant button
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: state is VoiceInitial
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(
                                          bottom: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<
                                                  VoiceCubit>(
                                              context)
                                          .startListening();
                                    },
                                    icon: Icon(Icons.mic,
                                        color: Theme.of(
                                                context)
                                            .focusColor,
                                        size: 30),
                                  ),
                                )
                              : state is VoiceListening ||
                                      state
                                          is VoiceRecognized
                                  ? Padding(
                                      padding: const EdgeInsets
                                          .only(bottom: 25),
                                      //show voice assistant animation
                                      child: LoadingAnimationWidget
                                          .waveDots(
                                              color: Theme.of(
                                                      context)
                                                  .cardColor,
                                              size: 50))
                                  : state is VoiceProcessing
                                      ? Padding(
                                          padding:
                                              const EdgeInsets
                                                      .only(
                                                  bottom:
                                                      25),
                                          child: LoadingAnimationWidget
                                              .horizontalRotatingDots(
                                            size: 40,
                                            color: Theme.of(
                                                    context)
                                                .focusColor,
                                          ),
                                        )
                                      : const SizedBox(),
                        ),
                      ]),
                    );
                  });
                });
          },
          backgroundColor:
              Theme.of(context).backgroundColor,
          child: Icon(Icons.mic,
              color: Theme.of(context).focusColor),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      //title: 'Home Automation' and weather widget in flexible space
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: CustomScrollView(
          slivers: [
            //sized box for app bar
            const CustomSliverAppBar(),
            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            //tabs of rooms
            buildRoomHeader(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            //smart devices
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Smart Devices',
                  style:
                      Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            //list of devices
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.width *
                          0.03,
                  vertical: 10),
              sliver: buildGridList(),
            ),
            //Sized box
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  SliverGrid buildGridList() {
    return SliverGrid(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return buildDeviceCard(context,
              sampleDevices[selectedRoomIndex][index]);
        },
        childCount: sampleDevices[selectedRoomIndex].length,
      ),
    );
  }

  SliverToBoxAdapter buildRoomHeader() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
        child: ListView.builder(
          padding:
              const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: sampleDevices.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selectedRoomIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.symmetric(
                    horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selectedRoomIndex == index
                        ? Theme.of(context).focusColor
                        : Theme.of(context).backgroundColor,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 0),
                  child: Center(
                    child: Text(
                        sampleDevices[index][0].room,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.w500)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDeviceCard(
      BuildContext context, ElectronicDevice device) {
    return Container(
      padding: const EdgeInsets.only(
          left: 15, right: 0, top: 20, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .shadowColor
                .withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/device/${device.icon}.png',
                height: 52,
                width: 52,
                color: Theme.of(context).focusColor,
                fit: BoxFit.cover,
              ),
              Switch(
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
                value: device.state,
                onChanged: (value) {
                  setState(() {
                    device.state = value;
                  });
                },
                activeColor: Theme.of(context).focusColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            device.name,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
