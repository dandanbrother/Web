<%--
  Created by IntelliJ IDEA.
  User: nidingfan
  Date: 10/05/2018
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%--<%--%>
    <%--pageContext.setAttribute("APP_PATH", request.getContextPath());--%>
    <%--%>--%>
    <%--<script src="./WEB-INF/static/js/jquery-3.3.1.min.js"></script>--%>
    <%--<link href="./WEB-INF/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">--%>
    <%--<script src="./WEB-INF/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>--%>

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工添加的modal--%>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@google.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="dId" id="dept_add_select">
                                <%--部门--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>name</th>
                        <th>gneder</th>
                        <th>email</th>
                        <th>dep</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--页数选项--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;

    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2. 显示分页数据
                build_page_info(result);
                //3.分页条
                build_page_nav(result);
            }
        })
    }

    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        // emps.sort(emps.id);
        // console.log(emps);
        $.each(emps, function (index, item) {
            // alert(index);
            var empIdTd = $("<td></td>").append(item.id);
            var empNameTd = $("<td></td>").append(item.name);
            var genderTd = $("<td></td>").append(item.gender==='M'?'男':'女');
            var emailTd = $("<td></td>").append(item.email);
            var departmentTd = $("<td></td>").append(item.department.depName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(departmentTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }
    
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+ result.extend.pageInfo.pageNum+"页，总共"+ result.extend.pageInfo.pages +"页，总共"+ result.extend.pageInfo.total +"条记录");
        totalRecord = result.extend.pageInfo.total;
    }
    
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum===item)
                numLi.addClass("active");
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele) {
        $(ele)[0].reset();  //jQuery对象没有reset()，所以[0]取出DOM对象
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮
    $("#emp_add_modal_btn").click(function () {
        //每次点击新增按钮，完整重置表单
        reset_form("#empAddModal form");

        //点击新增时，发送ajax查询部门列表
        getDepts();
        $("#empAddModal").modal({
            backdrop:"static",
        })
    });
    
    function getDepts() {
        $("#empAddModal select").empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //显示部门信息
                // console.log(result);
                // $("#empAddModal select").append("")
                $.each(result.extend.depts, function () {
                   var optionEle = $("<option></option>").append(this.depName).attr("value", this.depId);
                   optionEle.appendTo("#empAddModal select");
                });
            }
        });

        function validate_add_form() {
            //正则校验
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)) {
                // alert("用户名可以为2-5位中文或者6-16位英文数字下划线组合");
                show_validate_msg("#empName_add_input", "error", "用户名可以为2-5位中文或者6-16位英文数字下划线组合")
                return false;
            } else {
                show_validate_msg("#empName_add_input", "success", "")
            }
            var email = $("#email_add_input").val();
            var regEmail = /(^[a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)) {
                // alert("邮箱格式错误");
                show_validate_msg("#email_add_input", "error", "邮箱格式错误");
                return false;
            } else {
                show_validate_msg("#email_add_input", "success", "")
            }

            return true;
        }

        function show_validate_msg(ele, status, msg) {
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if (status == "success") {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text();
            } else if (status == "error") {
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //员工名字输入框方法
        $("#empName_add_input").change(function () {
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+this.value,
                type:"POST",
                success:function (result) {
                    if (result.code == 100) {
                        show_validate_msg("#empName_add_input", "success", "用户名可用");
                        $("#emp_save_btn").attr("ajax-va", "success");
                    } else {
                        show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va", "error");
                    }
                }
            })
        });

        //保存员工
        $("#emp_save_btn").click(function () {
            //先校验数据
            // if(!validate_add_form()){
            //     return false;
            // }
            if ($(this).attr("ajax-va") == "error")
                return false;

            //提交数据
            // alert($("#empAddModal form").serialize());
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    if (result.code == 100) {
                        //保存成功
                        $("#empAddModal").modal("hide");
                        to_page(totalRecord);
                    } else {
                        //显示失败信息
                        if (result.extend.errorFields.email != undefined) {
                            show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                        }
                        if (result.extend.errorFields.name != undefined) {
                            show_validate_msg("#empName_add_input", "error", result.extend.errorFields.name);

                        }
                    }

                    // alert(result.message);
                }
            })
        })
    }

</script>
</body>

</html>
