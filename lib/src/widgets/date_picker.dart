import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class FechaDisponibilidadPicker extends StatefulWidget {
  final Function(List<DateTime>) onDatesSelected;

  FechaDisponibilidadPicker({required this.onDatesSelected});

  @override
  _FechaDisponibilidadPickerState createState() =>
      _FechaDisponibilidadPickerState();
}

class _FechaDisponibilidadPickerState extends State<FechaDisponibilidadPicker> {
  List<DateTime> _selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.multi,
            firstDate: DateTime.now(), 
            lastDate: DateTime(2100), 
          ),
          value: _selectedDates,
          onValueChanged: (List<DateTime?>? dates) {
            setState(() {
              _selectedDates = dates
                      ?.where((date) => date != null)
                      .cast<DateTime>()
                      .toList() ??
                  [];
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            widget.onDatesSelected(_selectedDates);
            Navigator.pop(context); 
          },
          child: Text('Seleccionar fechas'),
        ),
      ],
    );
  }
}
