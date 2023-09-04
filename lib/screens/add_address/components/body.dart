import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/models/CountryModel.dart';
import 'package:omaliving/models/CustomerModel.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  final Address? arguments;
  const Body({super.key, required this.arguments});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  GraphQLService graphQLService = GraphQLService();

  CountryModel countryModel = CountryModel();

  AvailableRegion selectedSuggestion = AvailableRegion();

  Country selectedCountrySuggestion = Country();
  int countryPosition = 0;
  int statePosition = 0;
  bool isChecked = false;
  bool isChecked1 = false;

  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  void getDate() async {
    countryModel = await graphQLService.getregion();
    print(countryModel.countries!.length);
    setData();

    setState(() {});
  }

  void setData() async {
    if (widget.arguments?.firstname != null) {

      isVisible = true;

      firstNameController.text = widget.arguments?.firstname ?? '';
      lastNameController.text = widget.arguments?.lastname ?? '';
      phnoController.text = widget.arguments?.telephone ?? '';
      streetAddressController.text = widget.arguments?.street?.first ?? '';
      cityController.text = widget.arguments?.city ?? '';
      postalController.text = widget.arguments?.postcode ?? '';
      selectedCountrySuggestion = Country(id: countryModel.countries?[0]?.id);
      if (countryModel.countries!.isNotEmpty) {
        countryController.text =
            countryModel.countries?[0]?.fullNameEnglish ?? '';
        for (int i = 0;
            i < countryModel.countries![0].availableRegions!.length;
            i++) {
          if (countryModel.countries![0].availableRegions![i].name ==
              widget.arguments!.region!.region) {
            stateController.text =
                countryModel.countries![0].availableRegions![i].name ?? '';
            selectedSuggestion = AvailableRegion(
                id: countryModel.countries![0].availableRegions![i].id,
                code: countryModel.countries![0].availableRegions![i].code,
                name: countryModel.countries![0].availableRegions![i].name);
          }
        }
      }
      // stateController.text=widget.arguments?.region?.region??'';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'First Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  controller: firstNameController,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'Last Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  controller: lastNameController,
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Last Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: phnoController,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'GST Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  controller: gstController,
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "GST Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'Street Address',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 0),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  controller: streetAddressController,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'City',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  controller: cityController,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "City",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'State',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      controller: stateController,
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          hintText: "State",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                    suggestionsCallback: (pattern) {
                      return countryModel.countries![0].availableRegions!
                          .where((suggestion) => suggestion.name!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name ?? ''),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        selectedSuggestion = suggestion;
                        stateController.text = suggestion.name ?? '';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'Zip/Postal Code',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  controller: postalController,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Zip/Postal code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'Country',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                    controller: countryController,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        hintText: "Country",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  suggestionsCallback: (pattern) {
                    return countryModel.countries!
                        .where((suggestion) => suggestion.fullNameEnglish!
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion.fullNameEnglish ?? ''),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      selectedCountrySuggestion = suggestion;
                      countryController.text = suggestion.fullNameEnglish ?? '';
                    });
                  },
                ),
              ),

          Visibility(
            visible: isVisible,
            child: Row(
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        print(isChecked);
                      });
                    },
                  ),
                  const Text(
                    'Use as my default billing address',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(width: 5),

                ],
              ),
              ),

              Visibility(
                visible: isVisible,
                child: Row(
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked1 = value!;
                        print(isChecked1);
                      });
                    },
                  ),
                  const Text(
                    'Use as my default shipping address',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(width: 5),

                ],
              ),
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      backgroundColor: themecolor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String result;

                        if (widget.arguments?.id != null) {
                          result = await graphQLService.update_customer_address(
                              firstname: firstNameController.text,
                              lastname: lastNameController.text,
                              phNo: phnoController.text,
                              postalCode: postalController.text,
                              city: cityController.text,
                              address: streetAddressController.text,
                              regioncode: selectedSuggestion.code ?? '',
                              region: selectedSuggestion.name ?? '',
                              countryCode: selectedCountrySuggestion.id ?? '',
                              regionId: selectedSuggestion.id.toString(),
                              id: widget.arguments!.id.toString());
                              billingadd : isChecked ?? true ;
                              shippadd : isChecked1 ?? true ;
                        } else {
                          result = await graphQLService.add_customer_address(
                              firstname: firstNameController.text,
                              lastname: lastNameController.text,
                              phNo: phnoController.text,
                              postalCode: postalController.text,
                              city: cityController.text,
                              address: streetAddressController.text,
                              regioncode: selectedSuggestion.code ?? '',
                              region: selectedSuggestion.name ?? '',
                              countryCode: selectedCountrySuggestion.id ?? '',
                              regionId: selectedSuggestion.id.toString());
                        }
                        if (result == "200") {
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg: "Address Added Successfully");
                        } else {
                          Fluttertoast.showToast(msg: "Address Added Failed");
                        }
                      }
                    },
                    child: const Text(
                      'Save Address',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
