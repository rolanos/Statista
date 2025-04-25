enum QuestionTypes {
  singleChoise('2b517e05-2113-414b-80b6-628a7164f85b'),
  multipleChoice('ee694d36-19f0-4cd2-a44f-19be00f31bdc');

  const QuestionTypes(this.id);

  QuestionTypes? tryParse(String? id) {
    if (id == singleChoise.id) {
      return singleChoise;
    }
    if (id == multipleChoice.id) {
      return multipleChoice;
    }
    return null;
  }

  final String id;
}
