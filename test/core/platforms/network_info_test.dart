import 'package:cars_app/core/platforms/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late InternetConnectionChecker connectionChecker;

  setUp(() {
    connectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(connectionChecker: connectionChecker);
  });

  group('verify network info impl', () {
    test('verify network info when connected', () async {
      // arrange
      when(connectionChecker.hasConnection).thenAnswer((_) async => true);
      // act
      final actual = await networkInfoImpl.isConnected();
      // assert
      expect(actual, true);
    });

    test('verify network info when disconnected', () async {
      // arrange
      when(connectionChecker.hasConnection).thenAnswer((_) async => false);
      // act
      final actual = await networkInfoImpl.isConnected();
      // assert
      expect(actual, false);
    });
  });
}
