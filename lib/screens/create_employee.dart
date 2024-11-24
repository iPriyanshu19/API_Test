import 'package:api_test/models/employee.dart';
import 'package:api_test/services/employee_services.dart';
import 'package:flutter/material.dart';

class CreateEmployee extends StatefulWidget {
  final Employee? employee;
  const CreateEmployee({super.key, this.employee});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name!;
      _addressController.text = widget.employee!.address!;
      _phoneController.text = widget.employee!.phoneNumber!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter employee name!";
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    helperText: "Your name here!",
                    hintText: "Enter the employee name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    helperText: "Your phone number here!",
                    hintText: "Enter the employee phone number",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    helperText: "Your address here!",
                    hintText: "Enter the employee address",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    Employee newEmployee = Employee(
                      name: _nameController.text,
                      phoneNumber: _phoneController.text,
                      address: _addressController.text,
                      avatar: "https://logo.clearbit.com/godaddy.com",
                    );

                    if (widget.employee != null) {
                      await EmployeeServices()
                          .updateEmployee(newEmployee, widget.employee!.id!);
                    } else {
                      await EmployeeServices().createEmployee(newEmployee);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Employee added successfully!"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.employee == null ? "Submit!" : "Update!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
