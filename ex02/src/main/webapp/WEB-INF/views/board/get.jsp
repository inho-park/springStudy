<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html lang="en">

<%@include file="../includes/header.jsp" %>

<body class="bg-gradient-primary">

    <div class="container">

        
                <div class="row">
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Board Read</h1>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-lg-7 -->
                
                	<div class="col-lg-12">
                		<div class="panel panel-default">
                			<div class="h5 panel-heading">
	                			Board Read Page
                			</div>
                			
                			<div class="panel-body">
                				<div class="form-group">
                					<label>Bno</label>
                					<input class="form-control" name="bno"
                					value='<c:out value="${board.bno }"/>' readonly="readonly">   
                				</div>
                				
                				<div class="form-group">
                					<label>Title</label>
                					<input class="form-control" name="title"
                					value='<c:out value="${board.title }"/>' readonly="readonly">   
                				</div>
                				
                				<div class="form-group">
                					<label>Text Area</label>
                					<textarea class="form-control" name="content" rows="4" 
                					readonly="readonly"><c:out value="${board.content }"/>
                					</textarea>
                				</div>
                				
                				<div class="form-group">
                					<label>Writer</label>
                					<input class="form-control" name="writer"
                					value='<c:out value="${board.writer }"/>' readonly="readonly">   
                				</div>
                				<button data-oper="modify" class="btn btn-default"
                				onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'"
                				style="border: 1px solid #dddddd">
                					Modify
                				</button>
                				<button data-oper="list" class="btn btn-info"
                				onclick="location.href='/board/list'">
                					List
                				</button>
                			</div>
                			<!-- /.panel body -->
                		</div>
                		<!-- /.panel panel-default -->
                	</div>
                	<!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                
                
                
    </div>

<%@include file="../includes/footer.jsp" %>