import 'package:equatable/equatable.dart';

class InteractionsCountTypes extends Equatable {
  final int like;
  final int love;
  final int care;
  final int haha;
  final int wow;
  final int sad;
  final int angry;

  const InteractionsCountTypes({
    required this.like,
    required this.love,
    required this.care,
    required this.haha,
    required this.wow,
    required this.sad,
    required this.angry,
  });

  @override
  List<Object?> get props => [
        like,
        love,
        care,
        haha,
        wow,
        sad,
        angry,
      ];
}
