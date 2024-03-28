part of 'financial_reports_cubit.dart';

@immutable
abstract class FinancialReportsState {}

class FinancialReportsInitial extends FinancialReportsState {}

class GetPartnerWatingOrderSuccess extends FinancialReportsState {}
class GetPartnerWatingOrderLoading extends FinancialReportsState {}
class GetPartnerWatingOrderError extends FinancialReportsState {}

class GetPartnerCurrentOrderSuccess extends FinancialReportsState {}
class GetPartnerCurrentOrderLoading extends FinancialReportsState {}
class GetPartnerCurrentOrderError extends FinancialReportsState {}

class GetPartnerHoldingOrderSuccess extends FinancialReportsState {}
class GetPartnerHoldingOrderLoading extends FinancialReportsState {}
class GetPartnerHoldingOrderError extends FinancialReportsState {}

class GetPartnerOldOrderSuccess extends FinancialReportsState {}
class GetPartnerOldOrderLoading extends FinancialReportsState {}
class GetPartnerOldOrderError extends FinancialReportsState {}

class ChangeStatusSuccess extends FinancialReportsState {}
class ChangeStatusLoading extends FinancialReportsState {}
class ChangeStatusError extends FinancialReportsState {}

class ChangeHoldState extends FinancialReportsState {}

class GetSalesOrdersSuccess extends FinancialReportsState {}
class GetSalesOrdersLoading extends FinancialReportsState {}
class GetSalesOrdersError extends FinancialReportsState {}

class GetPartnerOrdersSuccess extends FinancialReportsState {}
class GetPartnerOrdersLoading extends FinancialReportsState {}
class GetPartnerOrdersError extends FinancialReportsState {}