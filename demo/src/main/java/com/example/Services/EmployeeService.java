package com.example.Services;

import com.example.Beans.Employee;

import java.util.List;

public interface EmployeeService {
	List<Employee> getAll();
	void saveEmp(Employee employee);
	boolean checkUser(String empName);
}
