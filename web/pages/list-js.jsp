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
    <!--编辑员工弹窗-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="editEmp">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑员工</h4>
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
                                <p class="form-control-static" id="update_lastName"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="update_email" name="email" placeholder="请输入邮箱">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <!--定义内联单选按钮-->
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="update_gender1" value="男" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="update_gender2" value="女"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dptId" id="update_dept">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <!--弹窗底部操作按钮-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="update_Btn">更新</button>
                </div>
            </div>
        </div>
    </div>
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
                <button type="button" class="btn btn-danger" id="batch_del">批量删除</button>
            </div>
        </div>
        <!--内容区-->
        <div class="row">
            <div class="col-xs-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
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
        /* 进入页面就 获取首页数据 */
        var totalPage,currentPage;
        $(function () {
            to_page(1);
        });
        /* 将发送 ajax 请求抽取为一个方法，翻页时使用 */
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
        /* 解析 显示 员工 信息 */
        function build_emps_table(result) {
            /* 调用前 先清空信息 */
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var check = $("<th></th>").append($("<input type='checkbox' class='check_item'/>"));
                var idTd = $("<th></th>").append(item.id);
                var nameTd = $("<th></th>").append(item.lastName);
                var genderTd = $("<th></th>").append(item.gender);
                var emailTd = $("<th></th>").append(item.email);
                var dptTd = $("<th></th>").append(item.department.dptName);

                /* 给 编辑 按钮添加一个 class 名 ,同时添加一个 属性 记录 id值,便于编辑使用*/
                var editTd = $("<button></button>").addClass("btn btn-success btn-sm edit_btn")
                    .append("<span></span>").addClass("glyphicon glyphicon-pencil").attr("emp_id",item.id).append("编辑");
                /* 给 删除 按钮添加一个 class 名 ,同时添加一个 属性 记录 id值,便于删除使用*/
                var delTd = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                    .append("<span></span>").addClass("glyphicon glyphicon-trash").attr("del_id",item.id).append("删除");

                /* 将 编辑、删除 按钮添加到 th 中 */
                var btnTd = $("<th></th>").append(editTd).append(" ").append(delTd);
                $("<tr></tr>").append(check)
                    .append(idTd)
                    .append(nameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(dptTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody")
            });
        }
        /* 解析 显示 分页信息 */
        function build_page_info(result) {
            // 调用前先清空信息
            $("#page_info").empty();
            $("#page_info").append("当前第"+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+"页,总计"+result.extend.pageInfo.total+"条记录");
            totalPage = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }
        /* 解析 显示 分页条 */
        function build_page_nav(result) {
            /* 调用前先清空信息 */
            $("#page_nav").empty();
            var pageInfo = result.extend.pageInfo;
            /* 首页 */
            var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
            firstPageLi.click(function () {
                to_page(1);
            });
            /* 末页 */
            var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
            lastPageLi.click(function () {
                to_page(pageInfo.pages);
            });
            /* 上一页 */
            var prevPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("&laquo;")));
            prevPageLi.click(function () {
                to_page(pageInfo.pageNum -1);
            });
            /* 下一页 */
            var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("&raquo;")));
            nextPageLi.click(function () {
                to_page(pageInfo.pageNum +1);
            });
            var ul = $("<ul></ul>").addClass("pagination");
            /* 添加 首页、上一页 */
            ul.append(firstPageLi).append(prevPageLi);
            /* 如果没有上一页 禁用 首页、上一页 */
            if(!pageInfo.hasPreviousPage){
                firstPageLi.addClass("disabled");
                prevPageLi.addClass("disabled");
            }
            /* 如果没有下一页 禁用 末页、下一页 */
            if(!pageInfo.hasNextPage){
                lastPageLi.addClass("disabled");
                nextPageLi.addClass("disabled");
            }
            $.each(pageInfo.navigatepageNums,function (index,page_num) {
                var li = $("<li></li>").append($("<a></a>").attr("href","#").append(page_num));
                /* 当前页高亮显示 */
                if(pageInfo.pageNum === page_num ){
                    li.addClass("active")
                }
                /* 绑定单击事件，发送 ajax请求 跳转页面; 发送请求前，先清空 员工信息、分页信息、导航条 */
                li.click(function () {
                    to_page(page_num);
                });
                /* 循环添加 中间页 */
                ul.append(li);
            });
            /* 添加 下一页、末页 */
            ul.append(nextPageLi).append(lastPageLi);
            $("#page_nav").append(ul);
        }
        /* 为新增按钮 绑定单击事件，弹出模态窗 */
        $("#add_emp_btn").click(function () {
            /* 每次弹出先清空保存的值,清空错误提示信息 */
            clear_info("#addEmp form");

            /* 发送 ajax 请求，查询部门 */
            getDept("#dept");
            /* 通过元素的 id 调用模态框, 单击背景可以关闭弹窗 */
            $("#addEmp").modal();
        });
        /* 清空错误提示信息 */
        function clear_info(ele){
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }
        /* 查询部门信息 */
        function getDept(ele) {
            /* 每次查询，先清空缓存信息 */
            $(ele).empty();
            $.post(
                {"url":"${path}/depts",
                    "dataType": "json",
                    "success":function (data) {
                        /* 获取返回的信息，将部门信息通过 dom插入到 下拉选项 */
                        $.each(data.extend.dept,function (index,item) {
                            $("<option></option>").attr("value",item.dId).append(item.dptName).appendTo(ele);
                        });
                    },
                    "data":""}
            );
        }
        /* 校验用户名是否可用 */
        $("#lastName").change(function () {
            var name = this.value;
            $.get(
                {"url":"${path}/checkUser",
                    "dataType":"json",
                    "data":"name="+name,
                    "success":function (data) {
                        if(data.code === 200){
                            show_info("#lastName","success",data.extend.info);
                            $("#submitBtn").attr("used","enabled");
                        }else if(data.code === 100){
                            show_info("#lastName","error",data.extend.info);
                            $("#submitBtn").attr("used","disabled");
                        }
                    }}
            )
        });
        /* 保存新增员工 */
        $("#submitBtn").click(function () {
            /* 1.校验数据 */
            if(!data_validator()){
                return false;
            }

            /* 2.校验用户名是否可用 */
            if($(this).attr("used")==="disabled"){
                return false;
            }

            /* 3.提交请求 */
            $.post(
                {   "url":"${path}/emp",
                    "data":$("#addEmp form").serialize(),
                    "dataType":"json",
                    "success":function (data) {
                        /* 后端处理成功 */
                        if(data.code === 200){
                            /* 提交成功之后，关闭模态弹窗 */
                            $('#addEmp').modal('hide');
                            /* 发送请求，进入最后一页，查询添加状态,定义一个总页数，用查询条数代替总页数 */
                            to_page(totalPage);
                        }else{
                            /* 显示错误信息 */
                            if(data.extend.errors.lastName != undefined){
                                show_info("#lastName","error",data.extend.errors.lastName);
                            }
                            if(data.extend.errors.email != undefined){
                                show_info("#email","error",data.extend.errors.email);
                            }
                        }
                    }
                }
            )
        });
        /* 数据校验函数 */
        function data_validator() {
            /* 校验姓名 */
            var name = $("#lastName").val();
            var patt1 = /(^[a-z0-9_-]{6,12}$)|(^[\u2E80-\u9FFF]{2,8}$)/;
            var result1 = patt1.test(name);
            if(!result1){
                show_info("#lastName","error","用户名可以是2-8位中文或者6-12位英文和数字的组合");
                return false;
            }else{
                show_info("#lastName","success","");
            }
            /* 校验邮箱 */
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
        /* 定义前端提示信息 */
        function show_info(ele,status,msg) {
            /* 先清空元素 */
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
        /* 点击编辑按钮，弹窗模态弹窗 */
        $(document).on("click",".edit_btn",function () {
            /* 1.每次弹出先清空保存的值,清空错误提示信息 */
            clear_info(".modal-body form");

            /* 2.发送 ajax 请求，查询部门 */
            getDept("#update_dept");

            /* 3.查询员工信息，回显数据, 并将员工id 与更新按钮绑定 */
            var id = $(this).attr("emp_id");
            getEmp(id);
            $("#update_Btn").attr("update_id",id);

            /* 4.通过元素的 id 调用模态框, 参数表示使用背景,单击背景不可以关闭弹窗 */
            $("#editEmp").modal({
                backdrop:"static"
            });
        });
        /* 查询员工信息 */
        function getEmp(id) {
            $.get(
                {"url":"${path}/emp/"+id,
                    "dataType":"json",
                    "success":function (data) {
                        var empDt = data.extend.empData;
                        /* 回显姓名 */
                        $("#update_lastName").text(empDt.lastName);
                        /* 回显邮箱 */
                        $("#update_email").val(empDt.email);
                        /* 回显性别 */
                        $("#editEmp [name='gender']").val([empDt.gender]);
                        $("#editEmp [name='dptId']").val([empDt.dptId])
                    }
                }
            )
        }
        /* 更新员工信息 */
        $("#update_Btn").click(function () {
            /* 校验邮箱格式 */
            var em = $("#update_email").val();
            var patt2 = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            var result2 = patt2.test(em);
            if(!result2){
                show_info("#update_email","error","邮箱格式不正确!");
                return false;
            }else{
                show_info("#update_email","success","");
            }

            $.ajax(
                {
                    "url":"${path}/emp/"+$(this).attr("update_id"),
                    "dataType":"json",
                    "type":"PUT",
                    "data":$("#editEmp form").serialize(),
                    "success":function (data) {
                        if(data.code = 200){
                            alert("修改成功");
                        }
                        /*关闭模态弹窗*/
                        $("#editEmp").modal('hide');
                        /*返回当前页*/
                        to_page(currentPage);
                    }
                }
            )
        });
        /* 根据员工id删除员工信息*/
        $(document).on("click",".del_btn",function () {
            /*员工姓名*/
            var name = $(this).parent().parent().find("th:eq(2)").text();
            /*员工id*/
            var ids = $(this).attr("del_id");
            if(confirm("确认删除"+"【"+name+"】"+"信息？")){
                $.ajax(
                    {
                        "url":"${path}/emp/"+ids,
                        "dataType":"json",
                        "type":"DELETE",
                        "success":function (data) {
                            alert(data.msg);
                            to_page(currentPage);
                        }
                    }
                )
            }
        });
        /* 全选 全不选*/
        $("#check_all").click(function() {
            $(".check_item").prop("checked",$(this).prop("checked"));
        });
        /* 如果当前页 数据都被选中，全选按钮自动选中 */
        $(document).on("click",".check_item",function () {
            /* 如果被选中条数 = 当前页条数, 勾选"全选"框 */
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);
        });
        /* 批量删除 */
        $("#batch_del").click(function () {
            /* 被选中的员工 */
            var names="";
            var ids="";
            $.each($(".check_item:checked"),function (index,item) {
                names += $(item).parent().parent().find("th:eq(2)").text()+",";
                ids += $(item).parents("tr").find("th:eq(1)").text()+"-";
            });
            /* 去除尾部的 , */
            names = names.substring(0,names.length-1);
            ids = ids.substring(0,ids.length-1);
            if(confirm("确认删除"+"【"+names+"】"+"信息？")){
                $.ajax(
                    {
                        "url":"${path}/emp/"+ids,
                        "dataType":"json",
                        "type":"DELETE",
                        "success":function (data) {
                            alert(data.msg);
                            to_page(currentPage);
                        }
                    }
                )
            }
        })
    </script>

    </body>
</html>
