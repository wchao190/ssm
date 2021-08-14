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
    <!--搭建首页-->
    <div class="container">
        <!--标题-->
        <div class="row" >
            <div class="col-xs-12"><h2>ssm-curd</h2></div>
        </div>
        <!--操作-->
        <div class="row">
            <div class="col-md-8 col-md-offset-8">
                <button type="button" class="btn btn-success">添加</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
        <!--内容区-->
        <div class="row">
            <div class="col-xs-12">
                <table class="table table-hover">
                    <tr>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>邮箱</th>
                        <th>性别</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.id}</th>
                            <th>${emp.lastName}</th>
                            <th>${emp.email}</th>
                            <th>${emp.gender}</th>
                            <th>${emp.department.dptName}</th>
                            <th>
                                <button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;编辑
                                </button>
                                <button type="button" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>

            </div>
        </div>
        <!--分页信息-->
        <div class="row">
            <!--分页信息-->
            <div class="col-md-6">
                当前第${pageInfo.pageNum}页,总共${pageInfo.pages}页,总计${pageInfo.total}条记录
            </div>
            <!--分页按钮-->
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${path}/emps?index=1">首页</a></li>
                        <!--如果有上一页，就显示上一页按钮-->
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${path}/emps?index=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <!--根据总页码数，显示导航页码-->
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <!--当前页，高亮显示-->
                            <c:if test="${page_num == pageInfo.pageNum}">
                                <li class="active"><a href="${path}/emps?index=${page_num}">${page_num}</a></li>
                            </c:if>
                            <c:if test="${page_num != pageInfo.pageNum}">
                                <li><a href="${path}/emps?index=${page_num}">${page_num}</a></li>
                            </c:if>
                        </c:forEach>
                        <!--如果有下一页，就显示下一页按钮-->
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${path}/emps?index=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${path}/emps?index=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    </body>
</html>
