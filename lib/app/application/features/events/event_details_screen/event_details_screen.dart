import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/bloc/evet_details_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/widgets/buid_event_info.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/widgets/buid_event_title.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/widgets/buid_map_section.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/widgets/build_about_section.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/widgets/build_booking_section.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/widgets/build_poster_image.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/get_coordinates_from_place_usecase.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';


class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => EvetDetailsBloc(Getcoordinatesfromplaceusecase())
        ..add(LoadEventLocationEvent(placeName: widget.event.eventLocation)),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(width, height),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        text: "Event Details",
        fontSize: 25,
        FontFamily: 'roboto',
      ),
    );
  }

  Widget _buildBody(double width, double height) {
    final createdDate = DateFormat('dd MMM yyyy').format(widget.event.createdAt);
    final hostingDate = DateFormat('dd-MM-yyyy').format(widget.event.date);
    final user = widget.event.hostId;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPosterImage(height ,widget.event),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildEventTitle(widget.event),
                buildEventInfo(createdDate, width, height , widget.event),
                buildMapSection(height),
                buildAboutSection(height, hostingDate, user, width , widget.event),
                buildBookingSection(context , height, width , widget.event),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

 

 









// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/event_booking_screen.dart';
// import 'package:zyra_momments_app/app/application/features/events/event_details_screen/bloc/evet_details_bloc.dart';
// import 'package:zyra_momments_app/app/data/models/event_model.dart';
// import 'package:zyra_momments_app/app/domain/usecases/get_coordinates_from_place_usecase.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
// import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';

// class EventDetailsScreen extends StatefulWidget {
//   final Event event;

//   const EventDetailsScreen({
//     super.key,
//     required this.event,
//   });

//   @override
//   State<EventDetailsScreen> createState() => _EventDetailsScreenState();
// }

// class _EventDetailsScreenState extends State<EventDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     final createdDate =
//         DateFormat('dd MMM yyyy').format(widget.event.createdAt);
//     final hostingDate = DateFormat('dd-MM-yyyy').format(widget.event.date);
//     final user = widget.event.hostId;

//     return BlocProvider(
//       create: (context) => EvetDetailsBloc(Getcoordinatesfromplaceusecase())
//         ..add(LoadEventLocationEvent(placeName: widget.event.eventLocation)),
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: CustomText(
//             text: "Event Details",
//             fontSize: 25,
//             FontFamily: 'roboto',
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildPosterImage(height),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildEventTitle(),
//                     _buildEventInfo(createdDate, width, height),
//                     _buildMapSection(height),
//                     _buildAboutSection(height, hostingDate, user, width),
//                     _buildBookingSection(height, width),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPosterImage(double height) {
//     return SizedBox(
//       width: double.infinity,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(5),
//         child: widget.event.posterImage!.isNotEmpty
//             ? Image.network(
//                 widget.event.posterImage!,
//                 fit: BoxFit.cover,
//                 height: height * 0.30,
//                 width: double.infinity,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Shimmer.fromColors(
//                     baseColor: Colors.grey.shade300,
//                     highlightColor: Colors.grey.shade100,
//                     child: Container(
//                       height: height * 0.30,
//                       width: double.infinity,
//                       color: Colors.white,
//                     ),
//                   );
//                 },
//                 errorBuilder: (_, __, ___) => Container(
//                   height: height * 0.15,
//                   width: double.infinity,
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.error),
//                 ),
//               )
//             : Container(
//                 height: height * 0.15,
//                 width: double.infinity,
//                 color: Colors.grey[300],
//                 child: const Icon(Icons.image_not_supported),
//               ),
//       ),
//     );
//   }

//   Widget _buildEventTitle() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           text: widget.event.title,
//           fontSize: 26,
//           fontWeight: FontWeight.bold,
//         ),
//         const SizedBox(height: 8),
//         CustomText(
//           text: "Coordinates",
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//           color: AppTheme.darkIconColor,
//         ),
//       ],
//     );
//   }

//   Widget _buildEventInfo(String createdDate, double width, double height) {
//     final user = widget.event.hostId;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: height * 0.005,
//       children: [
//         const SizedBox(height: 8),
//         _buildInfoRow(Icons.calendar_today_outlined, createdDate),
//         _buildInfoRow(Icons.timer_outlined,
//             "${widget.event.startTime} - ${widget.event.endTime}"),
//         _buildInfoRow(Icons.location_on, widget.event.eventLocation),
//         _buildInfoRow(Icons.confirmation_number_outlined,
//             "${widget.event.pricePerTicket} per ticket (${widget.event.ticketLimit} tickets available)"),
//         _buildInfoRow(Icons.person_2_outlined,
//             "Hosted by ${user.firstName} ${user.lastName}"),
//       ],
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 23, color: AppTheme.darkTextColorSecondary),
//         const SizedBox(width: 8),
//         Expanded(child: CustomText(text: text)),
//       ],
//     );
//   }

//   Widget _buildMapSection(double height) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: BlocBuilder<EvetDetailsBloc, EvetDetailsState>(
//         builder: (context, state) {
//           if (state is EvetDetailsLoading) {
//             return Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Container(
//                 height: height * 0.25,
//                 width: double.infinity,
//                 color: Colors.white,
//               ),
//             );
//           } else if (state is EvetDetailsLoaded) {
//             return SizedBox(
//               height: height * 0.25,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: state.targetPosition,
//                     zoom: 14,
//                   ),
//                   markers: state.markers,
//                 ),
//               ),
//             );
//           } else if (state is EvetDetailsError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox(
//               height: 150, child: Center(child: Text("Map loading...")));
//         },
//       ),
//     );
//   }

//   Widget _buildAboutSection(
//       double height, String hostingDate, user, double width) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(top: 8),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppTheme.darkBorderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _sectionTitle("About The Event"),
//           _subText("Registration Fee", "₹${widget.event.pricePerTicket}"),
//           _subText("Date", hostingDate),
//           _subText("Venue", widget.event.eventLocation),
//           _subText("Contact", ""),
//           _contactRow(Icons.phone, user.phoneNumber, width),
//           _contactRow(Icons.mail_rounded, user.email, width),
//           const SizedBox(height: 5),
//           _subText("Host Information", ""),
//           CustomText(
//             text:
//                 "${user.firstName} ${user.lastName} is organizing this event. For any queries, please contact them directly.",
//             maxLines: 3,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: AppTheme.darkTextLightColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) => CustomText(
//         text: title,
//         fontSize: 25,
//         fontWeight: FontWeight.bold,
//       );

//   Widget _subText(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           text: label,
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//         ),
//         if (value.isNotEmpty)
//           CustomText(
//             text: value,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: AppTheme.darkTextLightColor,
//           ),
//         const SizedBox(height: 4),
//       ],
//     );
//   }

//   Widget _contactRow(IconData icon, String text, double width) {
//     return Row(
//       children: [
//         Icon(icon, color: AppTheme.darkTextLightColor, size: width * 0.045),
//         const SizedBox(width: 8),
//         CustomText(
//           text: text,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: AppTheme.darkTextLightColor,
//         ),
//       ],
//     );
//   }

//   Widget _buildBookingSection(double height, double width) {
//     return Container(
//       margin: const EdgeInsets.only(top: 8),
//       padding: const EdgeInsets.all(8),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppTheme.darkBorderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: "Book Your Tickets",
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               CustomText(
//                 text: "Total Price : ",
//                 fontSize: 18,
//                 fontWeight: FontWeight.w400,
//               ),
//               CustomText(
//                 text: "₹${widget.event.pricePerTicket}",
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           PrimaryButton(
//               label: "Book Now",
//               ontap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => EventBookingScreen(
//                               events: widget.event,
//                               posterImage: widget.event.posterImage!,
//                             )));
//               }),
//         ],
//       ),
//     );
//   }
// }
