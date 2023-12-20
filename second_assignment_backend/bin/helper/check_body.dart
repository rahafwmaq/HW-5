checkBody({required List<String> keysCheck, required Map body}) {
  final List<String> keysNotFound = [];

  for (var element in keysCheck) {
    if (!body.containsKey(element)) {
      keysNotFound.add(element);
    }
  }
  if (keysCheck.length != body.length) {
    throw FormatException('the body should have this keys $keysCheck');
  }
  if (keysNotFound.isNotEmpty) {
    throw FormatException('the body should have this keys $keysNotFound');
  }
}
