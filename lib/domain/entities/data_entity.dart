import 'package:equatable/equatable.dart';

import '../../data/models/item_model.dart';

class Data extends Equatable {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final String? perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;
  final List<ItemModel> items;

  const Data({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.items,
  });

  @override
  List<Object?> get props => [
        currentPage,
        firstPageUrl,
        from,
        lastPage,
        lastPageUrl,
        nextPageUrl,
        path,
        perPage,
        prevPageUrl,
        to,
        total,
        items,
      ];
}
