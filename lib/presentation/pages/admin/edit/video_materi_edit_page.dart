import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';
import 'package:video_player/video_player.dart';

class VideoMateriEditPage extends StatefulWidget {
  static const routeName = '/admin-video-materi-edit';
  final String postId;
  const VideoMateriEditPage({Key? key, required this.postId}) : super(key: key);

  @override
  _VideoMateriEditPageState createState() => _VideoMateriEditPageState();
}

class _VideoMateriEditPageState extends State<VideoMateriEditPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  VideoPlayerController? _videoController;
  File? videoFile;
  bool isValidate = false;

  void formCheck() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        videoFile != null) {
      if (isValidate) {
        return;
      } else {
        setState(() {
          isValidate = true;
        });
      }
    } else {
      setState(() {
        isValidate = false;
      });
    }
  }

  void videoPlayerInit(File videoFile) {
    _videoController = VideoPlayerController.file(videoFile)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..setLooping(false)
      ..initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRichWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kRichBlack,
            size: 20,
          ),
        ),
        title: Text(
          'Tambah Video Materi',
          style: kTextTheme.subtitle1!.copyWith(
            fontSize: 16,
            color: kRichBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                label: const Text('Judul'),
                hintText: 'Masukkan judul',
                hintStyle: kTextTheme.bodyText2!.copyWith(
                  color: kLightGrey,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                Timer(const Duration(milliseconds: 750), () {
                  formCheck();
                });
              },
              style: kTextTheme.bodyText2!.copyWith(
                color: kRichBlack,
              ),
              autofocus: false,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                label: const Text('Deskripsi'),
                hintText: 'Masukkan deskripsi',
                hintStyle: kTextTheme.bodyText2!.copyWith(
                  color: kLightGrey,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                Timer(const Duration(milliseconds: 750), () {
                  formCheck();
                });
              },
              style: kTextTheme.bodyText2!.copyWith(
                color: kRichBlack,
              ),
              autofocus: false,
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: kMikadoOrange,
                ),
              ),
              child: videoFile != null && _videoController != null
                  ? _videoController!.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _videoController!.value.isPlaying
                                  ? _videoController!.pause()
                                  : _videoController!.play();
                            },
                            onLongPress: () {
                              setState(() {
                                _videoController = null;
                              });
                            },
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                AspectRatio(
                                  aspectRatio:
                                      _videoController!.value.aspectRatio,
                                  child: VideoPlayer(
                                    _videoController!,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: _videoController!.value.isPlaying
                                        ? Container()
                                        : Container(
                                            alignment: Alignment.center,
                                            color: Colors.black26,
                                            child: const Icon(
                                              Icons.play_arrow,
                                              color: kRichWhite,
                                              size: 80,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kMikadoOrange,
                            ),
                          ),
                        )
                  : InkWell(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.video,
                        );
                        if (result == null) return;
                        videoFile = File(result.files.first.path!);
                        videoPlayerInit(videoFile!);
                        formCheck();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              color: kLightGrey,
                              size: 35,
                            ),
                            Text(
                              'Unggah Video',
                              style: kTextTheme.bodyText2!.copyWith(
                                color: kLightGrey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 15),
            PrimaryButton(
              borderRadius: 10,
              child: SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    'Simpan',
                    style: kTextTheme.button!.copyWith(
                      color: kRichWhite,
                    ),
                  ),
                ),
              ),
              onPressed: !isValidate ? null : () {},
            ),
          ],
        ),
      ),
    );
  }
}