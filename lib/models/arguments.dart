import 'package:pp_19/presentation/screens/privacy_temrs_view.dart';

class AgreementViewArguments {
  final AgreementType agreementType;
  final bool usePrivacyAgreement;

  const AgreementViewArguments({
    required this.agreementType,
     this.usePrivacyAgreement = false,
  });
}
