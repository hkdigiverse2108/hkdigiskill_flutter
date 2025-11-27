import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/testimonial/testimonial_model.dart';
import 'package:hkdigiskill/modules/testimonials/controllers/testimonials_controller.dart';
import 'package:hkdigiskill/modules/testimonials/widgets/testimonial_animation_wrapper.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';

class TestimonialsPage extends GetView<TestimonialsController> {
  const TestimonialsPage({super.key});

  Widget _buildCard(TestimonialModel data) {
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
                  backgroundImage: NetworkImage(data.image),
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
              data.description,
              style: TextStyle(fontSize: 15, color: Colors.grey[900]),
            ),
            const SizedBox(height: 14),
            Row(
              children: List.generate(
                data.rate,
                (i) => Icon(Icons.star, color: Colors.amber, size: 17),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              data.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              data.designation,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _testimonialShimmer() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: CustomShimmer(
          isLoading: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Avatar + Quote badge ---
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    bottom: -8,
                    right: -8,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // --- Review lines (3 lines) ---
              Container(
                height: 14,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 14,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 14,
                width: MediaQuery.of(Get.context!).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 14),

              // --- Star rating shimmer ---
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // --- Name ---
              Container(
                height: 16,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),

              // --- Role ---
              Container(
                height: 13,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) => _testimonialShimmer(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.testimonials.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (_, i) => TestimonialAnimationWrapper(
              index: i,
              child: _buildCard(controller.testimonials[i]),
            ),
          );
        }
      }),
    );
  }
}
