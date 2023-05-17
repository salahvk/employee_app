// ignore_for_file: use_build_context_synchronously

import 'package:employee_app/config/route_manager.dart';
import 'package:employee_app/data/providers/data_provider.dart';
import 'package:employee_app/data/repositories/fetch_employees_data.dart';
import 'package:employee_app/presentation/screens/employee_detail_screen.dart';
import 'package:employee_app/utils/color_manager.dart';
import 'package:employee_app/utils/logout_function.dart';
import 'package:employee_app/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      _currentPage++;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    FetchEmployeesData.getData(context, page: _currentPage);
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: true);
    final userData = provider.employeesModel?.data?.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(
          "Employee",
          style: getSemiBoldtStyle(color: ColorManager.textColor, fontSize: 16),
        ),
        actions: [
          InkWell(
            onTap: () {
              logoutFun(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: ColorManager.textColor,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addEmployeeScreen);
        },
        child: const Icon(Icons.add, size: 25),
      ),
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: userData?.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userData![index].profileImage!),
              ),
              title: Row(
                children: [
                  Text(userData[index].firstName ?? ''),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(userData[index].lastName ?? ''),
                  ),
                ],
              ),
              subtitle: Text(userData[index].mobile.toString()),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return EmployeeDetailScreen(
                    data: userData[index],
                  );
                }));
              },
            );
          },
        ),
      ),
    );
  }
}
