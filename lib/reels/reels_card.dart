import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:edxera/reels/controller/reel_controller.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelCard extends StatefulWidget {
  final int index;
  final bool isCurrent;
  const ReelCard({Key? key, required this.index, required this.isCurrent})
      : super(key: key);

  @override
  _ReelCardState createState() => _ReelCardState();
}

class _ReelCardState extends State<ReelCard> {
  final reelController = Get.put(ReelController());

  VideoPlayerController? _videoController;
  YoutubePlayerController? _youtubeController;
  bool isLoading = true;
  bool _isVideoPlaying = false;
  bool isError = false;
  bool isImage = false;

  // ChewieController? _chewieController;
  bool isLiked = false;
  bool isShowComment = false;
  bool isCommentLoading = false;
  bool _isInitialized = false;
  bool _isYoutubeVideo = false;
  //  bool _isMuted = true;

  TextEditingController commentController = TextEditingController();
  FocusNode node = FocusNode();
  @override
  void didUpdateWidget(covariant ReelCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrent) {
      _videoController?.pause();
      _youtubeController?.pause();
      _isVideoPlaying = false;
      // if (!_isInitialized && !isLoading && !_isYoutubeVideo) {
      //   _videoController?.play();
      // } else if (_isYoutubeVideo && _youtubeController != null) {
      //   _youtubeController!.play();
      // }
    }
    // else {
    //   _videoController?.pause();
    //   _youtubeController?.pause();
    // }
  }

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
      // _isMuted = true;
      initializePlayer();
    });
  }

  Future<void> initializePlayer() async {
    log((widget.index.toString()), name: "index");
    final item = reelController.reels[widget.index];

    if (item.courseReelYoutubeLink != null &&
        item.courseReelYoutubeLink!.isNotEmpty) {
      _isYoutubeVideo = true;
      String? videoId =
          YoutubePlayer.convertUrlToId(item.courseReelYoutubeLink!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } else if (item.courseReelVideo != null &&
        item.courseReelVideo!.isNotEmpty) {
      _isYoutubeVideo = false;
      log(("${ApiConstants.publicBaseUrl}/${(item.courseReelVideo)}"),
          name: "initializePlayer");
      try {
        setState(() {
          isLoading = true;
        });

        final post = "${ApiConstants.publicBaseUrl}/${item.courseReelVideo}";
        _videoController = VideoPlayerController.networkUrl(Uri.parse(post));
        await _videoController!.initialize();

        if (mounted) {
          setState(() => _isInitialized = true);
          _videoController!.setLooping(true);
        }

        // _createChewieController();
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
    } else {
      _isYoutubeVideo = false;
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  // void _createChewieController() {
  //   try {
  //     // if (!mounted || _chewieController != null) return;
  //     // final item = reelController.reels[widget.index];

  //     // /// Dispose previous controller if exists
  //     // _chewieController?.dispose();

  //     // _chewieController = ChewieController(
  //     //   videoPlayerController: _videoController!,
  //     //   aspectRatio: _videoController!.value.aspectRatio,
  //     //   hideControlsTimer: const Duration(seconds: 1),
  //     //   showControls: true,
  //     //   allowMuting: true,
  //     // );

  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  void dispose() {
    super.dispose();

    // if (_chewieController != null) {
    //   _chewieController!.dispose();
    // }
    if (_videoController != null) {
      _videoController!.dispose();
    }
    if (_youtubeController != null) {
      _youtubeController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = reelController.reels[widget.index];

    return VisibilityDetector(
      key: ValueKey(item.courseReelId),
      onVisibilityChanged: (VisibilityInfo info) {
        if (widget.isCurrent && info.visibleFraction > 0.8) {
          if (!_isVideoPlaying && _videoController != null && _isInitialized) {
            // _chewieController!.play();
            _videoController!.play();
            _isVideoPlaying = true;
          }
        } else {
          if (_isVideoPlaying && _youtubeController != null) {
            _youtubeController!.pause();
            _isVideoPlaying = false;
          } else if (_isVideoPlaying && _youtubeController != null) {
            _youtubeController!.pause();
            _isVideoPlaying = false;
          }
        }
      },
      child: Container(
        color: Colors.white, // Set background color to transparent
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox.expand(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : isError
                      ? Center(
                          child: CachedNetworkImage(
                            imageUrl:
                                "${ApiConstants.publicBaseUrl}/${item.courseThumbnail}",
                            progressIndicatorBuilder:
                                (context, url, progress) => const Center(
                                    child: CircularProgressIndicator()),
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.broken_image),
                          ),
                        )
                      : _isYoutubeVideo && _youtubeController != null
                          ? YoutubePlayer(
                              controller: _youtubeController!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              aspectRatio: 9 / 16,
                            )
                          : _videoController != null && _isInitialized
                              ? VideoPlayer(_videoController!)
                              : const Center(
                                  child: Text("No video or Youtube link")),
            ),

            // User info & caption (Bottom Left)
            Positioned(
              bottom: 80, // Adjust spacing from bottom
              left: 16,
              child: SafeArea(
                // Use SafeArea to avoid overlapping system UI
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/app_logo.jpeg'),
                          radius: 20, // Adjust avatar size
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Edxera", // Replace with actual username
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.white, // Text color for better contrast
                            shadows: [
                              // Add shadows for better readability on video
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16, // Slightly smaller font size
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Right-side action buttons
            Positioned(
              bottom: 200,
              right: 16,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.black),
                          onPressed: () {
                            _toggleLike(item.courseId!, item.courseReelId!);
                          },
                        ),
                        GestureDetector(
                          onTap: () => _showLikeBottomSheet(
                              item.courseId!, item.courseReelId!),
                          child: Text("${item.courseReelLikeCount ?? 0}"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {
                          _showCommentsBottomSheet(
                              item.courseId!, item.courseReelId!);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          _showCommentsBottomSheet(
                              item.courseId!, item.courseReelId!);
                        },
                        child: Text("${item.courseReelCommentCount ?? 0}"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          String postUrl;

                          if (item.courseReelYoutubeLink != null &&
                              item.courseReelYoutubeLink!.isNotEmpty) {
                            // Share the YouTube link if available
                            postUrl = item.courseReelYoutubeLink!;
                          } else if (item.courseReelVideo != null &&
                              item.courseReelVideo!.isNotEmpty) {
                            // Share the normal video link
                            postUrl =
                                "${ApiConstants.publicBaseUrl}/${item.courseReelVideo}";
                          } else {
                            // Share the thumbnail if no video is available
                            postUrl =
                                "${ApiConstants.publicBaseUrl}/${item.courseThumbnail ?? ""}";
                          }

                          // Custom message with app logo, app name, and text
                          String message = """
        📚 *${item.title}*  
        🔥 Check out this amazing course on Edxera!
        $postUrl
        📲 Download our app for more
        
        """;

                          Share.share(message);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  //   Column(
                  //     children: [
                  //       const Icon(Icons.more_vert, color: Colors.white, size: 30),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleLike(int id, int courseReelId) async {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      int newLike =
          (reelController.reels[widget.index].courseReelLikeCount ?? 0) + 1;
      reelController.reels[widget.index] =
          reelController.reels[widget.index].copyWith(courseLikeCount: newLike);
    } else {
      int newLike =
          (reelController.reels[widget.index].courseReelLikeCount ?? 0) - 1;
      reelController.reels[widget.index] =
          reelController.reels[widget.index].copyWith(courseLikeCount: newLike);
    }
    final result = await reelController.likeDislike(
        courseId: id, courseReelId: courseReelId);
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

  Future<void> _addComment(int courseId, int courseReelId) async {
    setState(() {
      isCommentLoading = true;
    });
    final result = await reelController.addComment(
        courseId: courseId,
        comment: commentController.text,
        courseReelId: courseReelId);

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

  void _showCommentsBottomSheet(int courseId, int courseReelId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Important for keyboard and long lists
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder for updating the bottom sheet
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height *
                  0.6, // Adjust height as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Comments",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    // Use Expanded to fill available space
                    child: FutureBuilder(
                      future:
                          reelController.getComments(courseId, courseReelId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          final comments = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return ListTile(
                                title: Text(comment.likedUserName ?? ""),
                                subtitle: Text(comment.comment ?? ""),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("No Comments"));
                        }
                      },
                    ),
                  ),
                  // Comment input area
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            focusNode: node,
                            decoration: const InputDecoration(
                              hintText: 'Add a comment...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              // Update the bottom sheet state
                              isCommentLoading = true;
                            });
                            await _addComment(courseId, courseReelId);
                            setState(() {
                              isCommentLoading = false;
                            });
                          },
                          icon: isCommentLoading
                              ? const CircularProgressIndicator() // Show indicator while loading
                              : const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showLikeBottomSheet(int courseId, int courseReelId) {
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
                future: reelController.getLikes(courseId, courseReelId),
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
}
