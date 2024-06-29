class ReportModel {
  final String reportContent;

  ReportModel({required this.reportContent});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      reportContent: json['reportContent'],
    );
  }
}
