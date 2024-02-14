import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/view/screens/cinema_booking/screens/cinema_screen/cinema_screen_hall.dart';
import 'package:movie_app/view/screens/cinema_booking/widgets/date_selection_tile_widget.dart';

void main() {
  testWidgets('MovieDateAndHallSelectionScreen Test',
      (WidgetTester tester) async {
    Widget testWidget =
        ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return const MaterialApp(
        home: MovieDateAndHallSelectionScreen(
            movieName: 'Test Movie', releaseDate: '2023-01-01'),
      );
    });

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.text('Test Movie'), findsOneWidget);

    expect(find.text('In Theaters January 01, 2023'), findsOneWidget);

    await tester.tap(find.byType(DateSelectionTile).first);
    await tester.pump();
  });
}
