class FetchBranchTransferListPayload {
  int? menuId;
  int? page;
  int? itemsPerPage;

  FetchBranchTransferListPayload({this.menuId, this.page, this.itemsPerPage});

  FetchBranchTransferListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}




  class BranchTransferListData {
  int? id;
  TagDetails? tagDetails;
  String? createdAt;
  String? createdBy;
  String? fromBranch;
  String? toBranch;
  int? tagCount;

  BranchTransferListData(
      {this.id,
      this.tagDetails,
      this.createdAt,
      this.createdBy,
      this.fromBranch,
      this.toBranch,
      this.tagCount});

  BranchTransferListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagDetails = json['tag_details'] != null
        ? new TagDetails.fromJson(json['tag_details'])
        : null;
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    fromBranch = json['from_branch'];
    toBranch = json['to_branch'];
    tagCount = json['tag_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.tagDetails != null) {
      data['tag_details'] = this.tagDetails!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['from_branch'] = this.fromBranch;
    data['to_branch'] = this.toBranch;
    data['tag_count'] = this.tagCount;
    return data;
  }
}

class TagDetails {
  List<int>? tagDetails;

  TagDetails({this.tagDetails});

  TagDetails.fromJson(Map<String, dynamic> json) {
    tagDetails = json['tag_details'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_details'] = this.tagDetails;
    return data;
  }
}




class CreateBranchTransferPayload {
  int? menuId;
  String? branch;
  String? toBranch;
  List<int>? tags;

  CreateBranchTransferPayload(
      {this.menuId, this.branch, this.toBranch, this.tags});

  CreateBranchTransferPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    toBranch = json['to_branch'];
    tags = json['tags'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['to_branch'] = this.toBranch;
    data['tags'] = this.tags;
    return data;
  }
}
