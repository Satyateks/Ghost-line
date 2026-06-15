import 'package:get/get.dart';

import '../model/call_item_model.dart';


class CallsController extends GetxController {
  final RxString searchQuery = ''.obs;

  final RxList<CallItemModel> calls = <CallItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyCalls();
  }

  void updateSearch(String value) {
    searchQuery.value = value.trim().toLowerCase();
  }

  List<CallItemModel> get recentCalls {
    return _filtered.where((e) => e.isRecent).toList();
  }

  List<CallItemModel> get contacts {
    return _filtered.where((e) => !e.isRecent).toList();
  }

  List<CallItemModel> get _filtered {
    if (searchQuery.value.isEmpty) return calls;

    return calls.where((call) {
      return call.name.toLowerCase().contains(searchQuery.value);
    }).toList();
  }

  void _loadDummyCalls() {
    calls.assignAll([
      CallItemModel(
        id: '1',
        name: 'Satyam',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
        time: 'Yesterday, 10:12',
        type: CallType.video,
        isRecent: true,
        isMissed: true,
      ),
      CallItemModel(
        id: '2',
        name: 'Lavit Reddy',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
        time: 'Yesterday, 10:12',
        type: CallType.video,
        isRecent: true,
      ),
      CallItemModel(
        id: '3',
        name: 'Abhay Singh',
        avatar: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce',
        time: 'Yesterday, 10:12',
        type: CallType.audio,
        isRecent: true,
      ),
      CallItemModel(
        id: '4',
        name: 'Sneha Singh',
        avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        time: 'Yesterday, 10:12',
        type: CallType.audio,
        isRecent: true,
      ),
      CallItemModel(
        id: '5',
        name: 'Amit Patil',
        avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        time: 'Yesterday, 10:12',
        type: CallType.audio,
        isRecent: false,
      ),
      CallItemModel(
        id: '6',
        name: 'Lakshay Sharma',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
        time: 'Yesterday, 10:12',
        type: CallType.audio,
        isRecent: false,
      ),
      CallItemModel(
        id: '7',
        name: 'Mohit Jain',
        avatar: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce',
        time: 'Yesterday, 10:12',
        type: CallType.audio,
        isRecent: false,
      ),
    ]);
  }
}