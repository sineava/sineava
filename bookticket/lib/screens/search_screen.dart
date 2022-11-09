import 'package:bookticket/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_style.dart';
import '../widgets/double_text_widget.dart';
import '../widgets/icon_text_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20), vertical: AppLayout.getHeight(20)),
        children: [
          Gap(AppLayout.getHeight(40)),
          Text('What are\nyou looking for?', style: Styles.headLineStyle.copyWith(fontSize: 35)),
          Gap(AppLayout.getHeight(40)),
          Container(
            child: Row(
              children: [
                Container(
                  width: size.width * .44,
                  padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(AppLayout.getHeight(10))),
                    color:  Colors.white
                  ),
                  child: const Center(
                    child: Text('Airline tickets')
                  )
                ),
                Container(
                  width: size.width * .44,
                  child: const Center(child: Text('Hotels'))
                )
              ]
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
              color:  const Color(0xFFF4F6FD)
            )
          ),
          Gap(AppLayout.getHeight(25)),
          const AppIconText(icon: Icons.flight_takeoff_rounded, text: 'Depature'),
          Gap(AppLayout.getHeight(15)),
          const AppIconText(icon: Icons.flight_land_rounded, text: 'Arrival'),
          Gap(AppLayout.getHeight(25)),
          Container(
            padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(14), horizontal: AppLayout.getWidth(5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppLayout.getWidth(5)),
              color: const Color(0xD91130CE),
            ),
            child: Center(
              child: Text('find Tickets', style: Styles.textStyle.copyWith(color: Colors.white, fontSize: 16))
            )
          ),
          const Gap(25),
          const AppDoubleTextWidget(title: 'Upcoming Flights', linkTitle: 'View all'),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.44,
                height: AppLayout.getHeight(400),
                padding: EdgeInsets.all(AppLayout.getHeight(4)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 1,
                      spreadRadius: 1
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      height: AppLayout.getHeight(180),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/sit.jpg')
                        )
                      )
                    ),
                    Gap(AppLayout.getHeight(12)),
                    Text(
                      '20% discount on the early booking of this flight, Dont miss out this change',
                      style: Styles.headLineStyle2
                    )
                  ],
                )
              ),
              Expanded(
                child: Container()
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: size.width * 0.44,
                        height: AppLayout.getHeight(190),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                          color: Color(0xFF3DB8B8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 1,
                              spreadRadius: 1
                            )
                          ]
                        ),
                        padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(15), horizontal: AppLayout.getHeight(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Discount\nfor survey', style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                            Gap(AppLayout.getHeight(8)),
                            Text('Take the survey about our services and get discount', style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18)),
                          ],
                        )
                      ),
                      Positioned(
                        right: -45,
                        top: -40,
                        child: Container(
                          padding: EdgeInsets.all(AppLayout.getHeight(30)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 18, color: Color(0xFF189999)),
                            color: Colors.transparent,
                          )
                        )
                      )
                    ],
                  ),
                  const Gap(15),
                  Container(
                    width: size.width * 0.44,
                    height: AppLayout.getHeight(190),
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                      color: const Color(0xFFEC6545)
                    ),
                    child: Column(
                      children: [
                        Text('Take love', style: Styles.headLineStyle2.copyWith(color: Colors.white), textAlign: TextAlign.left),
                        Gap(AppLayout.getHeight(5)),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(text: '😍', style: TextStyle(fontSize: 32)),
                              TextSpan(text: '🥰', style: TextStyle(fontSize: 44)),
                              TextSpan(text: '😘', style: TextStyle(fontSize: 32)),
                            ]
                          )
                        )
                      ],
                    )
                  )
                ]
              )
            ],
          )
        ]
      )
    );
  }
}