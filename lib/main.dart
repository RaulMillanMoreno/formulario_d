import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    home: FormD(),
  ));
}

class FormD extends StatefulWidget {
  const FormD({super.key});

  @override
  State<FormD> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<FormD> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _countryController = TextEditingController();
  String selectedCountry = '';
  List<String> filteredCountries = [];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void initState() {
    super.initState();
    selectedCountry = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raúl Millán-Salesians Sarrià 24/25'),
        backgroundColor: const Color.fromARGB(255, 180, 102, 200),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                FormBuilderTextField(//este es el contenedor de texto del principio, el cual esta conectado a la lista del final
                  name: 'country',
                  controller: _countryController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Es necesario seleccionar una opción')
                  ]),
                  decoration: const InputDecoration(
                    labelText: 'Autocomplete',
                    hintText: 'Start typing to search for a country...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      )
                    )
                  ),
                  onChanged: (query) {
                    setState(() {
                      if (query != null && query.isNotEmpty) {
                        filteredCountries = _allCountries
                            .where((country) => country
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      } else {
                        filteredCountries = [];
                      }
                    });
                  },
                ),
                if (filteredCountries.isNotEmpty)
                  Column(
                    children: filteredCountries.map((country) {
                      return ListTile(
                        title: Text(country),
                        onTap: () {
                          setState(() {
                            _countryController.text = country;
                            filteredCountries = [];
                          });
                        },
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker( //este es el datetimepicker, el cual permite seleccionar una fecha especifica de un calendario
                  name: 'fecha',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Es necesario seleccionar una fecha')
                  ]),
                  inputType: InputType.date,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  decoration: InputDecoration(
                    labelText: 'Date Picker',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      )
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () {
                        _formKey.currentState!.fields['date']?.didChange(null);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderDateRangePicker(//este es el daterangepicker, similar al datetimepiker pero en este de debe seleccionar un rango de fechas
                  name: 'rango_fecha',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Es necesario seleccionar un rango de fecha')
                  ]),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2030),
                  format: DateFormat('yyyy-MM-dd'),
                  decoration: InputDecoration(
                    labelText: 'Date Range',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                          width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date_range']
                          ?.didChange(null);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(//este es otro datetime, pero este en vez de ser un calendario hace que escojas una hora especifica
                  name: 'timer_p',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Es necesario seleccionar una hora')
                  ]),
                  inputType: InputType.time,//esto permite hacer que sean de horas
                  initialTime: TimeOfDay(hour: 8, minute: 0),//la hora inicial
                  decoration: InputDecoration(
                    labelText: 'Time Picker',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      )
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () {
                        _formKey.currentState!.fields['timer']
                          ?.didChange(null);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderFilterChip<String>(//este es un filterchip en el que escoges alguna de las opciones que te ofrecen.
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Input Chips (Filter Chips)',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      )
                    ),
                  ),
                  name: 'languages_filter',
                  selectedColor: Colors.grey,
                  options: const [
                    FormBuilderChipOption(
                      value: 'HTML',
                      avatar: SizedBox.shrink(), 
                      child: Chip(
                        label: Text('HTML'),
                        backgroundColor: Colors.blue,                            
                      ),                     
                    ),
                    FormBuilderChipOption(
                      value: 'CSS',
                      avatar: SizedBox.shrink(), 
                      child: Chip(
                        label: Text('CSS'),
                        backgroundColor: Colors.blue,                            
                      ),
                    ),
                    FormBuilderChipOption(
                      value: 'Java',
                      avatar: SizedBox.shrink(), 
                      child: Chip(
                        label: Text('Java'),
                        backgroundColor: Colors.blue,                            
                      ),
                    ),
                    FormBuilderChipOption(
                      value: 'Dart',
                      avatar: SizedBox.shrink(), 
                      child: Chip(
                        label: Text('Dart'),
                        backgroundColor: Colors.blue,                            
                      ),
                    ),
                    FormBuilderChipOption(
                      value: 'TypeScript',
                      avatar: SizedBox.shrink(), 
                      child: Chip(
                        label: Text('TypeScript'),
                        backgroundColor: Colors.blue,                            
                      ),
                    ),
                    FormBuilderChipOption(
                      value: 'Angular',
                      avatar: SizedBox.shrink(), 
                      child: Chip(
                        label: Text('Angular'),
                        backgroundColor: Colors.blue,                            
                      ),
                    ),
                  ],
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Es necesario seleccionar una opción')
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(// este es el boton flotante donde al pulsarlo mostrara los datos de lo que has seleccionado.
        onPressed: () {       
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formValues = _formKey.currentState!.value;
            showDialog(context: context,
              barrierDismissible: true, 
              builder: (BuildContext context){
                return AlertDialog(
                  icon: const Icon(Icons.check_circle),                
                  title: const Text('Submission Complete'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'autocomplete: ${formValues['country'] ?? 'No seleccionado'}'),
                      Text(
                        'date: ${formValues['fecha'] ?? 'No seleccionado'}'),
                      Text(
                        'date_range: ${formValues['rango_fecha'] ?? 'No seleccionado'}'),
                      Text(
                        'time: ${formValues['timer_p'] ?? 'No seleccionado'}'),
                      Text(
                        'filter_chip: ${formValues['languages_filter'] ?? 'No seleccionado'}'),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },          
            ); 
          }             
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}

const Set<String> _allCountries = {// esta es la lista de paises
  'United States', 'France', 'Spain', 'Germany', 'Canada', 'Australia',
  'Brazil', 'Italy', 'Japan', 'South Korea', 'India', 'Mexico', 'China',
  'Russia', 'South Africa', 'Argentina', 'United Kingdom', 'Netherlands',
  'Turkey', 'Switzerland', 'Sweden', 'Belgium', 'Austria', 'Norway', 'Denmark',
  'Finland', 'Poland', 'Greece', 'Portugal', 'New Zealand', 'Ireland', 'Czech Republic',
  'Hungary', 'Israel', 'Malaysia', 'Singapore', 'Thailand', 'Vietnam', 'Philippines',
  'Indonesia', 'Egypt', 'Saudi Arabia', 'United Arab Emirates', 'Pakistan', 'Bangladesh',
  'Nigeria', 'Colombia', 'Chile', 'Peru', 'Venezuela', 'Romania', 'Ukraine', 'Belarus',
  'Morocco', 'Algeria', 'Ethiopia', 'Kenya', 'Tanzania', 'Ghana', 'Uganda', 'Sri Lanka',
  'Nepal', 'Qatar', 'Kuwait', 'Bahrain', 'Jordan', 'Lebanon', 'Oman', 'Kazakhstan',
  'Uzbekistan', 'Azerbaijan', 'Georgia', 'Armenia', 'Luxembourg', 'Iceland', 'Malta',
  'Cyprus', 'Estonia', 'Latvia', 'Lithuania', 'Slovakia', 'Slovenia', 'Croatia', 'Bulgaria',
  'Serbia', 'Bosnia and Herzegovina', 'Montenegro', 'North Macedonia', 'Moldova', 'Albania',
  'Kosovo'
};
