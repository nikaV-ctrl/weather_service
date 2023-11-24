import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_service_app/resources/app_svg_images.dart';

void main() {
  test('app_svg_images assets test', () {
    expect(File(AppSvgImages.clear).existsSync(), isTrue);
    expect(File(AppSvgImages.clouds).existsSync(), isTrue);
    expect(File(AppSvgImages.haze).existsSync(), isTrue);
    expect(File(AppSvgImages.humidity).existsSync(), isTrue);
    expect(File(AppSvgImages.location).existsSync(), isTrue);
    expect(File(AppSvgImages.pressure).existsSync(), isTrue);
    expect(File(AppSvgImages.rain).existsSync(), isTrue);
    expect(File(AppSvgImages.smoke).existsSync(), isTrue);
    expect(File(AppSvgImages.snow).existsSync(), isTrue);
    expect(File(AppSvgImages.sunrise).existsSync(), isTrue);
    expect(File(AppSvgImages.sunset).existsSync(), isTrue);
    expect(File(AppSvgImages.temperature).existsSync(), isTrue);
    expect(File(AppSvgImages.wind).existsSync(), isTrue);
  });
}
