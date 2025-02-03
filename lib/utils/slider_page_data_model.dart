import 'package:edxera/models/choose_plane.dart';
import 'package:edxera/models/design_list.dart';
import 'package:edxera/models/home_slider.dart';
import 'package:edxera/models/lesson.dart';
import 'package:edxera/models/overviewpage_instructur.dart';
import 'package:edxera/models/payment_selection.dart';
import 'package:edxera/models/recently_added.dart';
import 'package:edxera/models/slider.dart';
import 'package:edxera/models/trending_cource.dart';

import '../models/chate_data.dart';
import '../models/chate_messege.dart';
import '../models/completed_cource_model.dart';
import '../models/contect_us_model.dart';
import '../models/faq_model.dart';
import '../models/my_cource.dart';
import '../models/new_user_detail.dart';
import '../models/ongoing_cource_detail.dart';
import '../models/profile_option.dart';
import '../models/riview_data.dart';

class Utils {
  static List<User> getUser() {
    return [
      User(name: "Kevin", image: "assets/person.png", email: "sdsdsd123@gmail.com", phoneNo: '1234567895'),
    ];
  }

  static List<Sliders> getSliderPages() {
    return [
      Sliders(
        image: 'assets/onboarding1st.png',
        name: 'Learn new skills every day!',
        title: 'We provide the best learning couerses & great mentors for you.',
      ),
      Sliders(
        image: 'assets/onboarding2nd.png',
        name: 'Easy enroll in class !',
        title: 'Learn anytime and anywhere easily and conveniently.',
      ),
      Sliders(
        image: 'assets/onboarding3rd.png',
        name: 'Get online certificate !',
        title: 'Complete the full course with full dedication to get certificate.',
      ),
      Sliders(
        image: 'assets/onboarding4th.png',
        name: 'Explore new reasources !',
        title: 'Find best course for your career that will help you to develop your skill.',
      ),
    ];
  }

  static List<HomeSlider> getHomeSliderPages() {
    return [
      HomeSlider(image: 'assets/slider1.jpeg', title: ''),
      HomeSlider(image: 'assets/slider2.jpeg', title: ''),
    ];
  }

  static List<Design> getDesign() {
    return [
      Design(image: 'assets/d3.png', name: 'Design', color: '0XFFFFF6E5'),
      Design(image: 'assets/d4.png', name: 'Code', color: '0XFFFEE9EB'),
      Design(image: 'assets/d5.png', name: 'Buisness', color: '0XFFECF6FF'),
      Design(image: 'assets/d6.png', name: 'Photography', color: '0XFFFFF6E5'),
    ];
  }

  static List<Trending> getTrending() {
    return [
      Trending(
          review: '4.9',
          image: 'assets/trending1.png',
          title: 'Financial Accounting ',
          subtitle: 'Certificate Computerised',
          time: '2 .40 Hrs',
          circleimage: 'assets/trendingcircle1.png',
          personname: 'Jenny Wilson',
          id: 1,
          buttonStatus: false),
      Trending(
          review: '4.9',
          image: 'assets/beauty.jpeg',
          title: 'Certificate in Beautician',
          subtitle: 'Certificate',
          time: '2 .40 Hrs',
          circleimage: 'assets/trendingcircle2.png',
          personname: 'Cody Fisher',
          id: 2,
          buttonStatus: false),
      Trending(
          review: '3.5',
          image: 'assets/sttiching.jpeg',
          title: 'Stitching and Cutting',
          subtitle: 'Diploma',
          time: '12 .30 Hrs',
          circleimage: 'assets/trendingcircle3.png',
          personname: 'Leslie Alexander',
          id: 3,
          buttonStatus: false),
      Trending(
          review: '3.5',
          image: 'assets/PGDCA.jpeg',
          title: 'PGDCA',
          subtitle: '',
          time: '12 .30 Hrs',
          circleimage: 'assets/trendingcircle4.png',
          personname: 'Kristin Watson',
          id: 4,
          buttonStatus: false),
      Trending(
          review: '4.9',
          image: 'assets/DCA.jpeg',
          title: 'DCA',
          subtitle: '',
          time: '2 .40 Hrs',
          circleimage: 'assets/trendingcircle2.png',
          personname: 'Cody Fisher',
          id: 5,
          buttonStatus: false),
      Trending(
          review: '4.9',
          image: 'assets/Henna.jpeg',
          title: 'Henna Artist',
          subtitle: 'Diploma',
          time: '12 .30 Hrs',
          circleimage: 'assets/trendingcircle4.png',
          personname: 'Kristin Watson',
          id: 6,
          buttonStatus: false),
    ];
  }

  static List<Recent> getRecentAdded() {
    return [
      Recent(
          image: 'assets/recent1.png',
          time: '2 .40 Hrs',
          review: '4.9',
          personname: 'Jenny Wilson',
          price: '\$174.00',
          circleimage: 'assets/recentcircle1.png',
          title: 'How to make creative photo with photoshop',
          id: 1,
          buttonStatus: false),
      Recent(
          image: 'assets/recent2.png',
          time: '2 .40 Hrs',
          review: '3.9',
          personname: 'Jenny Wilson',
          price: '\$174.00',
          circleimage: 'assets/recentcircle1.png',
          title: 'How to illustratior with diffirent menu and vector',
          id: 2,
          buttonStatus: false),
      Recent(
          image: 'assets/recent1.png',
          time: '2 .40 Hrs',
          review: '4.9',
          personname: 'Jenny Wilson',
          price: '\$140.00',
          circleimage: 'assets/recentcircle1.png',
          title: 'How to make creative photo with photoshop   ',
          id: 3,
          buttonStatus: false),
    ];
  }

  static List<Instructor> getInstruter() {
    return [
      Instructor(image: 'assets/1stinstructor.png', title: 'Leslie Alexander', subtitle: 'Faculty, Program In UI UX Design'),
      Instructor(image: 'assets/2ndinstructor.png', title: 'Jacob Jones', subtitle: 'Faculty, Program In UI UX Design'),
    ];
  }

  static List<LessonList> getLesson() {
    return [
      LessonList(
          image: 'assets/lesson1.png',
          title: 'Introduction',
          buttonName: 'Lesson 1',
          detail1st: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
          detailicon1: 'assets/1stlessondetail.png',
          detail2nd: 'Lorem ipsum dolor sit amet',
          detailicon2: 'assets/2ndlessondetail.png',
          detail3rd: 'Lorem ipsum dolor sit amet',
          detailicon3: 'assets/3rdlessondetail.png',
          detail4th: 'Lorem ipsum dolor sit amet',
          detailicon4: 'assets/4thlessondetail.png',
          detail1stscore: 10,
          detail2ndscore: 9,
          detail3rdscore: 7,
          detail4thscore: 12),
      LessonList(
          image: 'assets/lesson2.png',
          title: 'User Research.',
          buttonName: 'Lesson 2',
          detail1st: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
          detailicon1: 'assets/1stlessondetail.png',
          detail2nd: 'Lorem ipsum dolor sit amet',
          detailicon2: 'assets/2ndlessondetail.png',
          detail3rd: 'Lorem ipsum dolor sit amet',
          detailicon3: 'assets/3rdlessondetail.png',
          detail4th: 'Lorem ipsum dolor sit amet',
          detailicon4: 'assets/4thlessondetail.png',
          detail1stscore: 10,
          detail2ndscore: 9,
          detail3rdscore: 7,
          detail4thscore: 12),
      LessonList(
          image: 'assets/lesson3.png',
          title: 'Wireframing',
          buttonName: 'Lesson 3',
          detail1st: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
          detailicon1: 'assets/1stlessondetail.png',
          detail2nd: 'Lorem ipsum dolor sit amet',
          detailicon2: 'assets/2ndlessondetail.png',
          detail3rd: 'Lorem ipsum dolor sit amet',
          detailicon3: 'assets/3rdlessondetail.png',
          detail4th: 'Lorem ipsum dolor sit amet',
          detailicon4: 'assets/4thlessondetail.png',
          detail1stscore: 10,
          detail2ndscore: 9,
          detail3rdscore: 7,
          detail4thscore: 12),
      LessonList(
          image: 'assets/lesson5.png',
          title: 'Types of UI design',
          buttonName: 'Lesson 4',
          detail1st: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
          detailicon1: 'assets/1stlessondetail.png',
          detail2nd: 'Lorem ipsum dolor sit amet',
          detailicon2: 'assets/2ndlessondetail.png',
          detail3rd: 'Lorem ipsum dolor sit amet',
          detailicon3: 'assets/3rdlessondetail.png',
          detail4th: 'Lorem ipsum dolor sit amet',
          detailicon4: 'assets/4thlessondetail.png',
          detail1stscore: 10,
          detail2ndscore: 9,
          detail3rdscore: 7,
          detail4thscore: 12),
      LessonList(
          image: 'assets/lesson3.png',
          title: 'UI Layout',
          buttonName: 'Lesson 5',
          detail1st: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
          detailicon1: 'assets/1stlessondetail.png',
          detail2nd: 'Lorem ipsum dolor sit amet',
          detailicon2: 'assets/2ndlessondetail.png',
          detail3rd: 'Lorem ipsum dolor sit amet',
          detailicon3: 'assets/3rdlessondetail.png',
          detail4th: 'Lorem ipsum dolor sit amet',
          detailicon4: 'assets/4thlessondetail.png',
          detail1stscore: 10,
          detail2ndscore: 9,
          detail3rdscore: 7,
          detail4thscore: 12),
    ];
  }

  static List<ReviewList> getReviewList() {
    return [
      ReviewList(image: 'assets/riview1.png', discription: '“Thank You For Your Services That Save My Time Very Much”.', time: '1 day ago'),
      ReviewList(image: 'assets/riview2.png', discription: '“Thank You For Your Services That Save My Time Very Much”.', time: '2 day ago'),
      ReviewList(image: 'assets/riview3.png', discription: '“This app is very usefull for all the person in around”.', time: '2 day ago'),
      ReviewList(image: 'assets/riview4.png', discription: '“This app is very usefull for all the person in around”.', time: '3 day ago'),
      ReviewList(image: 'assets/riview1.png', discription: '“Thank You For Your Services That Save My Time Very Much”.', time: '1 day ago'),
      ReviewList(image: 'assets/riview2.png', discription: '“Thank You For Your Services That Save My Time Very Much”.', time: '2 day ago'),
      ReviewList(image: 'assets/riview3.png', discription: '“This app is very usefull for all the person in around”.', time: '2 day ago'),
      ReviewList(image: 'assets/riview4.png', discription: '“This app is very usefull for all the person in around”.', time: '3 day ago'),
    ];
  }

  static List<ChoicePlane> getChoosePlane() {
    return [
      ChoicePlane(
          planeTime: '\$12/Month',
          planfacelity1st: 'Lorem ipsum dolor sit amet',
          planfacelity2nd: 'Lorem ipsum dolor sit amet',
          planfacelity3rd: 'Lorem ipsum dolor sit amet',
          image: 'assets/right.png',
          cho: false,
          id: 1),
      ChoicePlane(
          planeTime: '\$99/Year',
          planfacelity1st: 'Lorem ipsum dolor sit amet',
          planfacelity2nd: 'Lorem ipsum dolor sit amet',
          planfacelity3rd: 'Lorem ipsum dolor sit amet',
          image: 'assets/right.png',
          cho: false,
          id: 2),
    ];
  }

  static List<Payment> getPayment(Map<String, dynamic> mplanguage) {
    return [
      Payment(image: 'assets/pay1.png', title: mplanguage['paypal'].toString()),
      Payment(image: 'assets/pay2.png', title: mplanguage['mastercard'].toString()),
      Payment(image: 'assets/pay3.png', title: mplanguage['visa'].toString()),
      Payment(image: 'assets/pay4.png', title: mplanguage['cash'].toString()),
    ];
  }

  static List<OngoingCources> getOngoingCource() {
    return [
      OngoingCources(courceImage: 'assets/trending1.png', courceName: 'Financial Accounting ', id: 1),
      OngoingCources(courceImage: 'assets/beauty.jpeg', courceName: 'Certificate in Beautician', id: 2),
      OngoingCources(courceImage: 'assets/sttiching.jpeg', courceName: 'Stitching and Cutting', id: 3),
      OngoingCources(courceImage: 'assets/PGDCA.jpeg', courceName: 'PGDCA', id: 4)
    ];
  }

  static List<CourceDetails> getCourceDetail() => [
        CourceDetails(
            time: '12 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 01,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '10 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 02,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '8 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 03,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '16 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 04,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '8 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 05,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '14 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 06,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '12 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 07,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '10 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 08,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '8 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 09,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '16 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 10,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '8 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 11,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '14 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 12,
            courceID: 1,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '12 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 01,
            courceID: 2,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '10 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 02,
            courceID: 2,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '8 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 03,
            courceID: 2,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '16 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 04,
            courceID: 2,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '8 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 05,
            courceID: 2,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
        CourceDetails(
            time: '14 min',
            lessonName: 'Lorem ipsum dolor sit amet consectetur',
            lessonID: 06,
            courceID: 2,
            playIconImage: 'assets/lessonplay.png',
            lockImageImage: 'assets/lock.png',
            url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
      ];

  static List<Completed> getCompletedCource() {
    return [
      Completed(
        courceImage: 'assets/trending1.png',
        courceName: 'Financial Accounting ',
      ),
      Completed(
        courceImage: 'assets/beauty.jpeg',
        courceName: 'Certificate in Beautician',
      ),
    ];
  }

  static List<String> getLanguages() {
    return ['English', 'മലയാളം', 'हिंदी', 'ಕನ್ನಡ'];
  }

  static List<String> getLanguageCodes() {
    return ['en', 'ml', 'hi', 'kn'];
  }

  static Future<List<ProfileOption>> getOptions(String code) async {
    List<ProfileOption> op = [];
    if (code.compareTo("en") == 0) {
      op = getProfileOption();
    } else if (code.compareTo("ml") == 0) {
      op = getProfileOptionofMalayalam();
    } else if (code.compareTo("hi") == 0) {
      op = getProfileOptionHindi();
    } else if (code.compareTo("kn") == 0) {
      op = getProfileOptionKannada();
    }

    return op;
  }

  static List<ProfileOption> getProfileOption() {
    return [
      ProfileOption(title: 'My Certifications', icon: 'assets/prorfileoptionicon1st.png'),
      // ProfileOption(
      //     title: 'My Projects', icon: 'assets/prorfileoptionicon2nd.png'),
      ProfileOption(title: 'Payment Details', icon: 'assets/shop.png'),
      ProfileOption(title: 'Saved Course', icon: 'assets/prorfileoptionicon3rd.png'),
      ProfileOption(title: 'My Card', icon: 'assets/prorfileoptionicon4th.png'),
      ProfileOption(title: 'Change Password', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'Help Center', icon: 'assets/prorfileoptionicon5th.png'),
      ProfileOption(title: 'Privacy Policy', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'Feedback', icon: 'assets/prorfileoptionicon7th.png'),
      ProfileOption(title: 'Change Language', icon: 'assets/language.png'),

      ProfileOption(title: 'Rate Us', icon: 'assets/prorfileoptionicon8th.png'),
      ProfileOption(title: 'Delete My Account', icon: 'assets/bin.png'),
    ];
  }

  static List<ProfileOption> getProfileOptionofMalayalam() {
    return [
      ProfileOption(title: 'എൻ്റെ സർട്ടിഫിക്കേഷനുകൾ', icon: 'assets/prorfileoptionicon1st.png'),
      // ProfileOption(
      //     title: 'My Projects', icon: 'assets/prorfileoptionicon2nd.png'),
      ProfileOption(title: 'പേയ്മെൻ്റ് വിശദാംശങ്ങൾ', icon: 'assets/shop.png'),
      ProfileOption(title: 'സംരക്ഷിച്ച കോഴ്സുകൾ', icon: 'assets/prorfileoptionicon3rd.png'),
      ProfileOption(title: 'എൻ്റെ കാർഡ്', icon: 'assets/prorfileoptionicon4th.png'),
      ProfileOption(title: 'പാസ്വേഡ് മാറ്റുക', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'സഹായകേന്ദ്രം', icon: 'assets/prorfileoptionicon5th.png'),
      ProfileOption(title: 'സ്വകാര്യതാ നയം', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'പ്രതികരണം', icon: 'assets/prorfileoptionicon7th.png'),
      ProfileOption(title: 'ഭാഷ മാറ്റുക', icon: 'assets/language.png'),

      ProfileOption(title: 'ഞങ്ങളെ റേറ്റുചെയ്യുക', icon: 'assets/prorfileoptionicon8th.png'),
      ProfileOption(title: 'എൻ്റെ അക്കൗണ്ട് ഇല്ലാതാക്കുക', icon: 'assets/bin.png'),
    ];
  }

  static List<ProfileOption> getProfileOptionHindi() {
    return [
      ProfileOption(title: 'मेरे प्रमाणपत्र', icon: 'assets/prorfileoptionicon1st.png'),
      ProfileOption(title: 'भुगतान विवरण', icon: 'assets/shop.png'),
      // ProfileOption(
      //     title: 'My Projects', icon: 'assets/prorfileoptionicon2nd.png'),
      ProfileOption(title: 'पाठ्यक्रम सहेजा गया', icon: 'assets/prorfileoptionicon3rd.png'),
      ProfileOption(title: 'मेरे कार्ड', icon: 'assets/prorfileoptionicon4th.png'),
      ProfileOption(title: 'पासवर्ड बदलें', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'सहायता केंद्र', icon: 'assets/prorfileoptionicon5th.png'),
      ProfileOption(title: 'गोपनीयता नीति', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'प्रतिक्रिया', icon: 'assets/prorfileoptionicon7th.png'),
      ProfileOption(title: 'भाषा बदलें', icon: 'assets/language.png'),

      ProfileOption(title: 'हमें रेट करें', icon: 'assets/prorfileoptionicon8th.png'),
      ProfileOption(title: 'मेरा खाता हटा दें', icon: 'assets/bin.png'),
    ];
  }

  static List<ProfileOption> getProfileOptionKannada() {
    return [
      ProfileOption(title: 'ನನ್ನ ಪ್ರಮಾಣೀಕರಣಗಳು', icon: 'assets/prorfileoptionicon1st.png'),
      ProfileOption(title: 'ಪಾವತಿ ವಿವರಗಳು', icon: 'assets/shop.png'),
      // ProfileOption(
      //     title: 'My Projects', icon: 'assets/prorfileoptionicon2nd.png'),
      ProfileOption(title: 'ಉಳಿಸಿದ ಕೋರ್ಸ್', icon: 'assets/prorfileoptionicon3rd.png'),
      ProfileOption(title: 'ನನ್ನ ಕಾರ್ಡ್', icon: 'assets/prorfileoptionicon4th.png'),
      ProfileOption(title: 'ಪಾಸ್‌ವರ್ಡ್ ಬದಲಾಯಿಸಿ', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'ಸಹಾಯ ಕೇಂದ್ರ ', icon: 'assets/prorfileoptionicon5th.png'),
      ProfileOption(title: 'ಗೌಪ್ಯತೆ ನೀತಿ', icon: 'assets/prorfileoptionicon6th.png'),
      ProfileOption(title: 'ಪ್ರತಿಕ್ರಿಯೆ', icon: 'assets/prorfileoptionicon7th.png'),
      ProfileOption(title: 'ಭಾಷೆ ಬದಲಾಯಿಸಿ', icon: 'assets/language.png'),

      ProfileOption(title: 'ನಮಗೆ ರೇಟ್ ಮಾಡಿ', icon: 'assets/prorfileoptionicon8th.png'),
      ProfileOption(title: 'मನನ್ನ ಖಾತೆಯನ್ನು ಅಳಿಸಿ', icon: 'assets/bin.png'),
    ];
  }

  static List<FAQ> getFaq() {
    return [
      FAQ(
          question: 'What is Learn Management ?',
          answer:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Platea dictumst vestibulum rhoncus est pellentesque elit.'),
      FAQ(
          question: 'How to use Learn Management ?',
          answer:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Platea dictumst vestibulum rhoncus est pellentesque elit.'),
      FAQ(
          question: 'Is Learn Management free to use?',
          answer:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Platea dictumst vestibulum rhoncus est pellentesque elit.'),
      FAQ(
          question: 'Can i create my own course?',
          answer:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Platea dictumst vestibulum rhoncus est pellentesque elit.'),
      FAQ(
          question: 'Lorem ipsum dolor sit amet',
          answer:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Platea dictumst vestibulum rhoncus est pellentesque elit.'),
      FAQ(
          question: 'Lorem ipsum dolor sit amet',
          answer:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Platea dictumst vestibulum rhoncus est pellentesque elit.'),
    ];
  }

  static List<Contect> getContect() {
    return [
      Contect(contectTitle: 'Customer Service', contectIcon: 'assets/customer_service_icon.png'),
      Contect(contectTitle: 'Website', contectIcon: 'assets/website_icon.png'),
      Contect(contectTitle: 'Whatsapp', contectIcon: 'assets/whatsapp_icon.png'),
      Contect(contectTitle: 'Facebook', contectIcon: 'assets/facebook_icon.png'),
      Contect(contectTitle: 'Instagram', contectIcon: 'assets/instagram_icon.png'),
    ];
  }

  static List<Chate> getChate() {
    return [
      Chate(image: 'assets/chate1.png', name: 'Jane Cooper', message: 'perfect!', time: '11:15', messageCount: '2', id: 1),
      Chate(image: 'assets/chate2.png', name: 'Leslie Alexander', message: 'How are you?', time: '11:15', messageCount: '3', id: 2),
      Chate(image: 'assets/chate3.png', name: 'Jacob Jones', message: 'How can i help you?', time: '11:15', messageCount: '4', id: 3),
      Chate(image: 'assets/chate4.png', name: 'Jacob Jones', message: 'How can i help you?', time: '11:15', messageCount: '5', id: 4),
      Chate(image: 'assets/chate5.png', name: 'Jacob Jones', message: 'How can i help you?', time: '11:15', messageCount: '6', id: 5),
      Chate(image: 'assets/chate1.png', name: 'Jane Cooper', message: 'perfect!', time: '11:15', messageCount: '2', id: 6),
      Chate(image: 'assets/chate2.png', name: 'Leslie Alexander', message: 'How are you?', time: '11:15', messageCount: '3', id: 7),
      Chate(image: 'assets/chate3.png', name: 'Jacob Jones', message: 'How can i help you?', time: '11:15', messageCount: '4', id: 8),
      Chate(image: 'assets/chate4.png', name: 'Jacob Jones', message: 'How can i help you?', time: '11:15', messageCount: '5', id: 9),
      Chate(image: 'assets/chate5.png', name: 'Jacob Jones', message: 'How can i help you?', time: '11:15', messageCount: '6', id: 10),
    ];
  }

  static List<ChateMessage> getChateMessage() {
    return [
      ChateMessage(message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,', time: '2.55 PM', type: 'receve'),
      ChateMessage(
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', time: '3.10 PM', type: 'send'),
      ChateMessage(message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,', time: '3.10 PM', type: 'receve'),
      ChateMessage(
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', time: '3.12 PM', type: 'send'),
    ];
  }
}
