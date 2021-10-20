import '../Providers/Option.dart';
class SingleQuestion{
  final String id;

  final String question;
  final List<Option>options;

  SingleQuestion({required this.id, required this.question,required this.options });
}