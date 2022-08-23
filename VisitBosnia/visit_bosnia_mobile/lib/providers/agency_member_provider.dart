import 'package:visit_bosnia_mobile/model/agency_member.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

class AgencyMemberProvider extends BaseProvider<AgencyMember> {
  AgencyMemberProvider() : super("AgencyMember");

  @override
  AgencyMember fromJson(data) {
    // TODO: implement fromJson
    return AgencyMember.fromJson(data);
  }
}
