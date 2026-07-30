import 'dart:io';

class TerminalService {
  static Future<String> run(
    String command,
    List<String> args, {
    String? workingDirectory,
  }) async {
    try {
      final result = await Process.run(
        command,
        args,
        workingDirectory: workingDirectory,
        runInShell: true,
      );

      if (result.stderr.toString().trim().isNotEmpty) {
        return result.stderr.toString();
      }

      return result.stdout.toString();
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> runShell(
    String command, {
    String? workingDirectory,
  }) async {
    try {
      final result = await Process.run(
        'bash',
        ['-c', command],
        workingDirectory: workingDirectory,
        runInShell: true,
      );

      if (result.stderr.toString().trim().isNotEmpty) {
        return result.stderr.toString();
      }

      return result.stdout.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
