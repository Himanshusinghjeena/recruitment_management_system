import 'dart:convert';

import 'package:flutter/services.dart';

class DataService {
  Future<List<Candidates>> getData() async {
    final jsonString =
        await rootBundle.loadString('assets/mockjson/candidates.json');
    final jsonResponse = jsonDecode(jsonString);

    List<Candidates> candidates = [];
    if (jsonResponse['candidates'] != null) {
      jsonResponse['candidates'].forEach((value) {
        candidates.add(Candidates.fromJson(value));
      });
    }
    return candidates;
  }
}

class Candidates {
  String? recruitmentNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? gender;
  String? recruitmentStatus;
  String? appliedDesignation;

  Candidates({
    this.recruitmentNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.gender,
    this.recruitmentStatus,
    this.appliedDesignation,
  });

  factory Candidates.fromJson(Map<String, dynamic> json) {
    return Candidates(
      recruitmentNumber: json['recruitment_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      gender: json['gender'],
      recruitmentStatus: json['recruitment_status'],
      appliedDesignation: json['applied_designation'],
    );
  }
}
