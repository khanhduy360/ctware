// ignore_for_file: non_constant_identifier_names
// map to API
class RequestTypes {
  int Id;
  int reqType;
  String? reqDescription;

  RequestTypes({
    required this.Id,
    required this.reqType,
    required this.reqDescription,
  });

  factory RequestTypes.fromJson(Map<String, dynamic> responseData) {
    return RequestTypes(
      Id: responseData['Id'],
      reqType: responseData['reqType'],
      reqDescription: responseData['reqDescription'],
    );
  }
}
