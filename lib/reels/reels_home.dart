import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/reels/controller/reel_controller.dart';
import 'package:edxera/reels/model/reel_model.dart';
import 'package:edxera/reels/thumbnail_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../repositories/api/api_constants.dart';
import 'reel_player.dart';
import 'package:provider/provider.dart';

class ReelsHome extends StatefulWidget {
  const ReelsHome({Key? key}) : super(key: key);

  @override
  State<ReelsHome> createState() => _ReelsHomeState();
}

class _ReelsHomeState extends State<ReelsHome> {
  ReelController reelController = Get.find();

  List<int> highlightList = [];
  int lastIndex = 2;
  // List<ReelModel> reels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final isLoading = reelController.isLoading;
    //  final reels = reelController.reels;

    return Scaffold(
      body: Obx(
        () {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await reelController.getReels();
              },
              child: reelController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : reelController.reels.length > 0
                      ? SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: StaggeredGrid.count(
                            axisDirection: AxisDirection.down,
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            children: [
                              for (int index = 0;
                                  index <
                                      reelController.reels.where((element) => element.courseThumbnail != '' || element.courseReelVideo != '').length;
                                  index++)
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  // mainAxisCellCount: index % 6 == 2 ? 2 : 1,
                                  mainAxisCellCount: getNextHighlightedIndex(reelController.reels
                                              .where((element) => element.courseThumbnail != '' || element.courseReelVideo != '')
                                              .length)
                                          .contains(index)
                                      ? 2
                                      : 1,
                                  child: InkWell(
                                    onTap: () {
                                      print("${ApiConstants.publicBaseUrl}/${reelController.reels[index].courseReelVideo}");
                                      Get.to(
                                        () => ReelPlayer(

                                          index: index,
                                        ),
                                      );
                                    },
                                    child: (reelController.reels[index].courseThumbnail ?? "").isEmpty
                                        ? ThumbnailPlayer(reelController.reels[index])
                                        : CachedNetworkImage(
                                            imageUrl: "${ApiConstants.publicBaseUrl}/${reelController.reels[index].courseThumbnail}",
                                            progressIndicatorBuilder: (context, url, progress) => SizedBox(
                                              height: 300,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value: progress.progress,
                                                ),
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) => Icon(Icons.broken_image),
                                          ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      : Center(
                          child: Text("There is No Reels"),
                        ),
            ),
          );
        },
      ),
    );
  }

  List<int> getNextHighlightedIndex(int length) {
    highlightList.add(2);
    for (int index = 0; index < length; index++) {
      if (index == lastIndex) {
        if (lastIndex.isEven) {
          lastIndex = index + 9;
          highlightList.add(lastIndex);
        } else {
          lastIndex = index + 13;
          highlightList.add(lastIndex);
        }
      }
    }
    return highlightList;
  }
}
