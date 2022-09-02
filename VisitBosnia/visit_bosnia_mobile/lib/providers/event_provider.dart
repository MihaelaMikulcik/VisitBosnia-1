import 'dart:convert';

import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/events/event.dart';

class EventProvider extends BaseProvider<Event> {
  EventProvider() : super("Event");
  @override
  Event fromJson(data) {
    // TODO: implement fromJson
    return Event.fromJson(data);
  }

  Future<int> GetNumberOfParticipants(int eventId) async {
    var url =
        "${BaseProvider.baseUrl}Event/GetNumberOfParticipants?eventId=$eventId";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
