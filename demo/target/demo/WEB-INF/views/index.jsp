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
            <button class="btn btn-primary">新增</button>
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
        <div class="col-md-6">

        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=1",
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
    });

    function build_emps_table(result) {
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
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
        $("#page_info_area").append("当前第"+ result.extend.pageInfo.pageNum+"页，总共"+ result.extend.pageInfo.pages +"页，总共"+ result.extend.pageInfo.total +"条记录")
    }
    
    function build_page_nav(result) {

    }
</script>
</body>
</html>
