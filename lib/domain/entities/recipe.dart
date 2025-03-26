// recipe.dart
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String title;
  final String image;
  final Map<String, dynamic> nutrition;
  final String summary;
  final List<String> instructions;

  const Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.nutrition,
    this.summary = '',
    this.instructions = const [],
  });

  @override
  List<Object> get props => [id, title, image, nutrition, summary, instructions];
}

