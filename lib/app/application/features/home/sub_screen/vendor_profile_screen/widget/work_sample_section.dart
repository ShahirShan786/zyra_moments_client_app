import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';

import 'package:zyra_momments_app/application/config/widgets/app_text.dart' show CustomText;

class WorkSampleSection extends StatelessWidget {
  final List<WorkSample> workSamples;

  const WorkSampleSection({
    super.key,
    required this.workSamples,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: workSamples.length,
        itemBuilder: (context, index) {
          final workSample = workSamples[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Elegant Wedding Moments",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 8),
              CustomText(
                text: workSample.description,
                fontSize: 14,
              ),
              const SizedBox(height: 16),
              if (workSample.images.isNotEmpty)
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.5,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: workSample.images.length,
                  itemBuilder: (context, imgIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        workSample.images[imgIndex],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.transparent,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 40),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.transparent,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              const SizedBox(height: 24),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
