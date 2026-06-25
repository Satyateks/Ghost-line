class SuggestionsModel {
  List<Data>? data;
  bool? success;
  int? totalPages;
  int? pageSize;
  bool? hasPrevious;
  bool? hasNext;
  String? message;
  int? totalCount;
  int? currentPage;

  SuggestionsModel(
      {this.data,
        this.success,
        this.totalPages,
        this.pageSize,
        this.hasPrevious,
        this.hasNext,
        this.message,
        this.totalCount,
        this.currentPage});

  SuggestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'] ?? false;
    totalPages = json['totalPages'] ?? 0;
    pageSize = json['pageSize'] ?? 0;
    hasPrevious = json['hasPrevious'] ?? false;
    hasNext = json['hasNext'] ?? false;
    message = json['message'] ?? '';
    totalCount = json['totalCount'] ?? 0;
    currentPage = json['currentPage'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['totalPages'] = totalPages;
    data['pageSize'] = pageSize;
    data['hasPrevious'] = hasPrevious;
    data['hasNext'] = hasNext;
    data['message'] = message;
    data['totalCount'] = totalCount;
    data['currentPage'] = currentPage;
    return data;
  }
}

class Data {
  int? userid;
  String? name;
  String? phone;
  String? email;
  dynamic profileImage;
  String? designation;
  bool? following;

  Data(
      {this.userid,
        this.name,
        this.phone,
        this.email,
        this.profileImage,
        this.designation,
        this.following});

  Data.fromJson(Map<String, dynamic> json) {
    userid = json['userid'] ?? 0;
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    email = json['email'] ?? '';
    profileImage = json['profileImage'];
    designation = json['designation'] ?? '';
    following = json['following'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['designation'] = designation;
    data['following'] = following;
    return data;
  }
}
