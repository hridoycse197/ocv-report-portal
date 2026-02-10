class StatModel {
  final String approved;
  final String approvedLabel;
  final String ocv;
  final String ocvLabel;
  final String icpv;
  final String icpvLabel;

  StatModel({
    required this.approved,
    required this.approvedLabel,
    required this.ocv,
    required this.ocvLabel,
    required this.icpv,
    required this.icpvLabel,
  });

  factory StatModel.fromJson(Map<String, dynamic> json) {
    return StatModel(
      approved: json['approved'] ?? '১,৫২৮,১৩১',
      approvedLabel: json['approved_label'] ?? 'অনুমোদিত',
      ocv: json['ocv'] ?? '৭৬৭,২৩৩',
      ocvLabel: json['ocv_label'] ?? 'ওসিভি',
      icpv: json['icpv'] ?? '৭৬০,৮৯৮',
      icpvLabel: json['icpv_label'] ?? 'আইসিপিভি',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'approved_label': approvedLabel,
      'ocv': ocv,
      'ocv_label': ocvLabel,
      'icpv': icpv,
      'icpv_label': icpvLabel,
    };
  }

  // Create mock data for testing
  static StatModel mock() {
    return StatModel(
      approved: '১,৫২৮,১৩১',
      approvedLabel: 'অনুমোদিত',
      ocv: '৭৬৭,২৩৩',
      ocvLabel: 'ওসিভি',
      icpv: '৭৬০,৮৯৮',
      icpvLabel: 'আইসিপিভি',
    );
  }

  // Create list of mock data
  static List<StatModel> mockList({int count = 100}) {
    return List.generate(count, (index) => StatModel.mock());
  }
}

class MenuOption {
  final String title;
  final String icon;
  final String route;

  MenuOption({
    required this.title,
    required this.icon,
    required this.route,
  });

  static List<MenuOption> getSidebarOptions() {
    return [
      MenuOption(
        title: 'ড্যাশবোর্ড',
        icon: 'dashboard',
        route: '/dashboard',
      ),
      MenuOption(
        title: 'রিপোর্ট',
        icon: 'description',
        route: '/report',
      ),
      MenuOption(
        title: 'সেটিংস',
        icon: 'settings',
        route: '/settings',
      ),
    ];
  }
}
