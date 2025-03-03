import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/Models/category_wise_reels_model.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class TrendingScreen extends StatefulWidget {
  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  HomeController homecontroller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await homecontroller.getReelCategoryWise();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Trending',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await homecontroller.getReelCategoryWise();
        },
        child: Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: homecontroller.categoryWiseReelData.value.data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = homecontroller.categoryWiseReelData.value.data?[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '#${item?.courseTitle ?? "Unknown"}',
                      maxLines: 2,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (item?.reelsList ?? []).length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, i) {
                        final reelItem = (item?.reelsList ?? [])[i];
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => TrendingReelCard(
                                item: reelItem,
                                reelIndex: i,
                                courseIndex: index,
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 200,
                            margin: EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl: (reelItem.courseReelThumbnail ?? "").isEmpty
                                    ? ""
                                    : "${ApiConstants.publicBaseUrl}/${reelItem.courseReelThumbnail}",
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_not_supported,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

class TrendingReelCard extends StatefulWidget {
  final ReelsList item;
  final int reelIndex;
  final int courseIndex;

  const TrendingReelCard({
    Key? key,
    required this.item,
    required this.reelIndex,
    required this.courseIndex,
  }) : super(key: key);

  @override
  _TrendingReelCardState createState() => _TrendingReelCardState();
}

class _TrendingReelCardState extends State<TrendingReelCard> {
  HomeController homecontroller = Get.find<HomeController>();
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
  // @override
  // void didUpdateWidget(covariant TrendingReelCard oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.isCurrent) {
  //     _videoController?.pause();
  //     _youtubeController?.pause();
  //     _isVideoPlaying = false;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(
        Duration.zero,
        () {
          setState(() {
            isLiked =
                (homecontroller.categoryWiseReelData.value.data![widget.courseIndex].reelsList![widget.reelIndex].isLiked ?? 0) == 0 ? false : true;
          });
        },
      );
      // _isMuted = true;
      initializePlayer();
    });
  }

  Future<void> initializePlayer() async {
    final item = widget.item;

    if ((item?.courseReelYoutubeLink ?? "").isNotEmpty) {
      _isYoutubeVideo = true;
      String? videoId = YoutubePlayer.convertUrlToId(item!.courseReelYoutubeLink!);
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
    } else if ((item?.courseReelVideo ?? "").isNotEmpty) {
      _isYoutubeVideo = false;
      log(("${ApiConstants.publicBaseUrl}/${(item!.courseReelVideo!)}"), name: "initializePlayer");
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

  @override
  void dispose() {
    super.dispose();

    if (_videoController != null) {
      _videoController!.dispose();
    }
    if (_youtubeController != null) {
      _youtubeController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
      ),
      body: Container(
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
        // height: height,

        width: width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : isError
                        ? Center(
                            child: CachedNetworkImage(
                              imageUrl: "${ApiConstants.publicBaseUrl}/${item.courseReelThumbnail ?? ""}",
                              progressIndicatorBuilder: (context, url, progress) => const Center(child: CircularProgressIndicator()),
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                            ),
                          )
                        : _isYoutubeVideo && _youtubeController != null
                            ? Center(
                                child: YoutubePlayer(
                                  controller: _youtubeController!,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.amber,
                                  aspectRatio: _youtubeController!.value.isFullScreen ? 9 / 16 : 16 / 9,
                                ),
                              )
                            : _videoController != null && _isInitialized
                                ? Center(
                                    child: AspectRatio(
                                      aspectRatio: _videoController?.value.aspectRatio ?? 16 / 9,
                                      child: VideoPlayer(
                                        _videoController!,
                                      ),
                                    ),
                                  )
                                : const Center(child: Text("No video or Youtube link")),
              ),
            ),

            /// User info & caption
            Positioned(
              top: 20,
              left: 16,
              child: SafeArea(
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
                            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
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
                    // Text(
                    //   item.title.toString(),
                    //   style: TextStyle(
                    //     color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                    //     fontSize: 16, // Slightly smaller font size
                    //     shadows: [
                    //       Shadow(
                    //         blurRadius: 3.0,
                    //         color: Colors.black,
                    //         offset: Offset(1.0, 1.0),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            /// Right-side action buttons
            Positioned(
              bottom: 0,
              right: 16,
              child: Column(
                // spacing: 10,
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
                            color: isLiked
                                ? Colors.red
                                : Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                          ),
                          onPressed: () {
                            _toggleLike(item.courseId!, item.courseReelsId!);
                          },
                        ),
                        GestureDetector(
                          onTap: () => _showLikeBottomSheet(item.courseId!, item.courseReelsId!),
                          child: Text(
                              "${homecontroller.categoryWiseReelData.value.data?[widget.courseIndex].reelsList?[widget.reelIndex].courseReelLikeCount ?? 0}"),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          _showCommentsBottomSheet(item.courseId!, item.courseReelsId!);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          _showCommentsBottomSheet(item.courseId!, item.courseReelsId!);
                        },
                        child: Text(
                            "${homecontroller.categoryWiseReelData.value.data?[widget.courseIndex].reelsList?[widget.reelIndex].courseReelCommentCount ?? 0}"),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          String postUrl;

                          if (item.courseReelYoutubeLink != null && item.courseReelYoutubeLink!.isNotEmpty) {
                            // Share the YouTube link if available
                            postUrl = item.courseReelYoutubeLink!;
                          } else if (item.courseReelVideo != null && item.courseReelVideo!.isNotEmpty) {
                            // Share the normal video link
                            postUrl = "${ApiConstants.publicBaseUrl}/${item.courseReelVideo}";
                          } else {
                            // Share the thumbnail if no video is available
                            postUrl = "${ApiConstants.publicBaseUrl}/${item.courseReelThumbnail ?? ""}";
                          }

                          // Custom message with app logo, app name, and text
                          String message = """
          📚 *${item.reelDescription ?? "Hey"}*
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
      int newLike = (widget.item.courseReelLikeCount ?? 0) + 1;
      homecontroller.categoryWiseReelData.value.data?[widget.courseIndex].reelsList?[widget.reelIndex] =
          homecontroller.categoryWiseReelData.value.data![widget.courseIndex].reelsList![widget.reelIndex].copyWith(courseReelLikeCount: newLike);
    } else {
      int newLike = (homecontroller.categoryWiseReelData.value.data?[widget.courseIndex].reelsList?[widget.reelIndex].courseReelLikeCount ?? 0) - 1;
      homecontroller.categoryWiseReelData.value.data?[widget.courseIndex].reelsList?[widget.reelIndex] =
          homecontroller.categoryWiseReelData.value.data![widget.courseIndex].reelsList![widget.reelIndex].copyWith(courseReelLikeCount: newLike);
    }
    final result = await reelController.likeDislike(courseId: id, courseReelId: courseReelId);
    setState(() {});
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
    final result = await reelController.addComment(courseId: courseId, comment: commentController.text, courseReelId: courseReelId);

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
              height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Comments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    // Use Expanded to fill available space
                    child: FutureBuilder(
                      future: reelController.getComments(courseId, courseReelId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
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
              Text("Likes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
