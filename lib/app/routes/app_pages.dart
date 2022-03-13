import 'package:get/get.dart';

import '../modules/applied/bindings/applied_binding.dart';
import '../modules/applied/views/applied_view.dart';
import '../modules/applyforrent/bindings/applyforrent_binding.dart';
import '../modules/applyforrent/views/applyforrent_view.dart';
import '../modules/bookmarks/bindings/bookmarks_binding.dart';
import '../modules/bookmarks/views/bookmarks_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chatprofile/bindings/chatprofile_binding.dart';
import '../modules/chatprofile/views/chatprofile_view.dart';
import '../modules/chatscreen/bindings/chatscreen_binding.dart';
import '../modules/chatscreen/views/chatscreen_view.dart';
import '../modules/chooselocation/bindings/chooselocation_binding.dart';
import '../modules/chooselocation/views/chooselocation_view.dart';
import '../modules/detailview/bindings/detailview_binding.dart';
import '../modules/detailview/views/detailview_view.dart';
import '../modules/galleryview/bindings/galleryview_binding.dart';
import '../modules/galleryview/views/galleryview_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/newuserdetail/bindings/newuserdetail_binding.dart';
import '../modules/newuserdetail/views/newuserdetail_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/photogallery/bindings/photogallery_binding.dart';
import '../modules/photogallery/views/photogallery_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.NEWUSERDETAIL,
      page: () => NewuserdetailView(),
      binding: NewuserdetailBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSELOCATION,
      page: () => ChooselocationView(),
      binding: ChooselocationBinding(),
    ),
    GetPage(
      name: _Paths.DETAILVIEW,
      page: () => DetailviewView(),
      binding: DetailviewBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKS,
      page: () => BookmarksView(),
      binding: BookmarksBinding(),
    ),
    GetPage(
      name: _Paths.APPLYFORRENT,
      page: () => ApplyforrentView(),
      binding: ApplyforrentBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.APPLIED,
      page: () => AppliedView(),
      binding: AppliedBinding(),
    ),
    GetPage(
      name: _Paths.GALLERYVIEW,
      page: () => GalleryviewView(),
      binding: GalleryviewBinding(),
    ),
    GetPage(
      name: _Paths.PHOTOGALLERY,
      page: () => PhotogalleryView(),
      binding: PhotogalleryBinding(),
    ),
    GetPage(
      name: _Paths.CHATSCREEN,
      page: () => ChatscreenView(),
      binding: ChatscreenBinding(),
    ),
    GetPage(
      name: _Paths.CHATPROFILE,
      page: () => ChatprofileView(),
      binding: ChatprofileBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
  ];
}
