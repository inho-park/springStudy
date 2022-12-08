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
                				style="border: 1px solid #dddddd">
                					Modify
                				</button>
                				<button data-oper="list" class="btn btn-info">
                					List
                				</button>
                				<form id='operForm' action="/board/modify" method="get">
                					<input type='hidden' id='bno' name='bno' 
                					value='<c:out value="${board.bno }"/>'>
                					<input type="hidden" name="pageNum" 
                					value='<c:out value="${cri.pageNum }"/>'>
                					<input type="hidden" name="amount"
                					value='<c:out value="${cri.amount }"/>'>
                					<input type="hidden" name="keyword"
                					value='<c:out value="${cri.keyword }"/>'>
                					<input type="hidden" name="type"
                					value='<c:out value="${cri.type }"/>'>
                				</form>
                			</div>
                			<!-- /.panel body -->
                		</div>
                		<!-- /.panel panel-default -->
                	</div>
                	<!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                
                <!-- 댓글 작성용 판넬 만들기 -->
                <div class="row" style="margin-top: 30px">
                	<div class="col-lg-12">
                		<!-- /.panel -->
                		<div class="panel panel-default">
                			<div class="panel-heading">
                				<i class="fa fa-comments fa-fw"></i> Reply
                			</div>
                			
                			<!-- /.panel-heading -->
                			<div class="panel-body">
                				<ul class="chat">
                					<!-- start reply -->
                					<li class="left clearfix" data-rno = '12' >
                					<div>
	                					<div class="header">
	                						<strong class="primary-font">
	                							user00
	                						</strong>
	                						<small class="pull-right text-muted">
	                							2022-12-09
	                						</small>
	                					</div>
	                					<p>Good 잡</p>
                					</div>
                				</ul>
                			</div>
                		</div>
                	</div>
                </div>
                
    </div>

<%@include file="../includes/footer.jsp" %>

<!-- reply ajax -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page) {
			
			replyService.getList({bno : bnoValue, page : page||1 }, function(list){
				
				var str = "";
				
				if (list == null || list.length == 0) {
					replyUL.html("");
					return;
				}
				
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "  <div>";
					str += "	<div class='header'>";
					str += "	  <strong class='primary-font'>" + list[i].replyer + "</strong>";
					str += "	  <small class='pull-right text-muted'>" + list[i].replyDate + "</small>"
					str += "	</div>"	
					str += "  <p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
			
			}); //end function
		} //end showList
	});
</script>

<!-- json 에 정보 더 담기 -->
<script type="text/javascript">
	
	console.log("====================================");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	// for replyService add test
	replyService.add(
		{
			reply : "JS Test",
			replyer : "tester",
			bno : bnoValue
		},
		// result(reply.js 에서 넘어온) 를 alert 로 띄우기
		function(result) {
			alert("RESULT : " + result);
		}
	);

	
	
	
// for replyService get list of reply
	replyService.getList({bno:bnoValue, page:1}, function(list){
		
		for (var i = 0, len = list.length || 0; i < len; i++){
			console.log(list[i]);
		}
	})

	
	
	
// rno 에 해당하는 댓글 삭제하기
	replyService.remove(44, function(result) {
		
		console.log(result);
		
		if(result === "success"){
			alert("REMOVED");
		}
	},function(error) {
		alert("ERROR...");
		
	}); 
		
		
		

// RequestBody로 JSON을 ReplyVO로 변환하여 rno 를 가져와 update 하는 구조
	replyService.update({
		rno : 22,
		bno : bnoValue,
		reply : "Modified Reply..."
	}, function(result) {
		alert("MODIFIED");
	});
	
	
	
	
// 특정 번호의 댓글 조회를 위한 get 방식 추가
	replyService.get(10, function(data){
		console.log(data);
	});
</script>


<script type="text/javascript">
	$(document).ready(function() {		
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").click(function(e){
			
			operForm.attr("action","/board/modify").submit();
			
		});
		
		$("button[data-oper='list']").click(function(e){
			
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list");
			operForm.submit();
		});
	});
</script>