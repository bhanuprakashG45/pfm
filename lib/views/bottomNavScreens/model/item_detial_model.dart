class ItemDetailsModel {
  final String id;
  final String name;
  final List<String> type;
  final String quality;
  final String description;
  final String weight;
  final String pieces;
  final int serves;
  final int totalEnergy;
  final int carbohydrate;
  final int fat;
  final int protein;
  final double price;
  final String img;
  final bool bestSellers;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemDetailsModel({
    required this.id,
    required this.name,
    required this.type,
    required this.quality,
    required this.description,
    required this.weight,
    required this.pieces,
    required this.serves,
    required this.totalEnergy,
    required this.carbohydrate,
    required this.fat,
    required this.protein,
    required this.price,
    required this.img,
    required this.bestSellers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailsModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      type:
          (json['type'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
      quality: json['quality']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      weight: json['weight']?.toString() ?? '',
      pieces: json['pieces']?.toString() ?? '',
      serves:
          json['serves'] is int
              ? json['serves']
              : int.tryParse(json['serves']?.toString() ?? '0') ?? 0,
      totalEnergy:
          json['totalEnergy'] is int
              ? json['totalEnergy']
              : int.tryParse(json['totalEnergy']?.toString() ?? '0') ?? 0,
      carbohydrate:
          json['carbohydrate'] is int
              ? json['carbohydrate']
              : int.tryParse(json['carbohydrate']?.toString() ?? '0') ?? 0,
      fat:
          json['fat'] is int
              ? json['fat']
              : int.tryParse(json['fat']?.toString() ?? '0') ?? 0,
      protein:
          json['protein'] is int
              ? json['protein']
              : int.tryParse(json['protein']?.toString() ?? '0') ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      img: json['img']?.toString() ?? '',
      bestSellers: json['bestSellers'] ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'quality': quality,
      'description': description,
      'weight': weight,
      'pieces': pieces,
      'serves': serves,
      'totalEnergy': totalEnergy,
      'carbohydrate': carbohydrate,
      'fat': fat,
      'protein': protein,
      'price': price,
      'img': img,
      'bestSellers': bestSellers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  String get typeString => type.join(' | ');

  String get servesText => 'Serves $serves';

  double get discountedPrice {
    // You can implement discount logic here
    // For now, returning 20% discount as shown in UI
    return price * 0.8;
  }

  double get originalPrice => price;

  int get discountPercentage => 20; // You can make this dynamic

  String get nutritionalInfo => '''
Total Energy: $totalEnergy kcal
Carbohydrate: $carbohydrate g
Fat: $fat g
Protein: $protein g''';

  @override
  String toString() {
    return 'ItemDetailsModel(id: $id, name: $name, price: $price)';
  }
}
