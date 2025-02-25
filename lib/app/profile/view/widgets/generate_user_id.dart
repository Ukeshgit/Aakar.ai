import 'dart:math';

String generateUserId() {
  final Random random = Random();
  final List<String> chars = '0123456789abcdef'.split('');
  String getRandomHex(int length) =>
      List.generate(length, (index) => chars[random.nextInt(16)]).join();

  String start = getRandomHex(5); // First part
  String end = getRandomHex(6); // Last part

  return "$start...$end";
}
