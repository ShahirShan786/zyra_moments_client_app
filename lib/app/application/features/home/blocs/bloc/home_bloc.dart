import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/vendor_profile_usecases.dart';
import 'package:zyra_momments_app/data/models/category_model.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';
import 'package:zyra_momments_app/domain/usercases/category_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryUsecases categoryUsecases = CategoryUsecases();
  final VendorProfileUsecases vendorProfileUsecases = VendorProfileUsecases();
  HomeBloc() : super(HomeInitial()) {
    on<GetCategoryRequestEvent>((event, emit) async {
      emit(CategoryLoadingState());

      final result = await categoryUsecases.getCategories();

      result.fold((failure) {
        emit(GetCategoryFailureState(errorMessage: failure.message));
      }, (categoryList) {
        emit(GetCategorySuccessState(categories: categoryList));
       //  add(GetBestVendorRequestEvent());
      });
    });

    on<GetCategoryVendorReqeustEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());

        final result =
            await categoryUsecases.getVendorsCategories(categoryId: event.categoryId , search: event.serchText);

        result.fold((failure) {
          emit(GetCategoryVendorFailureState(errorMessage: failure.message));
        }, (vendors) {
          if(vendors.isEmpty){
            emit(NoVendorsFoundState());
          }else{
             emit(GetCategoryVendorSuccessState(vendorList: vendors));
          }
        });
      },
    );

    on<GetVendorProfileDetailsRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());

        final result = await vendorProfileUsecases
            .getVendorProfileDetails(event.categoryId);

        result.fold((failure) {
          emit(GetVendorProfileFaiureState(errorMessage: failure.message));
        }, (vendorDetails) {
          emit(GetvendorProfileSuccessState(vendorDetails: vendorDetails));
        });
      },
    );

    
  }
}
