enum MediaTabType {
  media,
  docs,
  links,
}

class MediaItemModel {
  final String id;
  final String imageUrl;

  MediaItemModel({
    required this.id,
    required this.imageUrl,
  });
}

class DocItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final String extension;

  DocItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.extension,
  });
}

class LinkItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String url;
  final String iconUrl;

  LinkItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.iconUrl,
  });
}