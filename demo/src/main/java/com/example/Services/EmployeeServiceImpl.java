package com.example.Services;

import com.example.Beans.Employee;
import com.example.DO.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	//查询所有员工
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
}
