import 'package:avalon/common/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('ProtocolRegistrationPlan', () {
    test('builds registry writes for URL protocol registration', () {
      const plan = ProtocolRegistrationPlan(
        scheme: 'avalon',
        executable: r'C:\Program Files\Avalon\Avalon.exe',
      );

      expect(plan.protocolKey, r'Software\Classes\avalon');
      expect(plan.commandKey, r'shell\open\command');
      expect(plan.protocolValueName, 'URL Protocol');
      expect(plan.protocolValue, '');
      expect(plan.command, r'"C:\Program Files\Avalon\Avalon.exe" "%1"');
    });
  });
}
