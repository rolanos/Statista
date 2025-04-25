enum Gender {
  male('Мужчина'),
  female('Женщина');

  const Gender(this.name);

  final String name;

  bool? isMan() {
    switch (this) {
      case male:
        return true;
      case female:
        return false;
    }
  }
}
