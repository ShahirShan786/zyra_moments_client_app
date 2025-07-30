import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/app/data/repository/vendor_profile_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/vendor_profile_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

class VendorProfileUsecases {
  final VendorProfileRepository vendorProfileRepository = VendorProfileRepositoryImpl();
  Future<Either<Failure , VendorProfileModel>> getVendorProfileDetails(String categoryId){
  return vendorProfileRepository.getVendorProfileDetails(categoryId);
  }
  Future<Either<Failure , List<Vendor>>> getBestVenoders(){
    return vendorProfileRepository.getBestVenodrProfile();
  }
}