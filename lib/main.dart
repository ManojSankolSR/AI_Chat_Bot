import 'package:ai_app/homescreenTabs.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color.fromRGBO(110, 204, 175, 1),
                padding: const EdgeInsets.only(
                  bottom: kIsWeb ? 20 : 30,
                  top: kIsWeb ? 20 : 0,
                  left: kIsWeb ? 10 : 0,
                  right: kIsWeb ? 10 : 0,
                ),
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Image.asset(
                        "lib/assets/images/chatgptlogo.png",
                        color: Colors.black,
                        height: 230,
                      ),
                      Builder(
                        builder: (context) => IconButton(
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 35,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              Image.asset(
                "lib/assets/images/avatar2.png",
                height: 45,
              ),
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                "lib/assets/images/flutterlogo.png",
                height: 45,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              )),
        ),
        elevation: 0,
        centerTitle: true,
        title: BounceInDown(
          child: const Text(
            "AI Chat-Bot",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Align(
            alignment: Alignment.center,
            child: FadeInRight(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 30,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Colors.black),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'ChatGpt',
                    ),
                    Tab(
                      text: 'Dall-E',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: TabBarView(controller: _tabController, children: [
        HomeScreenTabs(chatgpt: true),
        HomeScreenTabs(
          chatgpt: false,
        ),
      ]),
    );
  }
}
