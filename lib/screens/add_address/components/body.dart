import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

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
                child:TextFormField(
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "State",
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
                child: TextFormField(
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Country",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 20,
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
