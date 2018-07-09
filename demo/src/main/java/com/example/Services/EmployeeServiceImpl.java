package com.example.Services;

import com.example.Beans.Employee;
import com.example.Beans.EmployeeExample;
import com.example.Beans.EmployeeExample.*;
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
		EmployeeExample employeeExample = new EmployeeExample();
		employeeExample.setOrderByClause("id ASC");
		return employeeMapper.selectByExampleWithDept(employeeExample);
	}

	@Override
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

//	检验用户名是否可用
	@Override
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
}
