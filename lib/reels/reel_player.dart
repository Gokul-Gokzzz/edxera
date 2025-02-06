// import 'package:edxera/reels/reel_card.dart';
// import 'package:flutter/material.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:get/get.dart';
//
// import 'controller/reel_controller.dart';
//
// class ReelPlayer extends StatefulWidget {
//   final int index;
//
//   const ReelPlayer({Key? key, required this.index}) : super(key: key);
//
//   @override
//   State<ReelPlayer> createState() => _ReelPlayerState();
// }
//
// class _ReelPlayerState extends State<ReelPlayer> {
//   ReelController reelController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Swiper(
//           index: widget.index,
//           scrollDirection: Axis.vertical,
//           // pagination: SwiperPagination(),
//           // control: SwiperControl(),
//           itemBuilder: (BuildContext context, int i) {
//             return ReelCard(
//               index: i,
//             );
//           },
//           itemCount: reelController.reels.length,
//           layout: SwiperLayout.DEFAULT,
//         ),
//       ),
//     );
//   }
// }
