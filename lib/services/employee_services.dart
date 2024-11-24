import 'dart:convert';
import 'package:api_test/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  String baseUrl = "API base url";

  getAllEmployee() async {
    List<Employee> allEmployees = [];
    try {
      var response = await http.get(Uri.parse("${baseUrl}data"));
      if (response.statusCode == 200) {
        var employees = jsonDecode(response.body);
        for (var employee in employees) {
          Employee newEmployee = Employee.fromJson(employee);
          allEmployees.add(newEmployee);
        }
        return allEmployees;
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  createEmployee(Employee employee) async {
    try {
      var response = await http.post(
        Uri.parse("${baseUrl}data"),
        body: employee.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The employee is successfully created with the following detail: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  updateEmployeePartially(Map<String, dynamic> updatedData, int id) async {
    try {
      var response = await http.patch(
        Uri.parse("${baseUrl}data/$id"),
        body: updatedData,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company is suceesfully deleted with the following details:  ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }

  updateEmployee(Employee employee, int id) async {
    try {
      var response = await http.put(
        Uri.parse("${baseUrl}data/$id"),
        body: employee.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The employee is successfully deleted with the following detail: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }

  deleteEmployee(int id) async {
    try {
      var response = await http.delete(Uri.parse("${baseUrl}data/$id"));
      if (response.statusCode == 204 || response.statusCode == 200) {
        print(
            "The employee is successfully deleted with the following detail: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }
}
