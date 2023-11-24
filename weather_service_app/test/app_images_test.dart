import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_service_app/resources/app_images.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.weather).existsSync(), isTrue);
  });
}
