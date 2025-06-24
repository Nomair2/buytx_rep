import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyCubit extends Cubit<PolicyState> {
  PolicyCubit() : super(InilPolicyState());

  accept() => emit(AcceptePolicyState());
  notAccept() => emit(NotacceptedPolicyState());
}

class PolicyState {}

class InilPolicyState extends PolicyState {}

class AcceptePolicyState extends PolicyState {}

class NotacceptedPolicyState extends PolicyState {}
