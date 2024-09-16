class Products {
  final String icon;
  final String offer;
  final String label;
  final String subLabel;

  Products({
    required this.icon,
    required this.offer,
    required this.label,
    required this.subLabel,
  });

  // Factory constructor to create a Products instance from a JSON object
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      icon: json['icon'] ?? '',
      offer: json['offer'] ?? '',
      label: json['label'] ?? '',
      subLabel: json['SubLabel'] ?? '',  // Note the capitalization
    );
  }

  // Method to convert a Products instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'offer': offer,
      'label': label,
      'SubLabel': subLabel,
    };
  }
}
