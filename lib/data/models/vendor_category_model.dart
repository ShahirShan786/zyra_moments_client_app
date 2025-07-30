class Vendor {
  final String id;
  final String firstName;
  final String lastName;

  Vendor({required this.id, required this.firstName, required this.lastName});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class VendorResponse {
  final bool success;
  final List<Vendor> vendors;
  final int totalPages;
  final int currentPage;

  VendorResponse({
    required this.success,
    required this.vendors,
    required this.totalPages,
    required this.currentPage,
  });

 factory VendorResponse.fromJson(Map<String, dynamic> json) {
  return VendorResponse(
    success: json['success'] ?? false,
    vendors: (json['vendors'] as List)
        .map((v) => Vendor.fromJson(v))
        .toList(),
    totalPages: json['totalPages'] ?? 0,
    currentPage: json['currentPage'] ?? 0,
  );
}

}
