import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/chat_item_model.dart';

class FilterTab {
  final String id;
  final String title;

  FilterTab({required this.id, required this.title});
}

enum BottomTabType { calls, chat, voicemail, updates, profile }

class HomeController extends GetxController {
  final RxList<FilterTab> filterTabs = <FilterTab>[
    FilterTab(id: 'all', title: 'All'),
    FilterTab(id: 'archive', title: 'Archive'),
    FilterTab(id: 'unread', title: 'Unread'),
    FilterTab(id: 'groups', title: 'Groups'),
    FilterTab(id: 'favorites', title: 'Favorites'),
    FilterTab(id: 'family', title: 'Family'),
  ].obs;

  final RxString selectedFilter = 'all'.obs;
  final Rx<BottomTabType> selectedBottomTab = BottomTabType.chat.obs;
  final RxString searchQuery = ''.obs;

  final RxList<ChatItemModel> chats = <ChatItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyChats();
  }

  void forwardMessage({
    required dynamic message,
    required List<String> chatIds,
  }) {
    for (final chatId in chatIds) {
      // API ya local insert logic yahan aayega
      debugPrint("Forward message ${message.id} to chat $chatId");
    }
  }
  void deleteMessage(String messageId) {chats.removeWhere((item) => item.id == messageId);}

  void pinMessage(String messageId) {
    final index = chats.indexWhere((item) => item.id == messageId);
    if (index == -1) return;

    chats[index].isPinned = true;
    chats.refresh();
  }

  void starMessage(String messageId) {
    final index = chats.indexWhere((item) => item.id == messageId);
    if (index == -1) return;
    chats[index].isStarred = true; chats.refresh();
  }


  void changeFilter(String filterId) { selectedFilter.value = filterId; }

  void addCustomTab(String title) {
    final id = title.toLowerCase().replaceAll(' ', '_');
    if (!filterTabs.any((t) => t.id == id)) {
      filterTabs.add(FilterTab(id: id, title: title));
      selectedFilter.value = id; // auto select newly added tab
    }
  }

  void changeBottomTab(BottomTabType tab) { selectedBottomTab.value = tab; }

  void updateSearch(String value) { searchQuery.value = value.trim().toLowerCase(); }

  List<ChatItemModel> get filteredChats {
    List<ChatItemModel> list = chats;

    switch (selectedFilter.value) {
      case 'all':
        list = chats;
        break;

      case 'archive':
        list = chats.where((e) => e.isArchived).toList();
        break;

      case 'unread':
        list = chats.where((e) => e.unreadCount > 0).toList();
        break;

      case 'groups':
        list = chats.where((e) => e.isGroup).toList();
        break;

      default:
        // for custom tabs like favorites, family, etc. which don't have built-in data currently
        list = [];
        break;
    }

    if (searchQuery.value.isNotEmpty) {
      list = list.where((chat) {
        return chat.name.toLowerCase().contains(searchQuery.value) || chat.message.toLowerCase().contains(searchQuery.value);
      }).toList();
    }

    return list;
  }

  void deleteChat(String id) {chats.removeWhere((chat) => chat.id == id);}

  void archiveChat(String chatId) {
    // archive logic
  }

  void muteChat(String chatId) {
    final index = chats.indexWhere((item) => item.id == chatId);
    if (index == -1) return;

    chats[index].isMuted = true;
    chats.refresh();
  }

  void addToFavourite(String chatId) {
    final index = chats.indexWhere((item) => item.id == chatId);
    if (index == -1) return;

    chats[index].isFavourite = true;
    chats.refresh();
  }

  void addToList(String chatId) {
    // add to custom list logic
  }

  void blockChat(String chatId) {
    final index = chats.indexWhere((item) => item.id == chatId);
    if (index == -1) return;

    chats[index].isBlocked = true;
    chats.refresh();
  }

  void clearChat(String chatId) {
    final index = chats.indexWhere((item) => item.id == chatId);
    if (index == -1) return;

    // chats[index].message = "";
    // chats[index].unreadCount = 0;
    chats.refresh();
  }

  void _loadDummyChats() {
    chats.assignAll([
      ChatItemModel(
        id: '1',
        name: 'Satyam Mishra',
        message: "I'll check it for a moment, please wait",
        time: '11:15 AM',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
        unreadCount: 7,
        isOnline: true,
      ),
      ChatItemModel(
        id: '2',
        name: 'Ronny Casper',
        message: 'Ok will talk to you soon.',
        time: '11:15 AM',
        avatar: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce',
        unreadCount: 2,
      ),
      ChatItemModel(
        id: '3',
        name: 'College Friends',
        message: 'Thank you, I’ll make it up soon.',
        time: '11:15 AM',
        avatar: 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac',
        unreadCount: 2,
        isGroup: true,
      ),
      ChatItemModel(
        id: '4',
        name: 'Jeremie Leuschke',
        message: 'Yes, I’ll send it later',
        time: '11:15 AM',
        avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      ),
      ChatItemModel(
        id: '5',
        name: 'Griffin Renner',
        message: 'Okay',
        time: 'Yesterday',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
      ),
      ChatItemModel(
        id: '6',
        name: 'Marquise Kris',
        message: 'No worries, on progress',
        time: 'Yesterday',
        avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
      ),
      ChatItemModel(
        id: '7',
        name: 'Orville Rowe',
        message: 'End of the day',
        time: '2 days ago',
        avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        isArchived: true,
      ),
      ChatItemModel(
        id: '8',
        name: 'Dev Team',
        message: 'Updated Figma file shared',
        time: '2 days ago',
        avatar: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61',
        isGroup: true,
        isArchived: true,
      ),
      ChatItemModel(
        id: '9',
        name: 'Aarav Sharma',
        message: 'Meeting starts in 10 minutes.',
        time: '10:42 AM',
        avatar: 'https://images.unsplash.com/photo-1504257432389-52343af06ae3',
        unreadCount: 3,
        isOnline: true,
      ),
      ChatItemModel(
        id: '10',
        name: 'Priya Verma',
        message: 'I have shared the documents.',
        time: '10:20 AM',
        avatar: 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df',
        unreadCount: 1,
      ),
      ChatItemModel(
        id: '11',
        name: 'Flutter Developers',
        message: 'New package version released.',
        time: '09:55 AM',
        avatar: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3',
        unreadCount: 12,
        isGroup: true,
      ),
      ChatItemModel(
        id: '12',
        name: 'Ankit Yadav',
        message: 'Can you review my PR?',
        time: '09:30 AM',
        avatar: 'https://images.unsplash.com/photo-1504593811423-6dd665756598',
        isOnline: true,
      ),
      ChatItemModel(
        id: '13',
        name: 'Family Group',
        message: 'Dinner at 8 PM tonight.',
        time: 'Yesterday',
        avatar: 'https://images.unsplash.com/photo-1511632765486-a01980e01a18',
        unreadCount: 5,
        isGroup: true,
      ),
      ChatItemModel(
        id: '14',
        name: 'Neha Gupta',
        message: 'Thanks for your help 😊',
        time: 'Yesterday',
        avatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
      ),
      ChatItemModel(
        id: '15',
        name: 'UI/UX Team',
        message: 'Latest design has been approved.',
        time: 'Yesterday',
        avatar: 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d',
        isGroup: true,
      ),
      ChatItemModel(
        id: '16',
        name: 'Rohit Singh',
        message: 'See you tomorrow.',
        time: '3 days ago',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      ),
      ChatItemModel(
        id: '17',
        name: 'QA Team',
        message: 'All test cases passed.',
        time: '3 days ago',
        avatar: 'https://images.unsplash.com/photo-1517048676732-d65bc937f952',
        isGroup: true,
        isArchived: true,
      ),
      ChatItemModel(
        id: '18',
        name: 'Karan Mehta',
        message: 'Please call me when free.',
        time: 'Last week',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
        unreadCount: 2,
      ),
      ChatItemModel(
        id: '19',
        name: 'Marketing Team',
        message: 'Campaign report is ready.',
        time: 'Last week',
        avatar: 'https://images.unsplash.com/photo-1552664730-d307ca884978',
        isGroup: true,
      ),
      ChatItemModel(
        id: '20',
        name: 'Sonia Kapoor',
        message: 'Good morning!',
        time: 'Last week',
        avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        isOnline: true,
      ),
    ]);
  }
}


