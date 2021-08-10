package com.atguigu.test;

import com.atguigu.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml","classpath:springmvc.xml"})
@WebAppConfiguration
public class MvcTest {

    //传入 springmvc 的 ioc容器
    @Autowired
    WebApplicationContext context;
    // 虚拟的 mvc请求，获取请求处理的结果
    MockMvc mockMvc;
    @Before
    public void initMockMVC(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        // 模拟请求，并返回值; perform：提交请求; get：请求方式，并传入uri; param：请求参数; andReturn：返回结果
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps")).andReturn();
        // 请求成功后，请求域中会有 pageInfo
        MockHttpServletRequest request = mvcResult.getRequest();
        // 获取请求域中的属性的值
        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println(pageInfo);
        System.out.println("当前页码:"+pageInfo.getPageNum());
        System.out.println("总页码:"+ pageInfo.getPages());
        System.out.println("总记录数："+ pageInfo.getTotal());
        int[] navigateFirstPage = pageInfo.getNavigatepageNums();
        for (int i : navigateFirstPage){
            System.out.println(i);
        }
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println(employee);
        }
    }
}
