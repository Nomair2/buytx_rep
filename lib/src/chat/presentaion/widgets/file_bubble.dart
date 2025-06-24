import 'dart:io';

import 'package:buytx/src/chat/presentaion/bloc/load_file.dart/file_cubit.dart';
import 'package:buytx/src/chat/presentaion/bloc/load_file.dart/file_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

class FileBubble extends StatelessWidget {
  final String fileName;
  final String url;
  final bool isSentByMe;
  const FileBubble({
    super.key,
    required this.fileName,
    required this.url,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileCubit(),
      child: GestureDetector(
        onTap: () async {
          try {
            print("1");
            // Show loading indicator
            String localPath = await context.read<FileCubit>().LoadingFile(
              fileName,
              url,
            );
            print(localPath);

            // Open downloaded file
            final result = await OpenFilex.open(localPath);
            print(result.message);
            print(result.type);

            if (result.type != ResultType.done) {
              print(result.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black26,
                  content: Text('Error opening file: ${result.message}'),
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $e')));
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color:
                isSentByMe
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.insert_drive_file,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  fileName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              BlocBuilder<FileCubit, FileState>(
                builder: (context, state) {
                  if (state is LoadingFileState) {
                    return CircularProgressIndicator();
                  }
                  return Icon(
                    Icons.download,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  );
                  // TODO: implement listener
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
