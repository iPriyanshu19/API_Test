import 'package:api_test/models/employee.dart';
import 'package:api_test/screens/create_employee.dart';
import 'package:api_test/services/employee_services.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateEmployee(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Employee Data'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: EmployeeServices().getAllEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error fetching data!!"),
            );
          } else if (snapshot.hasData) {
            List<Employee> data = snapshot.data as List<Employee>;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    data[index].avatar ??
                                        "https://logo.clearbit.com/telegraph.co.uk",
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        data[index].name ?? "Name unavailable"),
                                    Text(data[index].phoneNumber ??
                                        "Phone number unavailable"),
                                    Text(data[index].address ??
                                        "Address Unavailable"),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => CreateEmployee(
                                              employee: data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Are you sure you want to delete employee?"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await EmployeeServices()
                                                        .deleteEmployee(
                                                            data[index].id!);
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child: const Text("No"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await EmployeeServices()
                                              .updateEmployeePartially(
                                            {'Name': "Ramu"},
                                            data[index].id!,
                                          );
                                        },
                                        icon:
                                            const Icon(Icons.favorite_outline))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
