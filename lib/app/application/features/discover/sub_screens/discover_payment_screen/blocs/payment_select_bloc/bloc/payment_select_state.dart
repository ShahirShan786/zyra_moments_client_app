import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/domain/entities/payment_method.dart';

sealed class PaymentSelectState extends Equatable {
  const PaymentSelectState();
  
  @override
  List<Object?> get props => [];
}

final class PaymentSelectInitial extends PaymentSelectState {}

final class PaymentMethodSelected extends PaymentSelectState{
  final PaymentMethods selectedMethod;

 const PaymentMethodSelected({required this.selectedMethod});

   @override
  List<Object?> get props => [selectedMethod];
}