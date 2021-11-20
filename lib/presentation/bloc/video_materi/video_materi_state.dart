part of 'video_materi_cubit.dart';

abstract class VideoMateriState extends Equatable {
  const VideoMateriState();
}

class VideoMateriInitial extends VideoMateriState {
  @override
  List<Object?> get props => [];
}

class PostVideoMateriLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class DeleteVideoMateriLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class PostVideoMateriSuccess extends VideoMateriState {
  final String message;
  const PostVideoMateriSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteVideoMateriSuccess extends VideoMateriState {
  final String message;
  const DeleteVideoMateriSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class VideoMateriError extends VideoMateriState {
  final String message;
  const VideoMateriError(this.message);
  @override
  List<Object> get props => [message];
}

class GetVideoMateriPostsByUidLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class GetVideoMateriPostsByUidSuccess extends VideoMateriState {
  final List<VideoMateri> videoMateriList;
  const GetVideoMateriPostsByUidSuccess(this.videoMateriList);
  @override
  List<Object> get props => [videoMateriList];
}

class GetVideoMateriPostsByUidError extends VideoMateriState {
  final String message;
  const GetVideoMateriPostsByUidError(this.message);

  @override
  List<Object> get props => [message];
}
