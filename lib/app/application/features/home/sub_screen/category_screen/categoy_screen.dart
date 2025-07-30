import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/category_screen/widgets/vendor_grid.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/category_screen/widgets/vendor_shimmer_effect.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/core/utls/debouncer.dart';
import 'package:zyra_momments_app/rout_aware_widget.dart';

class CategoyScreen extends RouteAwareWidget {
  final String categoryId;
  const CategoyScreen({super.key, required this.categoryId});

  @override
  State<CategoyScreen> createState() => _CategoyScreenState();
}

class _CategoyScreenState extends RouteAwareState<CategoyScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadVendors();
  }

  @override
  void onReturnFromNextScreen() {
    // Reload vendors when coming back
    _loadVendors();
  }

  void _loadVendors() {
    BlocProvider.of<HomeBloc>(context).add(
      GetCategoryVendorReqeustEvent(
          categoryId: widget.categoryId, serchText: _searchQuery),
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      BlocProvider.of<HomeBloc>(context)
          .add(GetCategoryVendorReqeustEvent(categoryId: widget.categoryId));
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Category",
          fontSize: 25,
          FontFamily: 'shafarik',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchFeild(),
            SizedBox(
              height: height * 0.02,
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is CategoryLoadingState) {
                return VendorShimmerLoading(height: height, width: width);
              } else if (state is NoVendorsFoundState) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: CustomText(text: "No vendor available with this name"),
                ));
              } else if (state is GetCategoryVendorFailureState) {
                Center(
                  child: CustomText(text: state.errorMessage),
                );
              } else if (state is GetCategoryVendorSuccessState) {
                final vendorList = state.vendorList;
                return VendorGrid(
                    height: height, width: width, vendorList: vendorList);
              }
              return SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  TextField _buildSearchFeild() {
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
          _loadVendors();
        });
      },
    );
  }
}
