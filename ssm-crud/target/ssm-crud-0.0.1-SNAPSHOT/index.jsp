<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>

<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>

</head>
<body>
    <!-- 搭建显示页面 -->
    <div class="container">
        <!-- 标题行 -->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!-- 按钮行 -->
        <div class="row">
            <div class="col-md-4 col-md-offset-6">
                <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
        
        <!-- Modal，员工修改的模态框 -->
        <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改员工</h4>
              </div>
              
              <div class="modal-body">

                <!-- 水平表单 -->
                <form class="form-horizontal">
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-6">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                       </div>
                      
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-6">
                          <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@google.com">
                          <span class="help-block"></span>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                          <label class="radio-inline">
                            <input type="radio" name="gender" id="gender_M_update_input" value="M" checked="checked"> 男
                          </label>
                          <label class="radio-inline">
                            <input type="radio" name="gender" id="gender_F_update_input" value="F"> 女
                          </label>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                          <!-- 提交部门ID即可查询 -->
                          <select class="form-control" name="deptId" id="update_emp_select"></select>
                        </div>
                      </div>
                </form>
              
              </div>
              
              <div class="modal-footer">
                <button type="button" class="btn btn-default" id="emp_cancel_btn" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
              </div>
              
            </div>
          </div>
         </div>
        
        
        <!-- Modal，员工添加的模态框 -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
              </div>
              
              <div class="modal-body">

                <!-- 水平表单 -->
                <form class="form-horizontal">
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-6">
                          <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="employeeName">
                          <span class="help-block"></span>
                        </div>
                       </div>
                      
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-6">
                          <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@google.com">
                          <span class="help-block"></span>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                          <label class="radio-inline">
                            <input type="radio" name="gender" id="gender_M_add_input" value="M" checked="checked"> 男
                          </label>
                          <label class="radio-inline">
                            <input type="radio" name="gender" id="gender_F_add_input" value="F"> 女
                          </label>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                          <!-- 提交部门ID即可查询 -->
                          <select class="form-control" name="deptId" id="add_emp_select"></select>
                        </div>
                      </div>
                </form>
              
              </div>
              
              <div class="modal-footer">
                <button type="button" class="btn btn-default" id="emp_cancel_btn" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
              </div>
              
            </div>
          </div>
         </div>
        
        
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
                            <th>ID</th>
                            <th>员工姓名</th>
                            <th>性别</th>
                            <th>邮箱</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    
                    <tbody></tbody>
                    
                </table>
            </div>
        </div>
        <!-- 显示分页信息 -->
        <div class="row">
            
            <!-- 分页文字信息 -->
            <div class="col-md-6" id="page_info_area"></div>
            
            <!-- 分页条信息 -->
            <div class="col-md-6" id="page_nav_area"></div>
        </div>
    </div>
    
    <script type="text/javascript">
        var totalRecord, currentPageNum;
    
        //1、页面加载完成后，发送ajax请求，得到分页数据
        
        $(function(){
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn=1",
                type:"GET",
                success:function(result){
                    //console.log(result);
                    //1、解析并显示员工数据
                    build_emps_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、解析并显示分页条信息
                    bulid_page_nav(result);
                }
            });
        });
        
        /*
        $(function(){
            to_page(1);
        });
        */
        function to_page(pn){
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn=" + pn,
                type:"GET",
                success:function(result){
                    //console.log(result);
                    //1、解析并显示员工数据
                    build_emps_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、解析并显示分页条信息
                    bulid_page_nav(result);
                }
            });
        }
        
        function build_emps_table(result){
            //清空table表格
            $("#emps_table tbody").empty();
            
            var emps = result.extend.pageInfo.list;
            $.each(emps, function(index, item){
            	var checkBoxId = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
                var emailTd = $("<td></td>").append(item.email);
                //保存的内容没有deptName，导致department.deptName空指针异常退出，无法显示新的内容
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                
                /*
                  <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                  </button>
                */
                
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                                .append("编辑");
                //为编辑按钮自定义属性，保存当前员工id
                editBtn.attr("edit_id", item.empId);
                
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                                .append("删除");
                delBtn.attr("del_id", item.empId);
                
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                
                $("<tr></tr>").append(checkBoxId)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }
        
        //解析并显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            
            $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum
                    + "页，总共" + result.extend.pageInfo.pages
                    + "页，总共" + result.extend.pageInfo.total
                    + "条记录");
            totalRecord = result.extend.pageInfo.total;
            currentPageNum = result.extend.pageInfo.pageNum;
        }
        
        //解析显示分页条，点击分页功能
        function bulid_page_nav(result){
            //page_nav_area
            $("#page_nav_area").empty();
            
            var ul = $("<ul></ul>").addClass("pagination");
            
            //添加元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var previousPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            
            
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                previousPageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                previousPageLi.click(function(){
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }
            
            //添加元素
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
            
            
            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                nextPageLi.click(function(){
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.pageInfo.pages);
                });
            }
            
            ul.append(firstPageLi).append(previousPageLi);
            
            $.each(result.extend.pageInfo.navigatepageNums, function(index, item){
                
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });
            
            ul.append(nextPageLi).append(lastPageLi);
            
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
        
        //清空数据和样式
        function reset_form(ele){
        	$(ele)[0].reset();
        	//清空表达样式
        	$(ele).find("*").removeClass("has-error has-success");
        	$(ele).find(".help-block").text("");
        }
        
        
        //点击新增按钮弹出模态框
        $("#emp_add_model_btn").click(function(){
        	//清除表单数据，表单重置，jQuery没有reset方法，dom里面有
        	//清空数据和样式
        	reset_form("#empAddModal form");
        	//$("#empAddModal form")[0].reset();
            //发出ajax请求，查出部门信息，显示下拉列表
            getDepts("#empAddModal select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });
        
        //查出部门信息，显示下拉列表
        function getDepts(ele){
        	//清空下拉列表的值，修复bug2
        	$(ele).empty();
        	
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function(result){
                    //结果：{"code":100,"msg":"处理成功！",
                    //  "extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"研究部"},{"deptId":3,"deptName":"测试部"}]}}
                    //console.log(result)
                    
                    //在下拉列表显示信息
                    //$("#empAddModal select").append("");
                    $.each(result.extend.depts, function(){
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }
        
        //校验表单数据
        function validate_add_form(){
            //1、拿到要验证的数据：姓名、邮箱，用正则表达式
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            
            //2、校验用户名
            if(!regName.test(empName)){
                //alert("用户名格式不正确，允许3-16位英文或2-5位中文包括符号“-”、“_”");
                show_validate_msg("#empName_add_input", "error", "用户名格式不正确，允许3-16位英文或2-5位中文包括符号“-”、“_”");
                return false;
            }else{
            	show_validate_msg("#empName_add_input", "success", "");
            }
            
            //3、校验邮箱email_add_input
            var email = $("#email_add_input").val();
            var regEmail = /^([A-Za-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确");
                show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
                return false;
            }else{
            	show_validate_msg("#email_add_input", "success", "");
            }
            return true;
        }
        
        function show_validate_msg(ele, status, msg){
        	//清除当前元素的校验状态
        	$(ele).parent().removeClass("has-success has-error");
        	$(ele).next("span").text("1");
        	if("success" == status){
        		$(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
        	}else if("error" == status){
        		$(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
        	}
        }
        
        //emp_cancel_btn 取消按钮的点击事件，点击以后清除上次获取的部门信息，修复bug2
        //在部门查询前清除内容比单独设立一个取消按钮的事件效率高
        /*
        $("#emp_cancel_btn").click(function(){
        	$("#add_emp_select").empty();
        	$("#empAddModal").modal("hide");
        	$("#empUpdateModal select").empty();
            $("#empUpdateModal").modal("hide");
        });
        */
        
        //给输入框绑定change事件
        $("#empName_add_input").change(function(){
        	//发送ajax请求，校验用户名是否可用，重复则提示警告信息
        	var empName = this.value;
        	$.ajax({
        		url:"${APP_PATH}/checkuser",
        		data:"empName="+empName,
        		type:"POST",
        		success:function(result){
        			if(result.code == 100){
        				show_validate_msg("#empName_add_input", "success", "用户名可用");
        				$("#emp_save_btn").attr("ajax-status", "success");
        			}else{
        				show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
        				$("#emp_save_btn").attr("ajax-status", "error");
        			}
        		}
        	});
        });
        
        
        $("#emp_save_btn").click(function(){
            
            //模态框中填写的表单数据提交给服务器
            //1、对要提交给服务器的数据进行校验
            
            if(!validate_add_form()){
                return false;
            };
            
            //2、判断ajax用户名校验是否成功，如果成功才继续
            if($(this).attr("ajax-status") == "error"){
            	return false;
            }
            
            //3、发送ajax请求保存员工
            //alert($("#empAddModal form").serialize());
            
            
            $.ajax({
                url:"${APP_PATH}/emps",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function(result){
                    //alert(result.msg);
                    
                    if(result.code == 100){
                    	//1、保存成功后，关闭模态框
                        $("#empAddModal").modal("hide");
                        //2、来到最后一页，显示刚才保存的数据
                        to_page(totalRecord);
                    }else{
                    	//显示失败信息
                    	//console.log(result);
                    	//有哪个字段有错误信息，就显示哪个
                    	if(undefined != result.extend.errorFields.email){
                    		//显示邮箱的错误信息
                    		
                    		show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    	}
                    	if(undefined != result.extend.errorFields.empName){
                    		//显示用户名的错误信息
                    		show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    	}
                    }
                    
                    
                }
            });
            
        });
        
        //为编辑按钮绑定点击事件
        //1、可以在创建按钮的时候绑定事件
        //2、绑定点击，JQuery的.live()，新版本中用on()替代
        //3、考虑是重新查询内容，还是使用显示出来的内容
        $(document).on("click", ".edit_btn", function(){
        	//alert("edit");
        	//1、查出部门信息，显示部门列表
        	getDepts("#empUpdateModal select");
        	//2、查出员工信息并显示
        	getEmp($(this).attr("edit_id"));
        	//3、把员工ID传到更新按钮中
        	$("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
        	//4、弹出模态框
        	$("#empUpdateModal").modal({
                backdrop:"static"
            });
        	
        });
        
      //为删除按钮绑定点击事件
        //1、可以在创建按钮的时候绑定事件
        //2、绑定点击，JQuery的.live()，新版本中用on()替代
        //3、
        $(document).on("click", ".delete_btn", function(){
            //确认删除对话框
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del_id");
            
            if(confirm("确认删除【" +empName+ "】吗？")){
            	//确认，发送ajax请求
            	$.ajax({
            		url:"${APP_PATH}/emp/"+empId,
            		type:"DELETE",
            		success:function(result){
            			alert(result.msg);
            			to_page(currentPageNum);
            		}
            	});
            }
            
        });
        
        
        function getEmp(id){
        	$.ajax({
        		url:"${APP_PATH}/emp/"+id,
        		type:"GET",
        		success:function(result){
        			//console.log(result);
        			var empData = result.extend.emp;
        			$("#empName_update_static").text(empData.empName);
        			$("#email_update_input").val(empData.email);
        			$("#empUpdateModal input[name=gender]").val([empData.gender]);
        			$("#empUpdateModal select").val(empData.deptId);
        		}
        	});
        }
        
        //点击更新，更新员工信息
        $("#emp_update_btn").click(function(){
        	//1、验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([A-Za-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                //alert(email+"邮箱格式不正确");
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_update_input", "success", "");
            }
            
            //发送ajax请求，保存修改后的数据
            $.ajax({
            	url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            	type:"POST",
            	data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            	success:function(result){
            		//alert(result.msg);
            		//1、关闭模态框
            		$("#empUpdateModal").modal("hide");
            		//2、回到本页面
            		to_page(currentPageNum);
            	}
            });
        });
        
        //完成删除模块的全选、全不选功能
        $("#check_all").click(function(){
        	//attr获取checked是undefined
        	//使用prop获取原生dom属性的值
        	$(".check_item").prop("checked",$(this).prop("checked"));
        });
        
        //用on方式给每一个item绑定删除事件
        $(document).on("click", ".check_item", function(){
            //判断当前选中的元素是不是五个
        	var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked", flag);
        	
        });
        
        //点击全部删除，进行批量删除
        $("#emp_delete_all_btn").click(function(){
        	var empNames = "";
        	var del_id_str = "";
        	$.each($(".check_item:checked"), function(){
        		empNames += $(this).parents("tr").find("td:eq(2)").text();
        		empNames += "、";
        		//组装员工ID字符串
        		del_id_str += $(this).parents("tr").find("td:eq(1)").text();
        		del_id_str += "-";
        	});
        	empNames = empNames.substring(0, empNames.length-1);
        	del_id_str = del_id_str.substring(0, del_id_str.length-1);
        	
        	if(confirm("确认删除【" +empNames+ "】吗？")){
                //确认，发送ajax请求
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_id_str,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        to_page(currentPageNum);
                    }
                });
            }
        	
        });
        
        
    </script>
    
    <!-- 
        bug：
        1、保存信息的时候不能保存部门ID
            原因：
                    保存的内容没有deptName，导致department.deptName空指针异常退出，无法显示新的内容
                    实则是因为提交的时候部门select标签内的name=dept_id，和数据库列名相同
            解决：
           select标签内的name属性应该和javabean中的属性名相同，name=deptId，问题解决。  
        
        2、不刷新的情况下，多次点新增，部门内容反复添加
            原因：
                点击添加后再关闭对话框，再次点击添加，部门内容出现两遍，因为没有清除上次的记录
            解决：
                给取消按钮增加点击事件，给select标签添加id，在通过id调用empty方法，并把模态框隐藏
        
        3、提交一次内容，保存两份纪录  
                 不再出现  
        
        !!4、添加以后查询出来的内容不是按照ID排序
        
        5、保存完数据不显示
     -->
</body>
</html>