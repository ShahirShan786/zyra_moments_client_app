import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/widgets/build_event_list_section.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/core/utls/debouncer.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer();
  String _searchQuery = '';

  @override
  void initState() {
    _loadEvents();
    super.initState();
  }

  @override
  void onReturnFromNextScreen() {
    _loadEvents();
  }

  void _loadEvents() {
    BlocProvider.of<EventBloc>(context)
        .add(GetAllDiscoverEventList(searchText: _searchQuery));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Events",
          fontSize: 25,
          FontFamily: 'roboto',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildSearchField(),
              SizedBox(height: height * 0.01),
              buildEventListSection(width, height),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSearchField() {
    return TextField(
      style: TextStyle(color: AppTheme.darkTextColorSecondary),
      cursorColor: AppTheme.darkTextColorSecondary,
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: AppTheme.darkTextColorSecondary),
        prefixIcon: Icon(Icons.search, color: AppTheme.darkTextColorSecondary),
        filled: true,
        fillColor: Colors.grey[900],
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppTheme.darkTextColorSecondary),
        ),
      ),
      onChanged: (value) {
        _searchQuery = value;
        _debouncer.run(() {
          _loadEvents();
        });
      },
    );
  }

 

 
}




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/events/event_details_screen/event_details_screen.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
// import 'package:zyra_momments_app/application/core/utls/debouncer.dart';

// class EventScreen extends StatefulWidget {
//   const EventScreen({super.key});

//   @override
//   State<EventScreen> createState() => _EventScreenState();
// }

// class _EventScreenState extends State<EventScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final Debouncer _debouncer = Debouncer();
//   String _searchQuery = '';

//   @override
//   void initState() {
//     _loadEvents();
//     super.initState();
//   }

//   @override
//   void onReturnFromNextScreen() {
//     // Reload vendors when coming back
//     _loadEvents();
//   }

//   void _loadEvents() {
//     BlocProvider.of<EventBloc>(context)
//         .add(GetAllDiscoverEventList(searchText: _searchQuery));
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: CustomText(
//           text: "Events",
//           fontSize: 25,
//           FontFamily: 'roboto',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               _buildSearchFeild(),
//               SizedBox(height: height * 0.01),
//               BlocBuilder<EventBloc, EventState>(
//                 builder: (context, state) {
//                   if (state is GetAllEventLoadingState) {
//                     return GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 6,
//                         childAspectRatio: 0.67,
//                         crossAxisCount: 2,
//                       ),
//                       itemCount: 4, // Number of shimmer placeholders
//                       itemBuilder: (context, index) {
//                         return Shimmer.fromColors(
//                           baseColor: AppTheme.darkShimmerBaseColor,
//                           highlightColor: AppTheme.darkShimmerHeighlightColor,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppTheme.darkSecondaryColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Image placeholder
//                                 Container(
//                                   width: double.infinity,
//                                   height: height * 0.15,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 5),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: height * 0.01),

//                                       Container(
//                                         width: width * 0.4,
//                                         height: 16,
//                                         color: Colors.white,
//                                       ),
//                                       SizedBox(height: height * 0.004),

//                                       Container(
//                                         width: width * 0.25,
//                                         height: 13,
//                                         color: Colors.white,
//                                       ),
//                                       SizedBox(height: height * 0.01),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Icon(
//                                                   Icons.calendar_today_outlined,
//                                                   size: 15,
//                                                   color: Colors.white),
//                                               Icon(Icons.timer_outlined,
//                                                   size: 16,
//                                                   color: Colors.white),
//                                               Icon(Icons.location_on,
//                                                   size: 15,
//                                                   color: Colors.white),
//                                             ],
//                                           ),
//                                           SizedBox(width: width * 0.02),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 width: width * 0.25,
//                                                 height: 15,
//                                                 color: Colors.white,
//                                               ),
//                                               SizedBox(height: height * 0.004),

//                                               Container(
//                                                 width: width * 0.2,
//                                                 height: 15,
//                                                 color: Colors.white,
//                                               ),
//                                               SizedBox(height: height * 0.004),
//                                               // Location placeholder (longer for variable location names)
//                                               Container(
//                                                 width: width * 0.35,
//                                                 height: 15,
//                                                 color: Colors.white,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: height * 0.01),
//                                       // Button placeholder
//                                       Container(
//                                         width: double.infinity,
//                                         height: height * 0.04,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else if (state is GetAllEVentFailureState) {
//                     return Center(
//                       child: CustomText(text: state.errorMessage),
//                     );
//                   } else if (state is EventNotFound) {
//                     return Center(
//                         child: Padding(
//                       padding: const EdgeInsets.only(top: 50),
//                       child: CustomText(
//                           text: "No Events available with this name"),
//                     ));
//                   } else if (state is GetAllEventSuccessState) {
//                     final eventList = state.events;
//                     return GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 6,
//                         childAspectRatio: 0.67,
//                         crossAxisCount: 2,
//                       ),
//                       itemCount: eventList.length,
//                       itemBuilder: (context, index) {
//                         final event = eventList[index];
//                         final formattedDate = event.date != null
//                             ? DateFormat('dd-MM-yyyy').format(event.date)
//                             : 'N/A';
//                         final formattedTime = event.date != null
//                             ? DateFormat('hh:mm a').format(event.date)
//                             : 'N/A';
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => EventDetailsScreen(
//                                 event: event,
//                               ),
//                             ));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppTheme.darkSecondaryColor,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(5),
//                                     child: event.posterImage != null &&
//                                             event.posterImage!.isNotEmpty
//                                         ? SizedBox(
//                                             width: double.infinity,
//                                             height: height * 0.15,
//                                             child: Image.network(
//                                               event.posterImage!,
//                                               fit: BoxFit.cover,
//                                               height: height * 0.15,
//                                               width: double.infinity,
//                                               loadingBuilder: (context, child,
//                                                   loadingProgress) {
//                                                 if (loadingProgress == null) {
//                                                   return child;
//                                                 }
//                                                 return Center(
//                                                     child:
//                                                         CircularProgressIndicator());
//                                               },
//                                               errorBuilder:
//                                                   (context, error, stackTrace) {
//                                                 return Container(
//                                                   height: height * 0.15,
//                                                   width: double.infinity,
//                                                   color: Colors.grey[300],
//                                                   child: Icon(Icons.error),
//                                                 );
//                                               },
//                                             ),
//                                           )
//                                         : Container(
//                                             height: height * 0.15,
//                                             width: double.infinity,
//                                             color: Colors.grey[300],
//                                             child:
//                                                 Icon(Icons.image_not_supported),
//                                           ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 5),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     spacing: height * 0.0026,
//                                     children: [
//                                       SizedBox(height: height * 0.001),
//                                       CustomText(
//                                         text: event.title ?? "No Title",
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       CustomText(
//                                         text: "Corporate",
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         color: AppTheme.darkTextLightColor,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             spacing: height * 0.007,
//                                             children: [
//                                               Icon(
//                                                 Icons.calendar_today_outlined,
//                                                 size: 15,
//                                                 color: AppTheme
//                                                     .darkTextColorSecondary,
//                                               ),
//                                               Icon(
//                                                 Icons.timer_outlined,
//                                                 size: 16,
//                                                 color: AppTheme
//                                                     .darkTextColorSecondary,
//                                               ),
//                                               Icon(
//                                                 Icons.location_on,
//                                                 size: 15,
//                                                 color: AppTheme
//                                                     .darkTextColorSecondary,
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(width: width * 0.02),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             spacing: height * 0.004,
//                                             children: [
//                                               CustomText(
//                                                 text: formattedDate,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 15,
//                                               ),
//                                               CustomText(
//                                                 text: formattedTime,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 15,
//                                               ),
//                                               CustomText(
//                                                 text: event.eventLocation ??
//                                                     "N/A",
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 15,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       // SizedBox(height: height * 0.002),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 2),
//                                         child: Container(
//                                           width: double.infinity,
//                                           height: height * 0.038,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             color:
//                                                 AppTheme.darkTextColorSecondary,
//                                           ),
//                                           alignment: Alignment.center,
//                                           child: CustomText(
//                                             text: "View Details",
//                                             color: AppTheme.darkBlackColor,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return const SizedBox();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   TextField _buildSearchFeild() {
//     return TextField(
//       style: TextStyle(color: AppTheme.darkTextColorSecondary),
//       cursorColor: AppTheme.darkTextColorSecondary,
//       decoration: InputDecoration(
//         hintText: 'Search...',
//         hintStyle: TextStyle(color: AppTheme.darkTextColorSecondary),
//         prefixIcon: Icon(Icons.search, color: AppTheme.darkTextColorSecondary),
//         filled: true,
//         fillColor: Colors.grey[900],
//         contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: BorderSide(color: Colors.white24),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: BorderSide(color: AppTheme.darkTextColorSecondary),
//         ),
//       ),
//       onChanged: (value) {
//         _searchQuery = value;
//         _debouncer.run(() {
//           _loadEvents();
//         });
//       },
//     );
//   }
// }
