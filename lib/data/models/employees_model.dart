class EmployeesModel {
  DataMain? data;

  EmployeesModel({this.data});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataMain.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataMain {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  DataMain(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  DataMain.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? joinDate;
  String? dateOfBirth;
  int? designationId;
  String? gender;
  int? mobile;
  int? landline;
  String? email;
  String? presentAddress;
  String? permanentAddress;
  String? profilePicture;
  String? resume;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? profileImage;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.joinDate,
      this.dateOfBirth,
      this.designationId,
      this.gender,
      this.mobile,
      this.landline,
      this.email,
      this.presentAddress,
      this.permanentAddress,
      this.profilePicture,
      this.resume,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    joinDate = json['join_date'];
    dateOfBirth = json['date_of_birth'];
    designationId = json['designation_id'];
    gender = json['gender'];
    mobile = json['mobile'];
    landline = json['landline'];
    email = json['email'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    profilePicture = json['profile_picture'];
    resume = json['resume'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['join_date'] = joinDate;
    data['date_of_birth'] = dateOfBirth;
    data['designation_id'] = designationId;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['landline'] = landline;
    data['email'] = email;
    data['present_address'] = presentAddress;
    data['permanent_address'] = permanentAddress;
    data['profile_picture'] = profilePicture;
    data['resume'] = resume;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['profile_image'] = profileImage;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
