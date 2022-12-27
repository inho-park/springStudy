<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html lang="en">

<%@include file="../includes/header.jsp" %>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">도서 등록</h1>
                            </div>
                            <form class="user" role="form" action="/board/register" 
                            method="post">
                                <!--	<div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="writer"
                                            placeholder="작가">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="exampleLastName"
                                            placeholder="Last Name">
                                    </div>
                                </div>  -->
                                <div class="form-group">
                                	<label>Title</label>
                                    <input type="text" class="form-control form-control-user"
                                    	 name="title"
                                        placeholder="책 제목">
                                </div>
                                <div class="form-group">
                                	<label>Writer</label>
                                    <input type="text" class="form-control form-control-user"
                                    	 name="writer"
                                        placeholder="작가 이름">
                                </div>
                                <div class="form-group">
                                	<label>Book Content</label>
                                	<textarea class="form-control" rows="3" name="content">
                                	</textarea>
                                </div>
                                <div class="form-group">
                                	<button type="submit" class="btn btn-default">
                                		SUBMIT 버튼
                                	</button>
                                	<button type="reset" class="btn btn-default">
                                		RESET 버튼
                                	</button>
                                </div>
                               <!--  </div>
                                <a href="login.html" class="btn btn-primary btn-user btn-block">
                                    Register Account
                                </a>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>  -->
                            </form>
                            <hr>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                	<div class="col-lg-12">
                		<div class="panel panel-default">
                			<div class="panel-hading">File Attach</div>
                			<div class="panel-body">
                				<div class="form-group uploadDiv">
                					<input type="file" name="uploadFile" multiple>
                				</div>
                				
                				<div class="uploadResult">
                					<ul>
                					
                					</ul>
                				</div>
                			</div>
                		</div>
                	</div>
                </div>
            </div>
        </div>
    </div>

<%@include file="../includes/footer.jsp" %>
