// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:zenfoodapp/core/utils/appcolors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  final List<String> icons = <String>[
    'discount.png',
    'location.png',
    'drink.png',
    'fruit.png',
    'noodle.png',
    'pizza.png',
    'seafood.png',
  ];

  final List<String> filters = <String>[
    'Sour',
    'Fresh',
    'Sweet',
  ];
  final List<String> items = <String>[
    'Sour',
    'Fresh',
    'Sweet',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListView.builder(
                  itemCount: icons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index == 1
                            ? AppColors.buttonColorLightActive
                            : AppColors.buttonColorLightInactive,
                      ),
                      child: Center(
                        child: ImageIcon(
                          AssetImage(
                            'assets/icons/' + icons[index],
                          ),
                          size: 30,
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: new Container(
                        alignment: Alignment.center,
                        child: ListView.builder(
                            itemCount: filters.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: Text(
                                      filters[index],
                                      style: TextStyle(
                                          color: index == 1
                                              ? Colors.black
                                              : const Color(0xffbdc5c7),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    Expanded(
                        flex: 9,
                        child: ListView.builder(
                            itemCount: filters.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                margin: const EdgeInsets.only(
                                    left: 20, top: 5, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xfff9fffc),
                                ),
                                child: SizedBox(
                                  child: Stack(children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height: 300,
                                        padding: const EdgeInsets.only(
                                            left: 20, bottom: 30),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(5, 5),
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Watermelon Mojito',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                'White rum, sparking water...',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffbdc5c7),
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                '\$ 8,55',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/drink1.jpeg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 230,
                                        width: 230,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(5, 5),
                                                  blurRadius: 10,
                                                  color: AppColors
                                                      .buttonColorAdding),
                                            ],
                                            color: AppColors.buttonColorAdding),
                                        height: 50,
                                        width: 50,
                                        child: const Center(
                                          child: Text(
                                            '+',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 32),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            })),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Recomendded',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: ListView.builder(
                  itemCount: icons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                      width: 240,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(5, 5),
                              blurRadius: 20,
                              color: Colors.grey.withOpacity(0.1)),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/drink1.jpeg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Pink Negrodi',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '12\$',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18),
                                  )
                                ],
                              )
                            ]),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(5, 5),
                                        blurRadius: 10,
                                        color: Color(0xff44d2a6)),
                                  ],
                                  color: Color(0xff44d2a6)),
                              height: 50,
                              width: 50,
                              child: const Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
