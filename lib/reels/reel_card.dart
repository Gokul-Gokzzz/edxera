import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:edxera/reels/controller/reel_controller.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ReelCard extends StatefulWidget {
  // final ReelModel model;
  final bool play;
  final int index;

  const ReelCard({Key? key, required this.index, this.play = false})
      : super(key: key);

  @override
  State<ReelCard> createState() => _ReelCardState();
}

class _ReelCardState extends State<ReelCard> {
  ReelController reelController = Get.find();

  late VideoPlayerController _controller;
  bool isLoading = true;
  bool isError = false;
  bool isImage = false;
  late ChewieController chewieController;
  bool isLiked = false;
  bool isShowComment = false;
  bool isCommentLoading = false;

  TextEditingController commentController = TextEditingController();
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(
        Duration.zero,
        () {
          setState(() {
            isLiked = (reelController.reels[widget.index].isLiked ?? 0) == 0
                ? false
                : true;
          });
        },
      );
      await initializePlayer();
    });
  }

  Future<void> _toggleLike(int id) async {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      int newLike =
          (reelController.reels[widget.index].courseLikeCount ?? 0) + 1;
      reelController.reels[widget.index] =
          reelController.reels[widget.index].copyWith(courseLikeCount: newLike);
    } else {
      int newLike =
          (reelController.reels[widget.index].courseLikeCount ?? 0) - 1;
      reelController.reels[widget.index] =
          reelController.reels[widget.index].copyWith(courseLikeCount: newLike);
    }
    final result = await reelController.likeDislike(courseId: id);
    // setState(() {
    //   if (result) {
    //     isLiked = true;
    //   } else {
    //     isLiked = false;
    //   }
    // });
  }

  Future<void> _showComment() async {
    setState(() {
      isShowComment = !isShowComment;
    });
    node.requestFocus();
  }

  Future<void> _addComment(int id) async {
    setState(() {
      isCommentLoading = true;
    });
    final result = await reelController.addComment(
        courseId: id, comment: commentController.text);

    // if (result) {
    //   int newCount = (reelController.reels[widget.index].courseCommentCount ?? 0) + 1;
    //   reelController.reels[widget.index] = reelController.reels[widget.index].copyWith(courseCommentCount: newCount);
    // } else {
    //   int newCount = (reelController.reels[widget.index].courseCommentCount ?? 0) - 1;
    //   reelController.reels[widget.index] = reelController.reels[widget.index].copyWith(courseCommentCount: newCount);
    // }
    commentController.clear();
    setState(() {
      isShowComment = false;
      isCommentLoading = false;
    });
  }

  Future<void> initializePlayer() async {
    log((widget.index.toString()), name: "index");
    log(("${ApiConstants.publicBaseUrl}/${(reelController.reels[widget.index].courseReelVideo ?? "")}"),
        name: "initializePlayer");
    log(("${(reelController.reels[widget.index].title ?? "")}"),
        name: "initializePlayer");
    try {
      setState(() {
        isLoading = true;
      });
      final post = (reelController.reels[widget.index].courseReelVideo ?? "")
              .isEmpty
          ? ("${ApiConstants.publicBaseUrl}/${(reelController.reels[widget.index].courseThumbnail ?? "")}")
          : ("${ApiConstants.publicBaseUrl}/${(reelController.reels[widget.index].courseReelVideo ?? "")}");
      _controller = VideoPlayerController.networkUrl(Uri.parse(post));
      await _controller.initialize();

      ///useState after initialize video controller
      // if (!mounted) {
      // }

      _createChewieController();
    } on PlatformException catch (err) {
      setState(() {
        isError = true;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _createChewieController() {
    try {
      chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: _controller.value.aspectRatio,
        looping: false,
        hideControlsTimer: const Duration(seconds: 1),
        showControls: true,
        allowMuting: true,
      );
      if (widget.play) {
        _controller.play();
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    log(("${(reelController.reels[widget.index].title ?? "")}"),
        name: "dispose");

    chewieController.dispose();
    _controller.dispose();
  }

  void _showCommentsBottomSheet(int courseId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Comments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FutureBuilder(
                future: reelController.getComments(courseId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final users = snapshot.data ?? [];

                    return Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final item = users[index];
                          return ListTile(
                            title: Text(item.likedUserName ?? ""),
                            subtitle: Text(item.comment ?? ""),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No Users"),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLikeBottomSheet(int courseId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Likes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FutureBuilder(
                future: reelController.getLikes(courseId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final users = snapshot.data ?? [];

                    return Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final item = users[index];
                          return ListTile(
                            title: Text(item.likedUserName ?? ""),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No Users"),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = reelController.reels[widget.index];

    return SizedBox(
      height: isShowComment
          ? MediaQuery.sizeOf(context).height * 0.7
          : MediaQuery.sizeOf(context).height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: isLoading
                    ? Center(
                        child: SpinKitSquareCircle(
                          color: Colors.blue,
                          size: 70.0,
                        ),
                      )
                    : isError
                        ? CachedNetworkImage(
                            imageUrl:
                                "${ApiConstants.publicBaseUrl}/${item.courseThumbnail}",
                            progressIndicatorBuilder:
                                (context, url, progress) => SizedBox(
                              height: 300,
                              child: Center(
                                child: SpinKitFadingCircle(
                                  color: Colors.blue,
                                  size: 50.0,
                                ),
                              ),
                            ),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.broken_image),
                          )
                        : AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Chewie(controller: chewieController),
                          ),
              ),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/app_logo.jpeg'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Edxera',
                        // item.courseName ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null),
                onPressed: () => _toggleLike(item.id!),
              ),
              GestureDetector(
                onTap: () => _showLikeBottomSheet(item.id!),
                child: Text("${item.courseLikeCount ?? 0}"),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: _showComment,
              ),
              GestureDetector(
                onTap: () => _showCommentsBottomSheet(item.id!),
                child: Text("${item.courseCommentCount ?? 0}"),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  final post = (item.courseReelVideo ?? "").isEmpty
                      ? ("${ApiConstants.publicBaseUrl}/${(item.courseThumbnail ?? "")}")
                      : ("${ApiConstants.publicBaseUrl}/${(item.courseReelVideo ?? "")}");
                  Share.shareUri(Uri.parse(post));
                },
              ),
            ],
          ),
          if (isShowComment)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: commentController,
                focusNode: node,
                decoration: InputDecoration(
                  hintText: 'Comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  suffixIcon: isCommentLoading
                      ? SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 20.0,
                        )
                      : IconButton(
                          onPressed: () async {
                            _addComment(item.id!);
                          },
                          icon: Icon(Icons.send),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
