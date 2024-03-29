/*MIT License

Copyright (c) 2023 Hung Phan (@hp210693)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:motel/bloc/report/report_bloc.dart';
import 'package:motel/bloc/report/report_event.dart';
import 'package:motel/bloc/report/report_state.dart';
import 'package:motel/ui/report/report_month_screen.dart';
import 'package:motel/ui/report/report_week_screen.dart';
import 'package:motel/ui/report/report_year_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportScreen> {
  final controller = PageController(
    initialPage: 0,
  );
  final List<Widget> pages = [
    const ReportYearScreen(),
    const ReportMonthScreen(),
    const ReportWeekScreen(),
  ];
  static int activePage = 0;

  @override
  void dispose() {
    controller.dispose();
    activePage = 0;
    super.dispose();
  }

  final textType = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22,
    //  backgroundColor: Colors.red,
    color: Colors.black,
    decoration: TextDecoration.none,
  );

  Widget titleView(String text) {
    double width = (MediaQuery.of(context).size.width / 1.6);
    const unSelected = Colors.white;
    const selected = Colors.amber;

    return Container(
      padding: const EdgeInsets.all(2.0),
      width: width + 8.0,
      decoration: BoxDecoration(
        color: Colors.amber[800],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              activePage = 0;
              controller.jumpToPage(0);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 2.0),
              decoration: BoxDecoration(
                color: (activePage == 0) ? selected : unSelected,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(8.0),
                ),
              ),
              width: width / 3,
              alignment: Alignment.center,
              child: Text("Năm", style: textType),
            ),
          ),
          InkWell(
            onTap: () {
              activePage = 1;
              controller.jumpToPage(1);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 2.0),
              decoration: BoxDecoration(
                color: (activePage == 1) ? selected : unSelected,
              ),
              width: width / 3,
              alignment: Alignment.center,
              child: Text("Tháng", style: textType),
            ),
          ),
          InkWell(
            onTap: () {
              activePage = 2;
              controller.jumpToPage(2);
            },
            child: Container(
              decoration: BoxDecoration(
                color: (activePage == 2) ? selected : unSelected,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(8.0),
                ),
              ),
              width: width / 3,
              alignment: Alignment.center,
              child: Text("Tuần", style: textType),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      color: Colors.black,
      home: BlocProvider(
        create: (_) =>
            ReportBloc()..add(ReportPageSelectedEvent(activePage, false)),
        child: viewChild(),
      ),
      builder: EasyLoading.init(),
    );
  }

  Widget viewChild() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          //navigateBlocState(state);
          return SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                PageView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    activePage = value;
                    log('state - page = $activePage');
                    context
                        .read<ReportBloc>()
                        .add(ReportPageSelectedEvent(activePage, true));
                  },
                  physics: const BouncingScrollPhysics(),
                  children: pages,
                ),
                Positioned(
                  top: 50,
                  child: titleView(''),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
