package com.atguigu.controller;

import com.atguigu.bean.Department;
import com.atguigu.bean.Msg;
import com.atguigu.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts(null);
        return Msg.success().add("dept",depts);
    }
}
