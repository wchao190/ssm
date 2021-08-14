
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
        var idTd = $("<th></th>").append(item.id);
        var nameTd = $("<th></th>").append(item.lastName);
        var genderTd = $("<th></th>").append(item.gender);
        var emailTd = $("<th></th>").append(item.email);
        var dptTd = $("<th></th>").append(item.department.dptName);
        /* 给button按钮添加一个 class 名 ,同时添加一个 属性 记录 id值,便于编辑使用*/
        var editTd = $("<button></button>").addClass("btn btn-success btn-sm edit_btn")
            .append("<span></span>").addClass("glyphicon glyphicon-pencil").attr("emp_id",item.id).append("编辑");
        var delTd = $("<button></button>").addClass("btn btn-danger btn-sm")
            .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
        /* 将操作按钮添加到 th 中 */
        var btnTd = $("<th></th>").append(editTd).append(" ").append(delTd);
        $("<tr></tr>").append(idTd).append(nameTd).append(genderTd).append(emailTd).append(dptTd).append(btnTd).appendTo("#emps_table tbody")
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
/* 为添加员工按钮绑定单击事件，弹出模态窗 */
$("#add_emp_btn").click(function () {
    /* 每次弹出先清空保存的值,清空错误提示信息 */
    clear_info(".modal-body form");

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
})
