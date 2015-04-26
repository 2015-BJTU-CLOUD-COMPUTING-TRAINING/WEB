<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="/cloud/css/bootstrap.min.css" rel="stylesheet">
    <link href="/cloud/css/bootstrapValidator.css" rel="stylesheet">



    <script type="text/javascript" src="/cloud/js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/cloud/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/cloud/js/bootstrapValidator.js"></script>
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
        <a class="navbar-brand" href="index.html" style="margin-left: 200px">一保七网盘</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <!-- form: -->
        <section>
            <div class="col-lg-8 col-lg-offset-2">
                <div class="page-header">
                    <h2>注 册</h2>
                </div>

                <form id="defaultForm" method="post" class="form-horizontal" action="regists">
              

                    <div class="form-group">
                        <label class="col-lg-3 control-label">用户名</label>
                        <div class="col-lg-5">
                            <input  type="text" class="form-control"  name="userName"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">电子邮件地址</label>
                        <div class="col-lg-5">
                            <input type="text" class="form-control" name="bjtuEmail" placeholder="电子邮件地址"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">密码</label>
                        <div class="col-lg-5">
                            <input type="password" class="form-control" name="password" placeholder="密码"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">确认密码</label>
                        <div class="col-lg-5">
                            <input type="password" class="form-control" name="confirmPassword" placeholder="确认密码" />
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="col-lg-3 control-label">学号</label>
                        <div class="col-lg-5">
                            <input type="text" class="form-control" name="bjtuNumber" placeholder="学号"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">电话号码</label>
                        <div class="col-lg-5">
                            <input type="tel" class="form-control" pattern="^\d{11}" name="phone" placeholder="电话号码"/>
                        </div>
                    </div>


					 <div class="form-group">
                        <label class="col-lg-3 control-label">生日</label>
                        <div class="col-lg-5">
                            <input type="date" class="form-control" name="birthday" placeholder="生日" /> (YYYY/MM/DD)
                        </div>
                    </div>
                  


                 <div class="form-group">
                        <label class="col-lg-3 control-label" id="captchaOperation"></label>
                        <div class="col-lg-2">
                            <input type="text" class="form-control" name="captcha" placeholder="验证码"/>
                        </div>
                    </div> 

                    <div class="form-group">
                        <div class="col-lg-9 col-lg-offset-3">
                            <button type="submit" class="btn btn-primary" name="signup" value="Sign up">注册</button>
                            <button type="button" class="btn btn-info" id="validateBtn">手动验证</button>
                            <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <!-- :form -->
    </div>
</div>
  
<script type="text/javascript">
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
               
                userName: {
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
                        } /* ,
                        
                        different: {
                            field: 'password',
                            message: 'The username and password cannot be the same as each other'
                        }  */
                    }
                },
                phone:{
                    validators:{
                        notEmpty: {
                            message: 'The email is required and cannot be empty'
                        }
                    }
                },
                bjtuEmail: {
                    validators: {
                        emailAddress: {
                            message: 'The input is not a valid email address'
                        },
                        notEmpty: {
                            message: 'The email is required and cannot be empty'
                        }
                    }
                },
       /*          password: {
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
                bjtuNumber:{
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
                } ,

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
                } */
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

</body>
</html>
