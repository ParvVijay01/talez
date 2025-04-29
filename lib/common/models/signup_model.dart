class SignUpModel {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;

  SignUpModel({
    this.fName,
    this.lName,
    this.phone,
    this.email = '',
    this.password,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    if (lName != null && lName!.trim().isNotEmpty) {
      data['l_name'] = lName; // ✅ Only include if not null/empty
    }
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
