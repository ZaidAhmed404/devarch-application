import 'dart:io';

import 'package:devarch_digital/src/presentation/widgets/heading.dart';
import 'package:devarch_digital/src/presentation/widgets/text_button.dart';
import 'package:devarch_digital/src/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MilstoneDialogWidget extends StatefulWidget {
  MilstoneDialogWidget({
    super.key,
    required this.onConfirmFunction,
  });

  Function(String, String, String, String, String) onConfirmFunction;

  @override
  State<MilstoneDialogWidget> createState() => _MilstoneDialogWidgetState();
}

const List<String> proofs = <String>[
  'Location Proof',
  'Image Proof',
  'Text Proof',
];

class _MilstoneDialogWidgetState extends State<MilstoneDialogWidget> {
  String _selectedDate = '';
  XFile? pickedImage;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString().split(" ")[0];
        _showCalender = false;
      }
    });
  }

  String pickImageError = "";

  Future pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 60,
        maxHeight: 600,
        maxWidth: 600,
      );
      if (image == null) return;
      setState(() {
        pickedImage = image;
      });
    } on PlatformException catch (e) {
      pickImageError = "Failed to pick image";
    }
  }

  String _currentAddress = "Fetching location...";
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = "Location permissions are permanently denied.";
      });
      return;
    }
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get place name from coordinates
    _getPlaceName(_currentPosition!.latitude, _currentPosition!.longitude);
  }

  _getPlaceName(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Unable to fetch location name.";
      });
    }
  }

  String dateError = "";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  bool _showCalender = false;
  String proof = proofs.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingWiddget(text: "Milestone"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selectedDate != ""
                      ? Text(
                          _selectedDate,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                  TextButtonWidget(
                    buttonWidth: MediaQuery.of(context).size.width * 0.3,
                    function: () {
                      if (_showCalender) {
                        _showCalender = false;
                      } else {
                        _showCalender = true;
                      }
                      setState(() {});
                    },
                    text: 'Pick Date',
                    isSelected: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dateError,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_showCalender)
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  backgroundColor: Colors.white,
                  todayHighlightColor: Colors.red,
                  selectionColor: Colors.red,
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
              TextFieldWidget(
                hintText: "Price",
                controller: _priceController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                textFieldWidth: MediaQuery.of(context).size.width,
                onValueChange: (value) {},
                maxLines: 1,
                borderCircular: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                hintText: "Description",
                controller: _descriptionController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  } else if (value.length < 10) {
                    return 'Minimum description characters are 10';
                  }
                  return null;
                },
                textInputType: TextInputType.text,
                textFieldWidth: MediaQuery.of(context).size.width,
                onValueChange: (value) {},
                maxLines: 3,
                borderCircular: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Proof",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: proof,
                    icon: null,
                    elevation: 16,
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.red),
                    underline: null,
                    onChanged: (String? value) {
                      setState(() {
                        proof = value!;
                      });
                    },
                    items: proofs.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              if (proof == "Location Proof") Text(_currentAddress),
              const SizedBox(
                height: 10,
              ),
              if (proof == "Text Proof")
                TextFieldWidget(
                  hintText: "Text Proof",
                  controller: _textController,
                  isPassword: false,
                  isEnabled: true,
                  validationFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Text Proof is required';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  textFieldWidth: MediaQuery.of(context).size.width,
                  onValueChange: (value) {},
                  maxLines: 1,
                  borderCircular: 10,
                ),
              const SizedBox(
                height: 10,
              ),
              if (proof == "Image Proof")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (pickedImage != null)
                        ? SizedBox(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(pickedImage!.path),
                                  fit: BoxFit.cover,
                                )),
                          )
                        : const Text(
                            "Pick Image",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                    TextButtonWidget(
                      buttonWidth: MediaQuery.of(context).size.width * 0.3,
                      function: () async {
                        pickImage(ImageSource.gallery);
                      },
                      text: 'Pick Image',
                      isSelected: false,
                    ),
                  ],
                ),
              if (proof == "Image Proof" && pickedImage == null)
                Text(
                  pickImageError,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonWidget(
                    buttonWidth: MediaQuery.of(context).size.width * 0.3,
                    function: () {
                      Navigator.pop(context);
                    },
                    isSelected: false,
                    text: 'Cancel',
                  ),
                  TextButtonWidget(
                    buttonWidth: MediaQuery.of(context).size.width * 0.3,
                    function: () {
                      if (_selectedDate == "") {
                        dateError = "Please select a date";
                      } else {
                        dateError = "";

                        if (proof == "Image Proof" && pickedImage == null) {
                          pickImageError = "Please pick an image";
                        }
                        if (_formKey.currentState!.validate()) {
                          widget.onConfirmFunction(
                            _selectedDate,
                            _priceController.text,
                            _descriptionController.text,
                            proof,
                            proof == "Text Proof"
                                ? _textController.text
                                : proof == "Image Proof"
                                    ? pickedImage!.path
                                    : proof == "Location Proof"
                                        ? _currentAddress
                                        : "",
                          );
                          Navigator.pop(context);
                        }
                      }
                      setState(() {});
                    },
                    text: 'Ok',
                    isSelected: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
