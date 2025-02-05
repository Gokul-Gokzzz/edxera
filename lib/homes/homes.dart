import 'package:edxera/homes/add_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this import

class SocialFeedScreen extends StatefulWidget {
  @override
  _SocialFeedScreenState createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  late VideoPlayerController _controller;
  final PageController _pageController =
      PageController(); // Page controller for the advertisement slider
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://youtube.com/shorts/1tfyOLlN6dQ?si=Iv1HuK06pln9yaU6', // Replace with actual video URL
    )..initialize().then((_) {
        setState(() {});
      });

    // Automatic sliding of advertisement
    Future.delayed(Duration(seconds: 2), _autoSlideAds);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
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
      Future.delayed(
          Duration(seconds: 5), _autoSlideAds); // Repeat every 5 seconds
    }
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text("Block User"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User Blocked")),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.report, color: Colors.orange),
              title: Text("Report"),
              onTap: () {
                Navigator.pop(context);
                _showReportOptions(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showReportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Text("Spam"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Reported as Spam")),
                );
              },
            ),
            ListTile(
              title: Text("Inappropriate Content"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Reported as Inappropriate")),
                );
              },
            ),
            ListTile(
              title: Text("Harassment"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Reported as Harassment")),
                );
              },
            ),
            ListTile(
              title: Text("Fake Information"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Reported as Fake Information")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edxera"),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_active_outlined))
        ],
      ),
      body: SingleChildScrollView(
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
                          effect:
                              SwapEffect(), // Indicator effect (can be changed)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Post Widget
            Card(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/app_logo.jpeg')),
                    title: Text("edxera"),
                    subtitle: Text("1 hour ago"),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () => _showOptions(context),
                    ),
                  ),
                  _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_outlined)),
                        Text("1"),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.chat_outlined)),
                        Text('1'),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
