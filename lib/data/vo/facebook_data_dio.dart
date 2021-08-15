class FacebookDataDio {
  String name;

  String firstName;

  String lastName;

  String email;

  int id;

  FacebookDataDio(
      this.name, this.firstName, this.lastName, this.email, this.id);
  factory FacebookDataDio.fromJson(Map<String, dynamic> json) {
    return FacebookDataDio(
      json['name'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['email'] as String,
      json['id'] as int,
    );
  }
}
