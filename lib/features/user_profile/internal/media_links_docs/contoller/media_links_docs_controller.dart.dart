import 'package:get/get.dart';
import '../model/media_links_docs_model.dart';

class MediaLinksDocsController extends GetxController {
  final Rx<MediaTabType> selectedTab = MediaTabType.media.obs;

  final RxList<MediaItemModel> mediaItems = <MediaItemModel>[].obs;
  final RxList<DocItemModel> docItems = <DocItemModel>[].obs;
  final RxList<LinkItemModel> linkItems = <LinkItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void changeTab(MediaTabType type) {
    selectedTab.value = type;
  }

  void _loadDummyData() {
    mediaItems.assignAll([
      MediaItemModel(id: '1', imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330'),
      MediaItemModel(id: '2', imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e'),
      MediaItemModel(id: '3', imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee'),
      MediaItemModel(id: '4', imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'),
      MediaItemModel(id: '5', imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d'),
      MediaItemModel(id: '6', imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80'),
      MediaItemModel(id: '7', imageUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce'),
      MediaItemModel(id: '8', imageUrl: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61'),
      MediaItemModel(id: '9', imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30'),
      MediaItemModel(id: '10', imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9'),
      MediaItemModel(id: '11', imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb'),
      MediaItemModel(id: '12', imageUrl: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12'),
      MediaItemModel(id: '13', imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'),
      MediaItemModel(id: '14', imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d'),
      MediaItemModel(id: '15', imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80'),
    ]);

    docItems.assignAll([
      DocItemModel(
        id: '1',
        title: 'Boarding Pass.pdf',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '7/11/24',
        extension: 'PDF',
      ),
      DocItemModel(
        id: '2',
        title: 'Video_ Party_00.mp4',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '7/11/24',
        extension: 'MP4',
      ),
      DocItemModel(
        id: '3',
        title: 'IMG-25441-5678-87456.jpg',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '5/11/24',
        extension: 'JPG',
      ),
      DocItemModel(
        id: '4',
        title: 'Video_ Party_00.mp4',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '7/11/24',
        extension: 'MP4',
      ),
      DocItemModel(
        id: '5',
        title: 'IMG-96561-9758-874.png',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '5/11/24',
        extension: 'PNG',
      ),
      DocItemModel(
        id: '6',
        title: 'Boarding Pass.pdf',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '7/11/24',
        extension: 'PDF',
      ),
      DocItemModel(
        id: '7',
        title: 'IMG-25441-5678-87456.jpg',
        subtitle: 'UPI • 20 Jan 2025, 10:12 PM',
        date: '5/11/24',
        extension: 'JPG',
      ),
    ]);

    linkItems.assignAll([
      LinkItemModel(
        id: '1',
        title: 'Rapido - Bike Taxi',
        subtitle: 'Kadin Graham shared ride with you.',
        url: 'https://rkr.rapido.bike',
        iconUrl: 'https://play-lh.googleusercontent.com/UYUxEJj6wJwQ6nZ8k6lLJ4i9gF8',
      ),
      LinkItemModel(
        id: '2',
        title: 'Buy HRX By Hrithik Roshan Men White G...',
        subtitle: 'Buy HRX By Hrithik Roshan Men White...',
        url: 'https://www.myntra.com/mailers/shoes/hrx-by-hrithik-roshan',
        iconUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      ),
      LinkItemModel(
        id: '3',
        title: 'Google Meet',
        subtitle: 'Real-time meetings by Google. Using your browser...',
        url: 'https://meet.google.com/fmp-deaj-jam',
        iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Google_Meet_icon_%282020%29.svg',
      ),
      LinkItemModel(
        id: '4',
        title: 'HAMMER Bash Max Over The Ear Wirele...',
        subtitle: 'Bash Max Over The Ear Wireless Bluetooth Headphones...',
        url: 'https://amzn.in/d/K8XjRW',
        iconUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
      ),
      LinkItemModel(
        id: '5',
        title: 'Rapido - Bike Taxi',
        subtitle: 'Kadin Graham shared ride with you.',
        url: 'https://rkr.rapido.bike',
        iconUrl: 'https://play-lh.googleusercontent.com/UYUxEJj6wJwQ6nZ8k6lLJ4i9gF8',
      ),
      LinkItemModel(
        id: '6',
        title: 'Google Meet',
        subtitle: 'Real-time meetings by Google. Using your browser...',
        url: 'https://meet.google.com/fmp-deaj-jam',
        iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Google_Meet_icon_%282020%29.svg',
      ),
    ]);
  }
}