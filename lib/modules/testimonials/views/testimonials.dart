import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/testimonials/controllers/testimonials_controller.dart';

class TestimonialsPage extends GetView<TestimonialsController> {
  const TestimonialsPage({super.key});

  Widget _buildCard(Testimonial data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(data.profileUrl),
                ),
                Positioned(
                  bottom: -8,
                  // move slightly outside the avatar for nice overlap
                  right: -8,
                  child: Container(
                    width: 30,
                    // make badge perfectly circular
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 20,
                    ),
                    // child: Text(
                    //   data.badgeText,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 15,
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              data.review,
              style: TextStyle(fontSize: 15, color: Colors.grey[900]),
            ),
            const SizedBox(height: 14),
            Row(
              children: List.generate(
                data.rating,
                (i) => Icon(Icons.star, color: Colors.amber, size: 17),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              data.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              data.role,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Testimonials',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      body: ListView.builder(
        itemCount: controller.testimonials.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (_, i) => _buildCard(controller.testimonials[i]),
      ),
    );
  }
}
