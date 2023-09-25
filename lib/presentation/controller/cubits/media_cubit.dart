import 'package:flutter_bloc/flutter_bloc.dart';

enum MediaState { initial, loading, success, error }

class MediaCubit extends Cubit<MediaState> {
  MediaCubit() : super(MediaState.initial);

  List<Map<String, dynamic>> mediaList = [];

  void loadMedia(List<Map<String, dynamic>> mediaList) {
    emit(MediaState.loading);

    this.mediaList = mediaList;
    emit(MediaState.success);
  }

  void clearMedia() {
    emit(MediaState.initial);

    mediaList = [];
  }
}
