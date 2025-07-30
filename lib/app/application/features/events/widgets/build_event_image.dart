 import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';

Widget buildEventImage(Event event, double height) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: event.posterImage != null && event.posterImage!.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                height: height * 0.15,
                child: Image.network(
                  event.posterImage!,
                  fit: BoxFit.cover,
                  height: height * 0.15,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: height * 0.15,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.error),
                    );
                  },
                ),
              )
            : Container(
                height: height * 0.15,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported),
              ),
      ),
    );
  }