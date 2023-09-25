import 'package:yawar_task/domain/entities/data_entity.dart';

import 'item_model.dart';

class DataModel extends Data {
  const DataModel({
    required super.currentPage,
    required super.firstPageUrl,
    required super.from,
    required super.lastPage,
    required super.lastPageUrl,
    required super.nextPageUrl,
    required super.path,
    super.perPage,
    required super.prevPageUrl,
    required super.to,
    required super.total,
    required super.items,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      currentPage: json['current_page'] ?? 0,
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      lastPageUrl: json['last_page_url'] ?? '',
      nextPageUrl: json['next_page_url'] ?? '',
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? '',
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
