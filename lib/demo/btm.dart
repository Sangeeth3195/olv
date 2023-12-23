import 'package:flutter/material.dart';



class BTM extends StatefulWidget {
  const BTM({Key? key}) : super(key: key);

  @override
  State<BTM> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BTM>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _bodyView = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
        margin: const EdgeInsets.all(0),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 100),
        decoration: !isSelected
            ? null
            : BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            child,
            Text(label, style: const TextStyle(fontSize: 8)),
          ],
        ));
  }

  final List<String> _labels = ['Home', 'maps', 'camera'];

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = const [
      Icon(Icons.home_outlined),
      Icon(Icons.explore_outlined),
      Icon(Icons.camera_alt_outlined)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _bodyView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 65,
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            color: Colors.teal.withOpacity(0.1),
            child: TabBar(
                onTap: (x) {
                  setState(() {
                    _selectedIndex = x;
                  });
                },
                labelColor: Colors.white,
                unselectedLabelColor: Colors.blueGrey,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
                tabs: [
                  for (int i = 0; i < icons.length; i++)
                    _tabItem(
                      icons[i],
                      _labels[i],
                      isSelected: i == _selectedIndex,
                    ),
                ],
                controller: _tabController),
          ),
        ),
      ),
    );
  }
}
