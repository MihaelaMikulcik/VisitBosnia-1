import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/events/event.dart';

class EventProvider extends BaseProvider<Event> {
  EventProvider() : super("Event");
  @override
  Event fromJson(data) {
    // TODO: implement fromJson
    return Event.fromJson(data);
  }
}
