import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  bool isDone;

  Event(this.title, {this.isDone = false});

  Event.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        isDone = map['isDone'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}

class TabTree extends StatefulWidget {
  const TabTree({Key? key}) : super(key: key);

  @override
  State<TabTree> createState() => _TabTreeState();
}

class _TabTreeState extends State<TabTree> {
  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> _events = {};
  final _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    final docs = await FirebaseFirestore.instance.collection('events').get();
    for (var doc in docs.docs) {
      final date = DateTime.parse(doc.id);
      final events =
          List<Event>.from(doc.data()['events'].map((e) => Event.fromMap(e)));
      _events[date] = events;
    }
    setState(() {});
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
  }

  void _addEvent() {
    if (_eventController.text.isEmpty) return;

    setState(() {
      if (_events[today] == null) _events[today] = [];
      _events[today]!.add(Event(_eventController.text));
    });

    // Save to Firebase
    FirebaseFirestore.instance
        .collection('events')
        .doc(today.toIso8601String())
        .set({
      'events': _events[today]!.map((e) => e.toMap()).toList(),
    });

    _eventController.clear();
  }

  void _deleteEvent(Event event) {
    setState(() {
      _events[today]?.remove(event);
    });

    // Save to Firebase
    FirebaseFirestore.instance
        .collection('events')
        .doc(today.toIso8601String())
        .set({
      'events': _events[today]!.map((e) => e.toMap()).toList(),
    });
  }

  void _toggleEvent(Event event) {
    setState(() {
      event.isDone = !event.isDone;
    });

    // Save to Firebase
    FirebaseFirestore.instance
        .collection('events')
        .doc(today.toIso8601String())
        .set({
      'events': _events[today]!.map((e) => e.toMap()).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(today.toString().split(" ")[0]),
              TextField(
                cursorColor: Colors.green.shade200,
                controller: _eventController,
                decoration: InputDecoration(
                  labelText: '일정을 입력해주세요',
                ),
              ),
              ElevatedButton(
                child: Text(
                  '저장',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'bum',
                    fontSize: 18
                  ),
                ),
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
              ),
              Container(
                  child: TableCalendar(
                rowHeight: 43,
                headerStyle: HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 01, 01),
                lastDay: DateTime.utc(2030, 12, 31),
                onDaySelected: _onDaySelected,
                eventLoader: (day) =>
                    _events[day]?.map((e) => e.title).toList() ?? [],
              )),
              ...(_events[today]?.map((event) => ListTile(
                        title: Text(event.title),
                        leading: Checkbox(
                          value: event.isDone,
                          onChanged: (checked) => _toggleEvent(event),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteEvent(event),
                        ),
                      )) ??
                  []),
            ],
          ),
        ),
      ),
    );
  }
}
