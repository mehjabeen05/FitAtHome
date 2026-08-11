import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fit_at_home/app.dart';

void main() {
  testWidgets('FitAtHomeApp launches to the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FitAtHomeApp());
    await tester.pump();

    expect(find.text('FitAtHome'), findsWidgets);
  });
}
