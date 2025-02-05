import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/reels/model/reel_model.dart';
import 'package:flutter/material.dart';

import '../repositories/api/api_constants.dart';

class ThumbnailPlayer extends StatefulWidget {
  final ReelModel model;

  ThumbnailPlayer(this.model);

  @override
  State<ThumbnailPlayer> createState() => _ThumbnailPlayerState();
}

class _ThumbnailPlayerState extends State<ThumbnailPlayer> {
  // late VideoPlayerController _thumbnailController;
  @override
  void initState() {
    super.initState();
    // final isImage = widget.model.postType == PostViewType.IMAGE_TEXT || widget.model.postType == PostViewType.IMAGE;
    //
    // final post = (assetBaseUrl + (widget.model.vchrVideo ?? ''));
    // print(post);
    // _thumbnailController = VideoPlayerController.networkUrl(Uri.parse(post));
    // _thumbnailController.addListener(() {
    //   setState(() {});
    // });
    // _thumbnailController.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    // _thumbnailController.dispose();
    // _thumbnailController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isImage = (widget.model.courseReelVideo ?? "").isEmpty;
    return isImage
        ? Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: "${ApiConstants.publicBaseUrl}/${widget.model.courseThumbnail!}",
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.white,
                  )),
            ],
          )
        : Container(
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 6,
            child: Stack(
              children: [
                (widget.model.courseThumbnail ?? "").isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: "${ApiConstants.publicBaseUrl}/${widget.model.courseThumbnail!}",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            "assets/thumbnail_placholder.png",
                            height: 100,
                            width: 100,
                          );
                        },
                      )
                    : Center(
                        child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          "assets/thumbnail_placholder.png",
                          // height: 100,
                          // width: 100,
                        ),
                      )),
                // VideoPlayer(_thumbnailController),
                const Center(
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
