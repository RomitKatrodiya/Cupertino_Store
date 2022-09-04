import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() {
  runApp(
    const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String name = "";
  String email = "";
  String location = "";

  String date = "";
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateTime.now().toString();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    data = [
      productsPage(context, width),
      searchPage(width),
      cartPage(context, width),
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: tabController.index,
        onTap: (val) {
          tabController.index = val;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.house_fill),
            icon: Icon(CupertinoIcons.house),
            label: "Products",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.search_circle_fill),
            icon: Icon(CupertinoIcons.search_circle),
            label: "Search",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.cart_fill),
            icon: Icon(CupertinoIcons.cart),
            label: "Cart",
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return data[index];
          },
        );
      },
    );
  }

  productsPage(context, width) {
    return SafeArea(
      child: Container(
        color: CupertinoColors.white,
        child: Column(
          children: [
            Expanded(
              child: titleText("Cupertino Store"),
            ),
            Expanded(
              flex: 6,
              child: ListView(
                children: Global.productsList
                    .map(
                      (e) => Container(
                        color: CupertinoColors.white,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 100,
                              width: width * 0.27,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e["image"]),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: width * 0.73,
                              padding:
                                  const EdgeInsets.only(right: 12, left: 3),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        Text(
                                          e["name"],
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          "\$${e["price"]}",
                                          style: const TextStyle(
                                            color: CupertinoColors.systemGrey,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Global.cartList.add(e);
                                            Global.cartList = Global.cartList
                                                .toSet()
                                                .toList();
                                          });
                                        },
                                        child: const Icon(
                                          CupertinoIcons.add_circled,
                                        )),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cartPage(context, width) {
    double tax = 0;
    double total = 0;

    for (var e in Global.cartList) {
      total = int.parse(e["price"]) + total;
    }

    tax = (total * 20 / 100);
    (Global.cartList.isEmpty) ? null : total = total + tax + 20;

    return SafeArea(
      child: Container(
        color: CupertinoColors.white,
        child: Column(
          children: [
            Expanded(
              child: titleText("Shopping Cart"),
            ),
            Expanded(
              flex: 6,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    const SizedBox(height: 5),
                    textField("Name", CupertinoIcons.person_alt, name),
                    const SizedBox(height: 5),
                    textField("Email", CupertinoIcons.mail, email),
                    const SizedBox(height: 5),
                    textField(
                        "Location", CupertinoIcons.location_solid, location),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 5, bottom: 10),
                      decoration: const BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(color: CupertinoColors.systemGrey),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.time,
                              color: CupertinoColors.systemGrey),
                          const SizedBox(width: 5),
                          const Text(
                            "Delivery time",
                            style:
                                TextStyle(color: CupertinoColors.systemGrey3),
                          ),
                          const Spacer(),
                          Text(date, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (val) {
                          setState(() {
                            date = val.toString();
                          });
                        },
                        use24hFormat: false,
                      ),
                    ),
                    Column(
                      children: Global.cartList
                          .map(
                            (e) => Container(
                              color: CupertinoColors.white,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 60,
                                    width: width * 0.20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemGrey
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(e["image"]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: width * 0.72,
                                    padding: const EdgeInsets.only(
                                        right: 12, left: 3),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Spacer(),
                                            Text(
                                              e["name"],
                                              style: const TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              "\$${e["price"]}",
                                              style: const TextStyle(
                                                color:
                                                    CupertinoColors.systemGrey,
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          "\$${e["price"]}",
                                          style: const TextStyle(
                                            color: CupertinoColors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            (Global.cartList.isEmpty)
                                ? "Shipping : \$00.0"
                                : "Shipping : \$20.0",
                            style: const TextStyle(
                                color: CupertinoColors.systemGrey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Tax : \$${tax.toString()}",
                            style: const TextStyle(
                                color: CupertinoColors.systemGrey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Total : \$${total.toString()}",
                            style: const TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  textField(hint, icon, value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: const BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: CupertinoColors.systemGrey),
        ),
      ),
      child: CupertinoTextField.borderless(
        placeholder: hint,
        onChanged: (val) {
          (value == name)
              ? name = val
              : (value == email)
                  ? email = val
                  : location = val;
        },
        prefix: Icon(
          icon,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  searchPage(width) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 65,
              padding: const EdgeInsets.all(10),
              child: const CupertinoSearchTextField(),
            ),
            Expanded(
              child: ListView(
                children: Global.productsList
                    .map(
                      (e) => Container(
                        color: CupertinoColors.white,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 100,
                              width: width * 0.27,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e["image"]),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: width * 0.73,
                              padding:
                                  const EdgeInsets.only(right: 12, left: 3),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        Text(
                                          e["name"],
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          "\$${e["price"]}",
                                          style: const TextStyle(
                                            color: CupertinoColors.systemGrey,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Global.cartList.add(e);
                                            Global.cartList = Global.cartList
                                                .toSet()
                                                .toList();
                                          });
                                        },
                                        child: const Icon(
                                          CupertinoIcons.add_circled,
                                        )),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
