import 'package:flutter_test/flutter_test.dart';
import 'package:tikka/ui/widget/spacings.dart';
import 'package:flutter/material.dart';

void main() {
  group('Spacings', () {
    test('spacing8 returns SizedBox with correct dimensions', () {
      expect(Spacings.spacing8, isA<SizedBox>());
      expect(Spacings.spacing8.width, 8.0);
      expect(Spacings.spacing8.height, 8.0);
    });

    test('spacing16 returns SizedBox with correct dimensions', () {
      expect(Spacings.spacing16, isA<SizedBox>());
      expect(Spacings.spacing16.width, 16.0);
      expect(Spacings.spacing16.height, 16.0);
    });

    test('spacing32 returns SizedBox with correct dimensions', () {
      expect(Spacings.spacing32, isA<SizedBox>());
      expect(Spacings.spacing32.width, 32.0);
      expect(Spacings.spacing32.height, 32.0);
    });

    test('spacing64 returns SizedBox with correct dimensions', () {
      expect(Spacings.spacing64, isA<SizedBox>());
      expect(Spacings.spacing64.width, 64.0);
      expect(Spacings.spacing64.height, 64.0);
    });

    test('spacing72 returns SizedBox with correct dimensions', () {
      expect(Spacings.spacing72, isA<SizedBox>());
      expect(Spacings.spacing72.width, 72.0);
      expect(Spacings.spacing72.height, 72.0);
    });

        test('spacing80 returns SizedBox with correct dimensions', () {
      expect(Spacings.spacing80, isA<SizedBox>());
      expect(Spacings.spacing80.width, 80.0);
      expect(Spacings.spacing80.height, 80.0);
    });

    test('spacing function returns SizedBox with correct dimensions', () {
      final size = 24.0;
      final spacing = Spacings.spacing(size);
      expect(spacing, isA<SizedBox>());
      expect(spacing.width, size);
      expect(spacing.height, size);
    });
  });
}
