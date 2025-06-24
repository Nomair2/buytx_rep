import 'package:flutter/material.dart';

class FlashCamera extends StatefulWidget {
  FlashCamera({super.key});

  @override
  State<FlashCamera> createState() => _FlashCameraState();
}

class _FlashCameraState extends State<FlashCamera> {
  int index = 0;

  List<IconData> flashs = [
    Icons.flash_off,
    Icons.flash_auto,
    Icons.highlight,
    Icons.flash_on,
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        index == flashs.length ? index++ : index = 0;
        setState(() {});
      },
      child: Icon(flashs[index], color: Colors.white, size: 28),
    );
  }
}

// Widget _flashModeControlRowWidget() {
//   return ClipRect(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.flash_off),
//           color:
//               controller?.value.flashMode == FlashMode.off
//                   ? Colors.orange
//                   : Colors.blue,
//           onPressed:
//               controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.off)
//                   : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.flash_auto),
//           color:
//               controller?.value.flashMode == FlashMode.auto
//                   ? Colors.orange
//                   : Colors.blue,
//           onPressed:
//               controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.auto)
//                   : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.flash_on),
//           color:
//               controller?.value.flashMode == FlashMode.always
//                   ? Colors.orange
//                   : Colors.blue,
//           onPressed:
//               controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.always)
//                   : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.highlight),
//           color:
//               controller?.value.flashMode == FlashMode.torch
//                   ? Colors.orange
//                   : Colors.blue,
//           onPressed:
//               controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.torch)
//                   : null,
//         ),
//       ],
//     ),
//   );}
