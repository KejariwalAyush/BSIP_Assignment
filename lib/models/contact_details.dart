import 'dart:convert';

class ContactDetails {
  ContactDetails({
    required this.phone,
    required this.name,
    required this.ratio,
  });

  final String? phone;
  final String name;
  double ratio;

  factory ContactDetails.fromJson(String str) =>
      ContactDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactDetails.fromMap(Map<String, dynamic> json) => ContactDetails(
        phone: json["phone"],
        name: json["name"],
        ratio: json["ratio"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
        "name": name,
        "ratio": ratio,
      };
}
