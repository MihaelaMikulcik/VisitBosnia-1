class TransactionSearchObject {
  bool? includeEventOrder;
  String? status;
  int? appUserId;

  TransactionSearchObject(
      {this.includeEventOrder, this.status, this.appUserId});

  TransactionSearchObject.fromJson(Map<String, dynamic> json) {
    includeEventOrder = json['includeEventOrder'];
    status = json['status'];
    appUserId = json['appUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['includeEventOrder'] = this.includeEventOrder;
    data['status'] = this.status;
    data['appUserId'] = this.appUserId;
    return data;
  }
}
