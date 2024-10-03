import 'OrderResponce.dart';

class OrderHistoryResponse {
  final List<OrderResponse> items;
  final int total;
  final int page;
  final int size;
  final int pages;
  final Links links;

  OrderHistoryResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
    required this.links,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      items: (json['items'] as List)
          .map((item) => OrderResponse.fromJson(item))
          .toList(),
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
      links: Links.fromJson(json['links']),
    );
  }
}

class Links {
  final String first;
  final String last;
  final String self;
  final String? next;
  final String? prev;

  Links({
    required this.first,
    required this.last,
    required this.self,
    this.next,
    this.prev,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      self: json['self'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}
