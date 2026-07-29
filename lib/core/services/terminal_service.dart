import 'dart:io';

class TerminalService {
  static Future<String> run(
    String command,
    List<String> args,
  ) async {
    try {
      final result = await Process.run(command, args);

      if ((result.stderr as String).isNotEmpty) {
        return result.stderr.toString();
      }

      return result.stdout.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
