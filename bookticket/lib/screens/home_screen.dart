import 'package:bookticket/screens/ticket_view.dart';
import 'package:bookticket/utils/app_info_list.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/app_style.dart';
import '../widgets/double_text_widget.dart';
import 'hotel_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Good Morning', style: Styles.headLineStyle3),
                        const Gap(4),
                        Text('Book Tickets', style: Styles.headLineStyle4)
                      ]
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('images/img_1.png')
                        )
                      )
                    )
                  ]
                ),
                const Gap(25),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF4F6FD)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(FluentSystemIcons.ic_fluent_search_regular, color: Color(0xFFBFC205)),
                      Text('Search', style: Styles.headLineStyle4)
                    ]
                  )
                ),
                const Gap(40),
                const AppDoubleTextWidget(title: 'Upcoming Flights', linkTitle: 'View all'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 0),
                  child: Row(
                    // children: const [
                    //   TicketView(),
                    //   TicketView()
                    // ],
                    children: ticketList.map((item) => TicketView(ticket: item)).toList()
                  )
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hotels', style: Styles.headLineStyle2),
                    InkWell(
                      onTap: () {
                        print('are u okay');
                      },
                      child: Text('View all', style: Styles.textStyle.copyWith(color: Styles.primaryColor))
                    )
                  ]
                ),
                const Gap(15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: hotelList.map((singleHotel) => HotelScreen(hotel: singleHotel)).toList()
                  )
                ),
                const Gap(15)
              ]
            )
          )
        ]
      )
    );
  }
}