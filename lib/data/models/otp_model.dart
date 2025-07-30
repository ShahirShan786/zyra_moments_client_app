

import 'package:zyra_momments_app/domain/entities/otp_entity.dart';

class OtpModel extends OtpEntity {
  OtpModel({required super.message});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      message: json["message"] ?? "",
    );
  }

  Map<String , dynamic> toJson(){
    return {
      "message" : message
    };
  }
}