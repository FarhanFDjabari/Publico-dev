import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/usecases/admin/delete_video_post.dart';
import 'package:publico/domain/usecases/admin/post_video_materi.dart';

part 'video_materi_state.dart';

class VideoMateriCubit extends Cubit<VideoMateriState> {
  VideoMateriCubit(
      {required this.postVideoMateri, required this.deleteVideoPost})
      : super(VideoMateriInitial());

  final PostVideoMateri postVideoMateri;
  final DeleteVideoPost deleteVideoPost;

  void postVideoMateriFirestore(
      String title,
      String description,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration) async {
    emit(PostVideoMateriLoading());
    final result = await postVideoMateri.execute(
        title,
        description,
        videoDestination,
        thumbnailDestination,
        videoFile,
        thumbnailFile,
        duration);
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) =>
          emit(const PostVideoMateriSuccess("Video materi berhasil diposting")),
    );
  }

  void deleteVideoMateriFirestore(String id, String videoUrl,
      String thumbnailUrl, String collectionPath) async {
    emit(DeleteVideoMateriLoading());
    final result = await deleteVideoPost.execute(
      id,
      videoUrl,
      thumbnailUrl,
      collectionPath,
    );
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) => emit(
          const DeleteVideoMateriSuccess('Berhasil menghapus video materi')),
    );
  }
}
