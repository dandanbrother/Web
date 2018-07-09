package com.example.Controller;


import com.example.Beans.Department;
import com.example.Beans.Message;
import com.example.Services.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;


    //返回所有的部门
	@RequestMapping("/depts")
	@ResponseBody
	public Message getDepts() {
		List<Department> list = departmentService.getDepts();
		return Message.sucess().add("depts", list);
	}
}
