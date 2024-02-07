import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/booking_model.dart';
import 'package:movie_app/routes/name.dart';
import 'package:movie_app/utils/colors_list.dart'; // Adjust the import path as needed

class BookingConfirmationScreen extends StatelessWidget {
  final Booking booking;

  const BookingConfirmationScreen({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.application);
        }, icon: Icon(Icons.arrow_back_ios),

        ),
        title: Text("Booking Confirmation"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Details",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary_bg, // Theme color
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.white),
                      SizedBox(height: 10),
                      detailRow(context, "User Name:", booking.userName, Icons.account_circle),
                      detailRow(context, "Email:", booking.email, Icons.email),
                      detailRow(context, "Hall Name:", booking.hallName, Icons.location_on),
                      detailRow(context, "Date:", DateFormat('MMMM dd, yyyy').format(booking.date), Icons.event),
                      detailRow(context, "Selected Seats:", booking.selectedSeats.join(", "), Icons.chair),
                      detailRow(context, "Total Price:", "\$${booking.totalPrice.toStringAsFixed(2)}", Icons.money),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary_bg,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded button
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.application);

              },
              child: Text("Back to Home",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }

  Widget detailRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange),
          SizedBox(width: 10),
          Expanded(
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold,)),
          ),
          Expanded(
            child: Text(value, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
