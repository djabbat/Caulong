
class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final int birthDay;
  final int birthMonth;
  final int birthYear;
  final int birthHour;
  final String gender;

  const Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.birthDay,
    required this.birthMonth,
    required this.birthYear,
    required this.birthHour,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      birthDay: json['birth_day'],
      birthMonth: json['birth_month'],
      birthYear: json['birth_year'],
      birthHour: json['birth_hour'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'birth_day': birthDay,
        'birth_month': birthMonth,
        'birth_year': birthYear,
        'birth_hour': birthHour,
        'gender': gender,
      };
}