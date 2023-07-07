import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_FirstName',
                    hintText: 'MarkPlace_FirstName',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'MarkPlace_FirstNameV';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_LastName',
                    hintText: 'MarkPlace_LastName',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'MarkPlace_LastNameV';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_Email',
                    hintText: 'MarkPlace_Email',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  maxLength: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_ContactNo',
                    hintText: 'MarkPlace_ContactNo',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    String patttern = r'(^[0-9]*$)';
                    RegExp regExp = RegExp(patttern);
                    if (val!.isEmpty) {
                      return 'MarkPlace_mobileV';
                    } else if (val.length != 10) {
                      return 'MarkPlace_MobileCV1';
                    } else if (!regExp.hasMatch(val)) {
                      return 'MarkPlace_MobileCV1';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 0),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_Address',
                    hintText: 'MarkPlace_Address',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'MarkPlace_AddressV';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  maxLength: 6,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_PinCode',
                    hintText: 'MarkPlace_PinCode',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    String patttern = r'(^[0-9]*$)';
                    RegExp regExp = RegExp(patttern);
                    if (val!.isEmpty) {
                      return 'MarkPlace_PincodeV';
                    } else if (val.length != 6) {
                      return 'MarkPlace_PinCV';
                    } else if (!regExp.hasMatch(val)) {
                      return 'MarkPlace_PinCV1';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  maxLength: 6,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MarkPlace_PinCode',
                    hintText: 'MarkPlace_PinCode',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    String patttern = r'(^[0-9]*$)';
                    RegExp regExp = RegExp(patttern);
                    if (val!.isEmpty) {
                      return 'MarkPlace_PincodeV';
                    } else if (val.length != 6) {
                      return 'MarkPlace_PinCV';
                    } else if (!regExp.hasMatch(val)) {
                      return 'MarkPlace_PinCV1';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Country',
                    hintText: 'India',
                    //icon: Icon(Icons.person),
                    isDense: true,
                  ),
                  validator: (val) {
                    String patttern = r'(^[0-9]*$)';
                    RegExp regExp = RegExp(patttern);
                    if (val!.isEmpty) {
                      return 'MarkPlace_PincodeV';
                    } else if (val.length != 6) {
                      return 'MarkPlace_PinCV';
                    } else if (!regExp.hasMatch(val)) {
                      return 'MarkPlace_PinCV1';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
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
                    onPressed: () async {},
                    child: const Text('SAVE',style: TextStyle(fontSize: 18),),
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
