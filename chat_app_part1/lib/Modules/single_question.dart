import 'Option.dart';
class SingleQuestion{
  final String id;

  final String question;
  final List<OptionProvider>options;
  SingleQuestion({required this.id, required this.question,required this.options });
}