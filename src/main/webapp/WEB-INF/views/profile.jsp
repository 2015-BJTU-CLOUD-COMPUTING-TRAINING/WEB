<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrapValidator.css" rel="stylesheet">



    <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrapValidator.js"></script>
    <style>
        body{
            margin-top: 50px;
        }

    </style>
</head>
<body>

<!--顶部导航栏-->
<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header" id="navbarHeader">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index" style="margin-left: 200px">一保七网盘</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <!-- form: -->
        <section>
            <div class="col-lg-8 col-lg-offset-2">
                <div class="page-header">
                    <h2>个人资料</h2>
                </div>

                <form id="defaultForm" method="post" class="form-horizontal" action="profile">
                <input type="hidden" name="userid" value="${sessionScope.currentUser.userId}">
                    <div class="form-group">
                        <label class="col-lg-3 control-label">昵称</label>

                        <div class="col-lg-5">
                            <input type="text" class="form-control" name="userNickname"  value="${sessionScope.currentUser.userNickname}" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">用户名</label>
                        <div class="col-lg-5">
                            <input type="text" class="form-control" name="userName" value="${sessionScope.currentUser.userName}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">电子邮件地址</label>
                        <div class="col-lg-5">
                            <input type="text" class="form-control" name="bjtuEmail" value="${sessionScope.currentUser.bjtuEmail}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">密码</label>
                        <div class="col-lg-5">
                            <input type="password" class="form-control" name="password" value="${sessionScope.currentUser.password}" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">确认密码</label>
                        <div class="col-lg-5">
                            <input type="password" class="form-control" name="confirmPassword"  value="${sessionScope.currentUser.password}" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">学号</label>
                        <div class="col-lg-5">
                            <input type="text" class="form-control" name="bjtuNumber" value="${sessionScope.currentUser.bjtuNumber}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">电话号码</label>
                        <div class="col-lg-5">
                            <input type="tel" class="form-control" pattern="^\d{11}" name="phone" value="${sessionScope.currentUser.phone}"/>
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="col-lg-3 control-label">生日</label>
                        <div class="col-lg-5">
                            <input type="date"  class="form-control" name="birthday" value="<fmt:formatDate value="${sessionScope.currentUser.birthday}" pattern="yyyy-MM-dd"/>" />
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-lg-9 col-lg-offset-3">
                            <button type="submit" class="btn btn-primary" name="signup" value="Sign up">确定修改</button>
                            <button type="button" class="btn btn-info" id="validateBtn">手动验证</button>
                            <button type="button" class="btn btn-info" id="resetBtn">取消修改</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <!-- :form -->
    </div>
</div>

<!-- <script type="text/javascript">
    $(document).ready(function() {
        // Generate a simple captcha
        function randomNumber(min, max) {
            return Math.floor(Math.random() * (max - min + 1) + min);
        };
        $('#captchaOperation').html([randomNumber(1, 100), '+', randomNumber(1, 200), '='].join(' '));

        $('#defaultForm').bootstrapValidator({
//        live: 'disabled',
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {

                Name: {
                    validators: {
                        notEmpty: {
                            message: 'The last name is required and cannot be empty'
                        }
                    }
                },
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The username is required and cannot be empty'
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: 'The username must be more than 6 and less than 30 characters long'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: 'The username can only consist of alphabetical, number, dot and underscore'
                        },

                        different: {
                            field: 'password',
                            message: 'The username and password cannot be the same as each other'
                        }
                    }
                },
                Telphone:{
                    validators:{
                        notEmpty: {
                            message: 'The email is required and cannot be empty'
                        }
                    }
                },
                email: {
                    validators: {
                        emailAddress: {
                            message: 'The input is not a valid email address'
                        },
                        notEmpty: {
                            message: 'The email is required and cannot be empty'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: 'The password is required and cannot be empty'
                        },
                        identical: {
                            field: 'confirmPassword',
                            message: 'The password and its confirm are not the same'
                        },
                        different: {
                            field: 'username',
                            message: 'The password cannot be the same as username'
                        }
                    }
                },
                confirmPassword: {
                    validators: {
                        notEmpty: {
                            message: 'The confirm password is required and cannot be empty'
                        },
                        identical: {
                            field: 'password',
                            message: 'The password and its confirm are not the same'
                        },
                        different: {
                            field: 'username',
                            message: 'The password cannot be the same as username'
                        }
                    }
                },
                studentNumber:{
                    validators:{
                        between:{
                            min:10000000,
                            max:99999999,
                            message:'请输入正确的学号'
                        },
                        notEmpty: {
                            message: 'The confirm password is required and cannot be empty'
                        }

                    }
                },
                birthday: {
                    validators: {
                        notEmpty: {
                            message: 'The birthday is not valid'
                        }
                    }
                },

                captcha: {
                    validators: {
                        callback: {
                            message: 'Wrong answer',
                            callback: function(value, validator) {
                                var items = $('#captchaOperation').html().split(' '), sum = parseInt(items[0]) + parseInt(items[2]);
                                return value == sum;
                            }
                        }
                    }
                }
            }
        });

        // Validate the form manually
        $('#validateBtn').click(function() {
            $('#defaultForm').bootstrapValidator('validate');
        });

        $('#resetBtn').click(function() {
            $('#defaultForm').data('bootstrapValidator').resetForm(true);
        });
    }); 
</script>
-->
</body>
</html>
