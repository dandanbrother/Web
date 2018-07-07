package com.example.Controller;

import com.example.Beans.Employee;
import com.example.Beans.Message;
import com.example.Services.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "/")
public class HomeController {

	@Autowired
	EmployeeService employeeService;

	@RequestMapping(value = "emps")
	@ResponseBody
	public Message getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
								   Model model) {
		PageHelper.startPage(pn,5);
		//startPage后紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();

		PageInfo pageInfo = new PageInfo(emps, 5);
//		model.addAttribute("pageInfo", pageInfo);
		return Message.sucess().add("pageInfo", pageInfo);
	}

	@RequestMapping(method = RequestMethod.GET)
	public String home() {
//		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
//		for (int i = 0; i < 100; i++) {
//			String uuid = UUID.randomUUID().toString().substring(0,5)+i;
//			employeeMapper.insertSelective(new Employee(null, uuid, "M", uuid+"@gmail.com", 1));
//		}
//		System.out.println("aaa完成");
		return "index";
	}

	@RequestMapping(value = "viewemps", method = RequestMethod.GET)
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
						  Model model) {
		//查询前调用
		PageHelper.startPage(pn,5);
		//startPage后紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();

		PageInfo pageInfo = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "lists";
	}
}
