import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/reels/controller/reel_controller.dart';
import 'package:edxera/reels/model/reel_model.dart';
import 'package:edxera/reels/reel_card.dart';
import 'package:edxera/reels/thumbnail_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../repositories/api/api_constants.dart';
import 'reel_player.dart';
import 'package:provider/provider.dart';

class ReelsHome extends StatefulWidget {
  const ReelsHome({Key? key}) : super(key: key);

  @override
  State<ReelsHome> createState() => _ReelsHomeState();
}

class _ReelsHomeState extends State<ReelsHome> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  ReelController reelController = Get.find();
  final PageController _pageController = PageController(); // Page controller for the advertisement slider
  int _currentPage = 0;

  List<int> highlightList = [];
  int lastIndex = 2;
  // List<ReelModel> reels = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), _autoSlideAds);

    super.initState();
  }

  // Function to automatically slide to the next advertisement
  void _autoSlideAds() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        (_currentPage + 1) % 3, // Assuming there are 3 ads, loop through them
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = (_currentPage + 1) % 3; // Update the current page index
      });
      Future.delayed(Duration(seconds: 5), _autoSlideAds); // Repeat every 5 seconds
    }
  }

  Debouncer _searchDebouncer = Debouncer(delay: Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    // final isLoading = reelController.isLoading;
    //  final reels = reelController.reels;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56), // Set a fixed height for the AppBar
        child: AppBar(
          backgroundColor: Colors.white,
          title: isSearching
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    onChanged: (value) {
                      _searchDebouncer.call(
                        () {
                          if (value.isEmpty) {
                            reelController.getReels();
                          } else {
                            reelController.getReels(search: value);
                          }
                        },
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(color: Colors.black), // Set text color to black
                  ),
                )
              : Row(
                  children: [
                    Image.asset(
                      'assets/app_logo.jpeg', // Your logo image
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edxera",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
                    ),
                  ],
                ),
          actions: [
            isSearching
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                        reelController.getReels();
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                  ),
          ],
        ),
      ),
      body: Obx(
        () {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await reelController.getReels();
              },
              child: Container(
                color: Colors.white,
                child: reelController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : reelController.reels.length > 0
                        ? SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                // Advertisement Slider
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.all(10),
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 150, // Fixed height for the advertisement
                                              child: PageView.builder(
                                                controller: _pageController,
                                                itemCount: 3, // Number of advertisements
                                                onPageChanged: (index) {
                                                  setState(() {
                                                    _currentPage = index;
                                                  });
                                                },
                                                itemBuilder: (context, index) {
                                                  return Image.asset(
                                                    'assets/adv1.jpg', // Replace with your advertisement images
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            SmoothPageIndicator(
                                              controller: _pageController,
                                              count: 3, // Number of advertisements
                                              effect: SwapEffect(), // Indicator effect (can be changed)
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: reelController.reels.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          // print("${ApiConstants.publicBaseUrl}/${reelController.reels[index].courseReelVideo}");
                                          // Get.to(
                                          //   () => ReelPlayer(
                                          //     index: index,
                                          //   ),
                                          // );
                                        },
                                        child:
                                            // (reelController.reels[index].courseThumbnail ?? "").isEmpty
                                            //     // ? ThumbnailPlayer(reelController.reels[index])
                                            //     ?
                                            ReelCard(index: index)

                                        // : CachedNetworkImage(
                                        //     imageUrl: "${ApiConstants.publicBaseUrl}/${reelController.reels[index].courseThumbnail}",
                                        //     progressIndicatorBuilder: (context, url, progress) => SizedBox(
                                        //       height: 300,
                                        //       child: Center(
                                        //         child: CircularProgressIndicator(
                                        //           value: progress.progress,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     fit: BoxFit.cover,
                                        //     errorWidget: (context, url, error) => Icon(Icons.broken_image),
                                        //   ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text("There is No Reels"),
                          ),
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
