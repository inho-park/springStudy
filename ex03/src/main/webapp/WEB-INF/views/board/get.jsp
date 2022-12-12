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
                				<button id="addReplyBtn" class="btn btn-primary" style="float: right;">
                					New Reply
                				</button>
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
	                					<p>뭔가 문제가 있다..</p>
                					</div>
                				</ul>
                			</div>
                			<div class="panel-footer">
                			
                			</div>
                		</div>
                	</div>
                </div>
                
    </div>
    
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
    	aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
    		<div class="modal-content">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiiss="modal"
    					aria-hidden="true">
    					&times;
    				</button>
    				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
    			</div>
    			<div class="modal-body">
    				<div class="form-group">
    					<label>
    						Reply
    					</label>
    					<input class="form-control" name="reply" value="NEW REPLY">
    				</div>
    				<div class="form-group">
    					<label>
    						Replyer
    					</label>
    					<input class="form-control" name="replyer" value="NEW REPLYER">
    				</div>
    				<div class="form-group">
    					<label>
    						Reply Date
    					</label>
    					<input class="form-control" name="replyDate" value="NEW REPLYDATE">
    				</div>
    			</div>
    			<div class="modal-footer">
    				<button id="modalModBtn" type="button" class="btn btn-warning">
    					Modify
    				</button>
    				<button id="modalRemoveBtn" type="button" class="btn btn-danger">
    					Remove
    				</button>
    				<button id="modalRegisterBtn" type="button" class="btn btn-primary">
    					Register
    				</button>
    				<button id="modalCloseBtn" type="button" class="btn btn-default">
    					Close
    				</button>
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
		
		// 댓글을 보여주는 함수 displayTime 을 이용해 replyDate 수정
		function showList(page) {
			
			console.log("show List : " + page);
			
			replyService.getList({bno : bnoValue, page : page||1 }, 
					function(replyCnt,list){
				
				console.log("replyCnt : " + replyCnt);
				console.log("list : " + list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
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
					str += "	  <small class='pull-right text-muted'>" + 
							replyService.displayTime(list[i].replyDate) + "</small>"
					str += "	</div>"	
					str += "  <p>" + list[i].reply + "</p></div></li>";
					str += "<hr>"
				}
				
				replyUL.html(str);
			
			});
		} //end showList

		
		
//=========================================================================================
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		// 날짜 숨기기 및 닫기 버튼 숨기기 => 댓글 작성할 때 사용
		$("#addReplyBtn").on("click", function(e) {
			
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide(); // div 채로 숨김
			modal.find("button[id!='modalCloseBtn']").hide(); // 
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
			
		});
		
		// 댓글을 클릭할 때 활성화 => 댓글 수정 및 삭제 기능에 사용
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			console.log(rno);
			
			replyService.get(rno, function(reply){
				// 댓글을 수정 및 삭제하기 위해서는 어차피 해당 댓글을 조회해야함 => modal 에 가져오는 기능을 추가
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
					.attr("readonly","readonly");
				modal.data("rno",reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
			
		});
		
		
		
		
//=========================================================================================		
		// 댓글 CUD 기능을 하나의 Modal 을 가지고 modal 요소들을 숨기고 보여주는 방식으로 사용
		
		// 댓글 추가 기능
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno: bnoValue
			};
			replyService.add(reply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");

				// showList(1);
				// page 번호가 -1 로 전달되면 마지막 페이지를 찾아서 다시 호출
				showList(-1);
			});
			
		});
		
		// 댓글 수정 기능
		modalModBtn.on("click",function(e) {
			
			// data-rno 속성 사용
			var reply = {rno : modal.data("rno"),
						reply : modalInputReply.val()};
			
			
			replyService.update(reply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(1);
			})
		});
		
		// 댓글 삭제 기능
		modalRemoveBtn.on("click", function(e){
			
			// data-rno 속성 사용
			var rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		
		
		
		
//=========================================================================================
		
	// 댓글 페이지번호처리 로직
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt) {
			
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if (endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if (endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<ul class='pagination'>";
			
			if (prev) {
				str+= "<li class='page-item " + active + " '><a class='page-link' href='"
				+ (startNum - 1) + "'>Previous</a></li>";
			}
			
			for (var i = startNum; i <= endNum; i++) {
				
				var active = pageNum == i? "active":"";
				
				str += "<li class='page-item " + active + "'><a class='page-link' href='"
				+ i + "'>" + i + "</a></li>";
			}
			
			if (next) {
				str += "<li class='page-item'><a class='page-link' href='"
				+ (endNum + 1) + "'>Next</a></li>";
			}
			
			str += "</ul></div>"
			
			console.log(str);
			
			replyPageFooter.htmml(str);
		}
	});
	
</script>

<!-- 테스트용 자바스크립트 -->
<script type="text/javascript">
	
/* 	console.log("====================================");
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
	}); */
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