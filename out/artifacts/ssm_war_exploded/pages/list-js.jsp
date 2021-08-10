<%--
  Created by IntelliJ IDEA.
  User: wuc
  Date: 2021/8/7
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("path",request.getContextPath());
%>
<html>
    <head>
        <title>员工列表</title>
        <!--引入jquery-->
        <script src="${path}/static/js/jquery-3.6.0.min.js"></script>
        <!--引入样式-->
        <link rel="stylesheet" href="${path}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" >
        <!--引入js-->
        <script src="${path}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    </head>
    <body>
    <!--添加员工弹窗, 利用 bootstrap -->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="addEmp">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel">添加员工</h4>
                </div>
                <!--弹窗主体内容区-->
                <div class="modal-body">
                    <!--自作表单-->
                    <form class="form-horizontal">
                        <!--在 form-group 内定义输入框、下拉框等 -->
                        <div class="form-group">
                            <!--定义标题-->
                            <label class="col-sm-2 control-label">lastName</label>
                            <!--定义输入框, 长度10列, 并增加提示信息 -->
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="请输入姓名">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <!--定义内联单选按钮-->
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1" value="男" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2" value="女"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dptId" id="dept">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <!--弹窗底部操作按钮-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="submitBtn">保存</button>
                </div>
            </div>
        </div>
    </div>
    <!--搭建首页-->
    <div class="container">
        <!--标题-->
        <div class="row" >
            <div class="col-xs-12"><h2>ssm-curd</h2></div>
        </div>
        <!--操作-->
        <div class="row">
            <div class="col-md-8 col-md-offset-8">
                <button type="button" class="btn btn-success" id="add_emp_btn">添加</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
        <!--内容区-->
        <div class="row">
            <div class="col-xs-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>姓名</th>
                            <th>邮箱</th>
                            <th>性别</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <!--分页信息-->
        <div class="row">
            <!--分页信息-->
            <div class="col-md-6" id="page_info">

            </div>
            <!--分页条-->
            <div class="col-md-6" id="page_nav">

            </div>
        </div>
    </div>

    <script  type="text/javascript">
        // 进入页面就 获取首页数据
        var totalPage;
        $(function () {
            to_page(1);
        });
        // 将发送 ajax 请求抽取为一个方法，翻页时使用
        function to_page(index) {
            $.get(
                {"url":"${path}/emps",
                    "data":"index="+index, "success":function (result) {
                        build_emps_table(result);
                        build_page_info(result);
                        build_page_nav(result)
                    },
                    "dataType":"json"
                }
            );
        }

        /**
         * <button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;编辑
         </button>
         <button type="button" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;删除
         </button>
         */
        // 解析 显示 员工 信息
        function build_emps_table(result) {
            // 调用前 先清空信息
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var idTd = $("<th></th>").append(item.id);
                var nameTd = $("<th></th>").append(item.lastName);
                var genderTd = $("<th></th>").append(item.gender);
                var emailTd = $("<th></th>").append(item.email);
                var dptTd = $("<th></th>").append(item.department.dptName);
                //给button按钮添加一个 class 名
                var editTd = $("<button></button>").addClass("btn btn-success btn-sm")
                    .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
                var delTd = $("<button></button>").addClass("btn btn-danger btn-sm")
                    .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
                //将操作按钮添加到 th 中
                var btnTd = $("<th></th>").append(editTd).append(" ").append(delTd);
                $("<tr></tr>").append(idTd).append(nameTd).append(genderTd).append(emailTd).append(dptTd).append(btnTd).appendTo("#emps_table tbody")
            });
        }
        // 解析 显示 分页信息
        function build_page_info(result) {
            // 调用前先清空信息
            $("#page_info").empty();
            $("#page_info").append("当前第"+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+"页,总计"+result.extend.pageInfo.total+"条记录");
            totalPage = result.extend.pageInfo.total;
        }
        //解析 显示分页条
        function build_page_nav(result) {
            //调用前先清空信息
            $("#page_nav").empty();
            var pageInfo = result.extend.pageInfo;
            // 首页
            var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
            firstPageLi.click(function () {
                to_page(1);
            });
            // 末页
            var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
            lastPageLi.click(function () {
                to_page(pageInfo.pages);
            });
            // 上一页
            var prevPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("&laquo;")));
            prevPageLi.click(function () {
                to_page(pageInfo.pageNum -1);
            });
            // 下一页
            var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("&raquo;")));
            nextPageLi.click(function () {
                to_page(pageInfo.pageNum +1);
            });
            var ul = $("<ul></ul>").addClass("pagination");
            // 添加 首页、上一页
            ul.append(firstPageLi).append(prevPageLi);
            // 如果没有上一页 禁用 首页、上一页
            if(!pageInfo.hasPreviousPage){
                firstPageLi.addClass("disabled");
                prevPageLi.addClass("disabled");
            }
            // 如果没有下一页 禁用 末页、下一页
            if(!pageInfo.hasNextPage){
                lastPageLi.addClass("disabled");
                nextPageLi.addClass("disabled");
            }
            $.each(pageInfo.navigatepageNums,function (index,page_num) {
                var li = $("<li></li>").append($("<a></a>").attr("href","#").append(page_num));
                // 当前页高亮显示
                if(pageInfo.pageNum === page_num ){
                    li.addClass("active")
                }
                // 绑定单击事件，发送 ajax请求 跳转页面; 发送请求前，先清空 员工信息、分页信息、导航条
                li.click(function () {
                    to_page(page_num);
                });
                // 循环添加 中间页
                ul.append(li);
            });
            // 添加 下一页、末页
            ul.append(nextPageLi).append(lastPageLi);
            $("#page_nav").append(ul);
        }
        //为添加员工按钮绑定单击事件，弹出模态窗
        $("#add_emp_btn").click(function () {
            //发送 ajax 请求，查询部门
            getDept();
            $("#addEmp").modal();
        });

        //查询部门信息
        function getDept() {
            $.get(
                {"url":"${path}/depts",
                "dataType": "json",
                "success":function (data) {
                    //获取返回的信息，将部门信息通过 dom插入到 下拉选项
                    $.each(data.extend.dept,function (index,item) {
                        $("<option></option>").attr("value",item.dId).append(item.dptName).appendTo("#dept");
                    });
                },
                "data":""}
            );
        }

        //提交保存新增员工
        $("#submitBtn").click(function () {
            //1.校验数据
            if(!data_validator()){
                return false;
            }

            //2.提交请求
            $.post(
                    {   "url":"${path}/emp",
                        "data":$("#addEmp form").serialize(),
                        "dataType":"json",
                        "success":function (data) {
                            //提交成功之后，关闭模态弹窗
                            $('#addEmp').modal('hide');
                            //发送请求，进入最后一页，查询添加状态,定义一个总页数，用查询条数代替总页数，
                            to_page(totalPage);
                        }
                    }
            )
        });

        //数据校验函数
        function data_validator() {
            //校验姓名
            var name = $("#lastName").val();
            var patt1 = /(^[a-z0-9_-]{6,12}$)|(^[\u2E80-\u9FFF]{2,8}$)/;
            var result1 = patt1.test(name);
            if(!result1){
                show_info("#lastName","error","用户名可以是2-8位中文或者6-12位英文和数字的组合");
                return false;
            }else{
                show_info("#lastName","success","");
            }
            //校验邮箱
            var em = $("#email").val();
            var patt2 = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            var result2 = patt2.test(em);
            if(!result2){
                show_info("#email","error","邮箱格式不正确");
                return false;
            }else{
                show_info("#email","success","");
            }
            return  true;
        }
        //定义前端提示信息
        function show_info(ele,status,msg) {
            //先清空元素
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text("");
            if("success"===status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").append(msg);
            }else if("error"===status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").append(msg);
            }
        }
    </script>

    </body>
</html>
