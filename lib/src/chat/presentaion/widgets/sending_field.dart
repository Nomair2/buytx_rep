import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';
import 'package:buytx/src/chat/presentaion/pages/camera_page.dart';
import 'package:buytx/src/chat/presentaion/pages/caption_page.dart';
import 'package:buytx/src/chat/presentaion/pages/messages_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';

class SendingField extends StatefulWidget {
  SendingField({
    super.key,
    required this.sendField,
    required this.widget,
    required ImagePicker pickerImage,
  }) : _pickerImage = pickerImage;

  final TextEditingController sendField;
  final MessagesScreen widget;
  final ImagePicker _pickerImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  State<SendingField> createState() => _SendingFieldState();
}

class _SendingFieldState extends State<SendingField> {
  TextEditingController _messageController = TextEditingController();
  final _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _recordingPath;
  Duration _recordingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _messageController = widget.sendField;
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Microphone permission is required for recording'),
          ),
        );
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await Permission.microphone.isGranted) {
        final directory = await getTemporaryDirectory();
        _recordingPath =
            '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: _recordingPath!,
        );

        setState(() {
          _isRecording = true;
          _recordingDuration = Duration.zero;
        });

        _startDurationTimer();
      } else {
        await _initRecorder();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error starting recording: $e')));
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
      });

      if (path != null) {
        // Here you can handle the recorded audio file
        // For example, send it to your backend or process it
        print('Recording saved at: $path');

        // You might want to send the audio file to your chat
        // For example:
        // BlocProvider.of<messagesBloc>(context).add(
        //   SendAudioMessageEvent(
        //     audioPath: path,
        //     idReceiver: widget.userChatEntity!.id,
        //   ),
        // );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error stopping recording: $e')));
      }
    }
  }

  void _startDurationTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isRecording && mounted) {
        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
        _startDurationTimer();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
      // height: size.height * 0.09,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: _messageController,
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Builder(
                        builder:
                            (context) => IconButton(
                              onPressed: () {
                                if (_messageController.text.trim().isNotEmpty) {
                                  BlocProvider.of<messagesBloc>(context).add(
                                    SendMessageEvent(
                                      message: _messageController.text.trim(),
                                      idReceiver:
                                          widget.widget.userChatEntity!.id,
                                    ),
                                  );
                                  _messageController
                                      .clear(); // Clear the field after sending
                                }
                              },
                              icon: Icon(
                                Icons.send_outlined,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                              ),
                            ),
                      ),
                      hintText: 'اكتب رسالتك هنا...',
                      hintStyle: Theme.of(context).textTheme.labelMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        context.pushNamed(CameraPage.name);
                      },
                      child: Icon(
                        size: 25,
                        Icons.camera_alt_outlined,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles()
                            .then((value) {
                              if (value != null && value.files.isNotEmpty) {
                                String? filePath = value.files.single.path;
                                if (filePath == null) return;

                                String? mimeType = lookupMimeType(filePath);
                                File file = File(filePath);
                                print("the mimeType is ${mimeType}");
                                if (mimeType != null) {
                                  if (mimeType.startsWith('image/')) {
                                    print('This is an image: $mimeType');
                                    // context.pushNamed(
                                    //   CaptionPage.name,
                                    //   extra: CaptionParameter(
                                    //     type: '',
                                    //     bloc: context.read<messagesBloc>(),
                                    //     filePath!,
                                    //     '123',
                                    //     false,
                                    //     'partnerName',
                                    //     '',
                                    //   ),
                                    // );
                                  } else if (mimeType.startsWith('video/')) {
                                    print('This is a video: $mimeType');
                                    // context.pushNamed(
                                    //   CaptionPage.name,
                                    //   extra: CaptionParameter(
                                    //     type: '',
                                    //     bloc: context.read<messagesBloc>(),
                                    //     filePath!,
                                    //     '123',
                                    //     true,
                                    //     'partnerName',
                                    //     '',
                                    //   ),
                                    // );
                                  } else if (mimeType.startsWith('audio/')) {
                                    print(
                                      'This is an audio/recording: $mimeType',
                                    );
                                  } else {
                                    print('This is a general file: $mimeType');
                                  }
                                } else {
                                  print('Could not determine file type.');
                                }
                              }
                            });
                      },
                      child: Icon(
                        Icons.attach_file,
                        size: 25,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () async {
                        if (_isRecording) {
                          await _stopRecording();
                        } else {
                          await _startRecording();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child:
                            _isRecording
                                ? Icon(
                                  Icons.mic,
                                  key: const ValueKey('recording'),
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                )
                                : Icon(
                                  Icons.mic_none_sharp,
                                  size: 25,
                                  key: const ValueKey('not_recording'),
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAttachmentSheet(BuildContext context) {
    FilePicker.platform
        .pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
        )
        .then((result) {
          if (result == null) return;

          // setState(() {
          // You can add logic here to handle the file type
          // For example, you might want to check if it's an image or video
          // and handle them differently
          // });

          // You can use the result.files.single.path here
          // This will give you the path to the selected file
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error selecting file: $error')),
          );
        });
  }

  void _showAttachmentSheet2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,

      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
              bottom: Radius.circular(20),
            ),
          ),
          child: Wrap(
            spacing: 24,
            runSpacing: 20,
            children: [
              _buildAttachmentItem(
                Icons.insert_drive_file,
                'Document',
                Colors.indigo,
                () {},
              ),
              _buildAttachmentItem(
                Icons.audio_file,
                'Audio',
                Colors.indigo,
                () {},
              ),
              _buildAttachmentItem(Icons.image, 'Gallery', Colors.purple, () {
                // _pickImage(ImageSource.gallery, context);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentItem(
    IconData icon,
    String label,
    Color color,
    Function()? ontap,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 28,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

      //                    if (value != null && value.files.isNotEmpty) {
      //                           String path = value.files.single.path!;
      //                           String extension =
      //                               path.split('.').last.toLowerCase();
      //                           isImage = imageExtensions.contains(extension);
      //                           isVideo = videoExtensions.contains(extension);
      //                           if(isImage){
      //                         context.goNamed(
      //   CaptionPage.name,
      //   extra: CaptionParameter(
      //     path!,
      //     '123',
      //     false,
      //     'partnerName',
      //     '',
      //   ),
      // );
      //                       }
      //                       else if(isVideo){
      //                         context.goNamed(
      //   CaptionPage.name,
      //   extra: CaptionParameter(
      //     path,
      //     '123',
      //     true,
      //     'partnerName',
      //     '',
      //   ),
      // );
      //                       }
      //                       else if (){

      //                       }
      //                         }
    