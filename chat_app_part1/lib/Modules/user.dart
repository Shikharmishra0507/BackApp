class User{
  String id;
  String name;
  String gender;
  String age;

  var selected_options={};
  //map which directs question id ->option
  User({required this.id,required this.age,required this.gender,required this.name});
}