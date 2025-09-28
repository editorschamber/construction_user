class Site {
  final String imageUrl;
  final String siteName;
  final String siteDetails;
  final String location;
  String? startDate;
  String? endDate;

  Site(
      {required this.imageUrl,
      required this.siteName,
      required this.siteDetails,
      required this.location});
}
