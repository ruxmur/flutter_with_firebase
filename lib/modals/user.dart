class UserModal {
  final String uid;

  UserModal({
      required this.uid,
    });
}

class UserData {
  final String uid;
  final String sugars;
  final String name;
  final int strength;

  UserData({required this.uid, required this.sugars, required this.name, required this.strength});
}