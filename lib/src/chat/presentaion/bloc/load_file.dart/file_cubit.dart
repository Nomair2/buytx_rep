import 'dart:io';

import 'package:buytx/src/chat/presentaion/bloc/load_file.dart/file_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(InitialState());

  Future<String> LoadingFile(fileName, url) async {
    emit(LoadingFileState());
    try {
      // Get temporary directory
      final directory = await getTemporaryDirectory();

      // Clean up file name by removing query parameters and adding timestamp
      print(2);
      final cleanFileName =
          fileName.split('?').first; // Remove query parameters
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      print(3);
      final safeFileName = '${timestamp}_${cleanFileName.split('/').last}';
      print(4);

      final filePath = '${directory.path}/$safeFileName';
      print(filePath);
      // Download file
      final response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        // Save file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        emit(LoadedFileState());
        return filePath;
      } else {
        emit(FailureLoadedFileState());
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      emit(FailureLoadedFileState());
      print('Error downloading file: $e');
      throw Exception('Error downloading file: $e');
    }
  }
}
