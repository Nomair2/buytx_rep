import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/main.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/videotime/video_time_cubiet.dart';
import 'package:buytx/src/chat/presentaion/pages/caption_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  static String name = 'cameraPage';

  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  int index = 0;

  Future<void> setFlashMode(FlashMode mode) async {
    if (_cameraController == null) {
      return;
    }

    try {
      await _cameraController!.setFlashMode(mode);
    } on CameraException catch (e) {
      rethrow;
    }
  }

  Future<void> startVideoRecording() async {
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await _cameraController.startVideoRecording();
      setState(() {});
    } on CameraException catch (e) {
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (_cameraController == null ||
        !_cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      XFile fileVideo = await _cameraController.stopVideoRecording();
      context.goNamed(
        CaptionPage.name,
        extra: CaptionParameter(
          bloc: context.read<messagesBloc>(),
          type: '',

          imagePath: fileVideo.path,
          partnerId: '123',
          isVideo: false,
          partnerName: "name",
          partnerPhoto: 'partnerPhoto',
        ),
      );

      return fileVideo;
    } on CameraException catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List flashsMode = [
      FlashMode.off,
      FlashMode.auto,
      FlashMode.always,
      FlashMode.torch,
    ];

    FlashMode flahMode = flashsMode[0];
    List<Widget> flashs = [
      Icon(Icons.flash_off, color: Colors.white, size: 28),
      Icon(Icons.flash_auto, color: Colors.white, size: 28),
      Icon(Icons.highlight, color: Colors.white, size: 28),
      Icon(Icons.flash_on, color: Colors.white, size: 28),
    ];
    return BlocProvider<VideoTimerCubit>(
      create: (context) => VideoTimerCubit(),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.8,
                        width: size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _cameraController != null &&
                                        _cameraController!
                                            .value
                                            .isRecordingVideo
                                    ? Colors.redAccent
                                    : Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: FutureBuilder(
                          future: cameraValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CameraPreview(_cameraController);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),

                      BlocBuilder<VideoTimerCubit, VideoTimerState>(
                        builder: (context, state) {
                          if (!state.isRecording)
                            return const SizedBox.shrink();
                          final minutes = (state.seconds ~/ 60)
                              .toString()
                              .padLeft(2, '0');
                          final seconds = (state.seconds % 60)
                              .toString()
                              .padLeft(2, '0');
                          return Center(
                            // top: 10,
                            child: Container(
                              width: 100,
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.topCenter,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "$minutes:$seconds",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Positioned(
                      bottom: 0.0,
                      child: Container(
                        // height: size.height * 0.15,
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 60,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // print(index);
                                    if (index < flashs.length) {
                                      index++;
                                    }
                                    if (index == flashs.length) {
                                      index = 0;
                                    }
                                    setFlashMode(flashsMode[index]);
                                    setState(() {});
                                  },
                                  child: flashs[index],
                                ),
                                InkWell(
                                  onTap: () async {
                                    _cameraController.value.isRecordingVideo
                                        ? await stopVideoRecording()
                                        : await takePicture();
                                  },
                                  child: Icon(
                                    // _cameraController.value.isRecordingVideo
                                    //     ? Icons.circle
                                    //     :
                                    Icons.panorama_fisheye_outlined,
                                    color:
                                        _cameraController.value.isRecordingVideo
                                            ? Colors.red
                                            : Colors.white,
                                    size: 70,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    for (var i in cameras) {
                                      if (_cameraController.description != i) {
                                        _cameraController.setDescription(i);
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.flip_camera_ios,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  startVideoRecording().then(
                                    (value) =>
                                        context
                                            .read<VideoTimerCubit>()
                                            .startTimer(),
                                  );
                                },
                                child: Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  takePicture() async {
    if (_cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      final XFile file = await _cameraController.takePicture();
      context.pushNamed(
        CaptionPage.name,
        extra: CaptionParameter(
          bloc: context.read<messagesBloc>(),
          type: '',
          imagePath: file.path,
          partnerId: '123',
          isVideo: false,
          partnerName: "name",
          partnerPhoto: 'partnerPhoto',
        ),
      );
    } on CameraException catch (e) {
      // print("there is error ");
      // print(e.toString());
      return null;
    }
  }
}
