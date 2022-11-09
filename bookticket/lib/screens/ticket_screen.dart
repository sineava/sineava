import 'package:barcode_widget/barcode_widget.dart';
import 'package:bookticket/screens/ticket_view.dart';
import 'package:bookticket/widgets/app_layout.dart';
import 'package:bookticket/widgets/column_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_info_list.dart';
import '../utils/app_style.dart';
import '../widgets/ticket_tabs.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          const Gap(40),
          Text('Tickets', style: Styles.headLineStyle),
          const Gap(20),
          const AppTicketTabs(firstTab: 'Upcoming', secondTab: 'Previous'),
          Container(
            padding: EdgeInsets.only(left: AppLayout.getHeight(5)),
            child: TicketView(ticket: ticketList[0], isColor: true)
          ),
          Container(
            margin: EdgeInsets.only(left: AppLayout.getWidth(5), right: AppLayout.getWidth(5)),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColumnLayout(firstTitle: 'Flutter DB', secondTitle: 'Passenger', style: Styles.headLineStyle3),
                    ColumnLayout(firstTitle: 'DB5221364869', secondTitle: 'passport', style: Styles.headLineStyle4)
                  ],
                )
              ],
            )
          ),
          // const ThickContainer(),
          Container(
            margin: EdgeInsets.only(left: AppLayout.getWidth(5), right: AppLayout.getWidth(5)),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColumnLayout(firstTitle: '0055 444 77147', secondTitle: 'B2SG28', style: Styles.headLineStyle3),
                    ColumnLayout(firstTitle: 'Number of E-ticket', secondTitle: 'Booking code', style: Styles.headLineStyle4)
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: AppLayout.getWidth(10), right: AppLayout.getWidth(15), top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('images/visa.png', width: 40),
                              Text(' *** 2462', style: Styles.headLineStyle3)
                            ]
                          ),
                          const Gap(5),
                          Text('Payment method', style: Styles.headLineStyle4)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$249', style: Styles.headLineStyle3, textAlign: TextAlign.center),
                          const Gap(5),
                          Text('Price', style: Styles.headLineStyle4)
                        ],
                      )
                    ]
                  )
                ),
                const SizedBox(height: 1),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21)
                    )
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: 'https://sineava.netlify.app/',
                        drawText: false,
                        color: Styles.textColor,
                        width: double.infinity,
                        height: 70,
                      )
                    )
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}