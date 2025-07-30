  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/category_screen/categoy_screen.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/data/models/category_model.dart';

Widget buildCategorySection(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: "Explore Event Categories",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.18,
          child: _buildCategoryList(),
        ),
      ],
    );
  }


    Widget _buildCategoryList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return _buildCategoryShimmer();
        } else if (state is GetCategoryFailureState) {
          return Center(child: CustomText(text: state.errorMessage));
        } else if (state is GetCategorySuccessState) {
          return _buildCategoryItems(state.categories);
        }
        return SizedBox(child: CustomText(text: "Something went wrong"));
      },
    );
  }

  Widget _buildCategoryItems(List<Categories> categories) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryItem(categories[index] , context);
      },
    );
  }

  Widget _buildCategoryItem(Categories category , BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => CategoyScreen(categoryId: category.id),
            ),
          )
              .then((_) {
            context.read<HomeBloc>().add(GetCategoryRequestEvent());
          });
        },
        child: Container(
          width: 140,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.darkButtonPrimaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomText(
            text: category.title,
            color: AppTheme.darkPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return Shimmer.fromColors(
      baseColor: AppTheme.darkShimmerBaseColor,
      highlightColor: AppTheme.darkShimmerHeighlightColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
            child: Container(
              width: 140,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }