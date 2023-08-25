import 'package:flutter/material.dart';


class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [

          const Row(
            children: [
              Text(
                "Payment Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Row(
            children: <Widget>[
              Expanded(
                // Place `Expanded` inside `Row`
                child: SizedBox(
                  height: 15, // <-- Your height
                  child: Text(
                    'Subtotal',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 30, // <-- Your height
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(children: [
                    Text(
                      '₹ 1,298',
                      style: TextStyle(color: Colors.black),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            children: <Widget>[
              Expanded(
                // Place `Expanded` inside `Row`
                child: SizedBox(
                  height: 15, // <-- Your height
                  child: Text(
                    'Standard Shipping',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 30, // <-- Your height
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(children: [
                    Text(
                      '₹ 500',
                      style: TextStyle(color: Colors.black),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            children: <Widget>[
              Expanded(
                // Place `Expanded` inside `Row`
                child: SizedBox(
                  height: 15, // <-- Your height
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 30, // <-- Your height
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(children: [
                    Text(
                      '- ₹ 200',
                      style: TextStyle(color: Colors.black),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: const Color(0xFFFFF2E1),
            height: 50,
            child: const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    // Place `Expanded` inside `Row`
                    child: SizedBox(
                      height: 15, // <-- Your height
                      child: Text(
                        'Order Total',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30, // <-- Your height
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: [
                        Text(
                          '₹ 1,598',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
