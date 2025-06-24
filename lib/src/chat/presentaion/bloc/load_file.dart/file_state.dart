abstract class FileState {}

class InitialState extends FileState {}

class LoadingFileState extends FileState {}

class LoadedFileState extends FileState {}

class FailureLoadedFileState extends FileState {}
