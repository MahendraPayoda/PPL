class EngagementUploadResponse {
  bool? success;
  String? message;
  List<Engagements>? engagements;

  EngagementUploadResponse({this.success, this.message, this.engagements});

  EngagementUploadResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['engagements'] != null) {
      engagements = <Engagements>[];
      json['engagements'].forEach((v) {
        engagements!.add(Engagements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (engagements != null) {
      data['engagements'] = engagements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Engagements {
  dynamic id;
  String? engagementId;
  String? engagementType;
  String? eventName;
  dynamic uploadEventFile;
  int? pplPoints;
  int? eventPoints;
  int? winnerPoints;
  int? runnerPoints;
  int? participationPoints;
  dynamic qrCodeFile;
  String? dateTime;
  String? venue;
  String? registrationClosesOn;
  String? presenter;

  Engagements(
      {this.id,
        this.engagementId,
        this.engagementType,
        this.eventName,
        this.uploadEventFile,
        this.pplPoints,
        this.eventPoints,
        this.winnerPoints,
        this.runnerPoints,
        this.participationPoints,
        this.qrCodeFile,
        this.dateTime,
        this.venue,
        this.registrationClosesOn,
        this.presenter});

  Engagements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engagementId = json['engagementId'];
    engagementType = json['engagementType'];
    eventName = json['eventName'];
    uploadEventFile = json['uploadEventFile'];
    pplPoints = json['pplPoints'];
    eventPoints = json['eventPoints'];
    winnerPoints = json['winnerPoints'];
    runnerPoints = json['runnerPoints'];
    participationPoints = json['participationPoints'];
    qrCodeFile = json['qrCodeFile'];
    dateTime = json['dateTime'];
    venue = json['venue'];
    registrationClosesOn = json['registrationClosesOn'];
    presenter = json['presenter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['engagementId'] = engagementId;
    data['engagementType'] = engagementType;
    data['eventName'] = eventName;
    data['uploadEventFile'] = uploadEventFile;
    data['pplPoints'] = pplPoints;
    data['eventPoints'] = eventPoints;
    data['winnerPoints'] = winnerPoints;
    data['runnerPoints'] = runnerPoints;
    data['participationPoints'] = participationPoints;
    data['qrCodeFile'] = qrCodeFile;
    data['dateTime'] = dateTime;
    data['venue'] = venue;
    data['registrationClosesOn'] = registrationClosesOn;
    data['presenter'] = presenter;
    return data;
  }
}
