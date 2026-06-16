import 'package:get/get.dart';
import '../data/services/network_controller.dart';
import '../data/services/network_service.dart';
import '../data/services/socket_service.dart';
import '../features/call/controller/calls_controller.dart';
import '../features/chat_room/controller/chat_room_controller.dart';
import '../features/contact/controller/contact_controller.dart';
import '../features/home/controller/home_controller.dart';
import '../features/profile/contoller/profile_controller.dart';
import '../features/update/controller/updates_controller.dart';
import '../features/user_profile/controller/user_profile_controller.dart';
import '../features/user_profile/internal/media_links_docs/contoller/media_links_docs_controller.dart.dart';
import '../features/voiceMall/controller/voicemail_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>( NetworkController(), permanent: true);
    Get.putAsync<NetworkService>(() => NetworkService().init(), permanent: true);
    Get.putAsync<SocketService>(() => SocketService().init(), permanent: true);
    Get.put(HomeController());
    Get.put(ChatRoomController());
    Get.put(CallsController());
    Get.put(UserProfileController());
    Get.put(MediaLinksDocsController());
    Get.put(MediaLinksDocsController());
    Get.put(ProfileController());
    Get.put(UpdatesController());
    Get.put(ContactController());
    Get.put(VoicemailController());
  }

}