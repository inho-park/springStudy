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
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">도서 등록</h1>
                            </div>
                            <form class="user" role="form" action="/board/modify" 
                            method="post">
                               <div class="form-group">
			                		<label>Bno</label>
			                		<input class="form-control" name="bno" 
			                		value="<c:out value='${board.bno }'/>" readonly="readonly">
			                	</div>
			                	
			                	<div class="form-group">
			                		<label>Title</label>
			                		<input class="form-control" name="title" 
			                		value="<c:out value='${board.title }'/>">
			                	</div>
			                	
			                	<div class="form-group">
			                		<label>Text area</label>
			                		<textarea rows="3" class="form-control" name="content">
			                			<c:out value="${board.content }"/>
			                		</textarea>
			                	</div>
			                	
			                	<div class="form-group">
			                		<label>Writer</label>
			                		<input class="form-control" name="writer" 
			                		value="<c:out value='${board.writer }'/>">
			                	</div>
			                	
			                	<div class="form-group">
			                		<label>Register Date</label>
			                		<input class="form-control" name="regDate" 
			                		value="<fmt:formatDate pattern="yyyy/MM/dd" 
			                		value='${board.regdate }'/>" readonly="readonly">
			                	</div>
			                	
			                	<div class="form-group">
			                		<label>Update Date</label>
			                		<input class="form-control" name="updateDate" 
			                		value="<fmt:formatDate pattern="yyyy/MM/dd" 
			                		value="${board.updateDate }"/>" readonly="readonly">
			                	</div>
			                	
			                	<button type="submit" data-oper="modify" class="btn btn-primary">
			                		Modify
			                	</button>
			                	<button type="submit" data-oper="remove" class="btn btn-danger">
			                		Remove
			                	</button>
			                	<button type="submit" data-oper="list" class="btn btn-default"
			                	style="background-color: #dddddd">
			                		List
			                	</button>
                            </form>
                            <hr>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
<%@include file="../includes/footer.jsp" %>