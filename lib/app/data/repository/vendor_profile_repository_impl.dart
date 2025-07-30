import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/vendor_profile_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/app/domain/repository/vendor_profile_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

class VendorProfileRepositoryImpl implements VendorProfileRepository{
  VendorProfileRemoteDataSource vendorProfileRemoteDataSource = VendorProfileRemoteDataSourceImpl();
  @override
  Future<Either<Failure, VendorProfileModel>> getVendorProfileDetails(String categoryId) {
   
  return vendorProfileRemoteDataSource.getVendorProfileDetails(categoryId);
  }

  @override
  Future<Either<Failure, List<Vendor>>> getBestVenodrProfile() {
    return vendorProfileRemoteDataSource.getBestVendors();
   
  }
}