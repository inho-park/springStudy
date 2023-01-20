<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<html lang="en">

<%@include file="../includes/header.jsp" %>

<body class="bg-gradient-primary">

    <div class="container">

        	<div class="bigPictureWrapper">
				<div class="bigPicture">
				
				</div>
			</div>	
			
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
                				<sec:authentication property="principal" var="pinfo"/>
	                				<sec:authorize access="isAuthenticated()">
		                				<c:if test="${pinfo.username eq board.writer }">
			                				<button data-oper="modify" class="btn btn-default"
			                				style="border: 1px solid #dddddd">
			                					Modify
			                				</button>		
		                				</c:if>
	                				</sec:authorize>
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
                
                
                <div class="row" style="margin-top: 30px">
                	<div class="panel panel-heading">Files</div>
							<div class="panel-body">
								<div class="uploadResult">
										<ul>
										</ul>
								</div>
									
							</div>
                </div>
                
                <!-- 占쏙옙占� 占쌜쇽옙占쏙옙 占실놂옙 占쏙옙占쏙옙占� -->
                <div class="row" style="margin-top: 30px">
                	<div class="col-lg-12">
                		<!-- /.panel -->
                		<div class="panel panel-default">
                			<div class="panel-heading">
                				<i class="fa fa-comments fa-fw"></i> Reply
                				<sec:authorize access="isAuthenticated()">
                				<button id="addReplyBtn" class="btn btn-primary" style="float: right;">
                					New Reply
                				</button>
                				</sec:authorize>
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
	                					<p>사용자빵빵</p>
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
		
		// 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쌍댐옙 占쌉쇽옙 displayTime 占쏙옙 占싱울옙占쏙옙 replyDate 占쏙옙占쏙옙
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
				
				showReplyPage(replyCnt);
			
			}); //end getList
		} //end showList

		
		
//=========================================================================================
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		
		var replyer = null;
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		// ajax spring security header
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		// 占쏙옙짜 占쏙옙占쏙옙占� 占쏙옙 占쌥깍옙 占쏙옙튼 占쏙옙占쏙옙占� => 占쏙옙占� 占쌜쇽옙占쏙옙 占쏙옙 占쏙옙占�
		$("#addReplyBtn").on("click", function(e) {
			
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide(); // div 채占쏙옙 占쏙옙占쏙옙
			modal.find("button[id!='modalCloseBtn']").hide(); // 
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
			
		});
		
		// 占쏙옙占쏙옙占� 클占쏙옙占쏙옙 占쏙옙 활占쏙옙화 => 占쏙옙占� 占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙 占쏙옙�울옙 占쏙옙占�
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			console.log(rno);
			
			replyService.get(rno, function(reply){
				// 占쏙옙占쏙옙占� 占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙占싹깍옙 占쏙옙占쌔쇽옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌔댐옙 占쏙옙占쏙옙占� 占쏙옙회占쌔억옙占쏙옙 => modal 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쌩곤옙
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
		// 占쏙옙占� CUD 占쏙옙占쏙옙占� 占싹놂옙占쏙옙 Modal 占쏙옙 占쏙옙占쏙옙占쏙옙 modal 占쏙옙撚占쏙옙占� 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쌍댐옙 占쏙옙占쏙옙占쏙옙占� 占쏙옙占�
		
		// 占쏙옙占� 占쌩곤옙 占쏙옙占�
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
				// page 占쏙옙호占쏙옙 -1 占쏙옙 占쏙옙占쌨되몌옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 찾占싣쇽옙 占쌕쏙옙 호占쏙옙
				showList(-1);
			});
			
		});
		
		// 占쏙옙占� 占쏙옙占쏙옙 占쏙옙占�
		modalModBtn.on("click",function(e) {
			
			// data-rno 占쌈쇽옙 占쏙옙占�
			var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val(),
					replyer : originalReplyer
			};
			
			if(!replyer) {
				alert("로그인 후 수정 가능");
				modal.modal("hide");
				return;
			}
			
			console.log("Original Replyer : " + originalReplyer);
			
			if(replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 수정 가능");
				modal.modal("hide");
				return;
			}
			
			replyService.update(reply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		// 占쏙옙占� 占쏙옙占쏙옙 占쏙옙占�
		modalRemoveBtn.on("click", function(e){
			
			// data-rno 占쌈쇽옙 占쏙옙占�
			var rno = modal.data("rno");
			console.log("RNO : " + rno);
			console.log("REPLYER : " + replyer);
			
			if(!replyer) {
				alert("로그인 후 삭제가 가능합니다");
				modal.modal("hide");
				return
			}
			
			var originalReplyer = modalInputReplyer.val();
			console.log("Original Replyer : " + originalReplyer); // 댓글의 원래 작성자
			
			if(replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 삭제 가능");
				modal.modal("hide");
				return;
			}
			
			replyService.remove(rno, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		
		
		
		
//=========================================================================================
		
	// 占쏙옙占� 占쏙옙占쏙옙占쏙옙占쏙옙호처占쏙옙 占쏙옙占쏙옙
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
				str+= "<li class='page-item " + active + "'><a class='page-link' href='"
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
			
			replyPageFooter.html(str);
		}
		
		
		
		
		// 占쏙옙占쏙옙占쏙옙 占쏙옙호占쏙옙 클占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙占싸울옙 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 처占쏙옙
		replyPageFooter.on("click","li a", function(e){
			
			// 占쏘떤 占싱븝옙트占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 처占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占�, 占쌔댐옙 占싱븝옙트占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占썩본 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占십듸옙占쏙옙 占쏙옙占쏙옙
			e.preventDefault();
			
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum = " + targetPageNum);
			
			pageNum = targetPageNum;
			showList(pageNum);
		});
	});
	
</script>

<!-- 占쌓쏙옙트占쏙옙 占쌘바쏙옙크占쏙옙트 -->
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
		// result(reply.js 占쏙옙占쏙옙 占싼억옙占�) 占쏙옙 alert 占쏙옙 占쏙옙占쏙옙
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

	
	
	
// rno 占쏙옙 占쌔댐옙占싹댐옙 占쏙옙占� 占쏙옙占쏙옙占싹깍옙
	replyService.remove(44, function(result) {
		
		console.log(result);
		
		if(result === "success"){
			alert("REMOVED");
		}
	},function(error) {
		alert("ERROR...");
		
	}); 
		
		
		

// RequestBody占쏙옙 JSON占쏙옙 ReplyVO占쏙옙 占쏙옙환占싹울옙 rno 占쏙옙 占쏙옙占쏙옙占쏙옙 update 占싹댐옙 占쏙옙占쏙옙
	replyService.update({
		rno : 22,
		bno : bnoValue,
		reply : "Modified Reply..."
	}, function(result) {
		alert("MODIFIED");
	});
	
	
	
	
// 특占쏙옙 占쏙옙호占쏙옙 占쏙옙占� 占쏙옙회占쏙옙 占쏙옙占쏙옙 get 占쏙옙占� 占쌩곤옙
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

		(function() {
			
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
				console.log("arr : "+arr);
				
				var str = "";
				
				$(arr).each(function(i,attach){
					
					//image type
					if(attach.fileType){
						
						var fileCallPath = encodeURIComponent(
								attach.uploadPath + "/s_" 
								+ attach.uuid + "_" 
								+ attach.fileName);
						
						console.log("file Path [" + i + "] : " + fileCallPath);
						
						str += "<li data-path='" + attach.uploadPath 
							+ "' data-uuid='" + attach.uuid 
							+ "' data-filename='" + attach.fileName 
							+ "' data-type='" + attach.fileType + "' >";
							
						str += "<div>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str += "</li>";
							
					}
					else {
						str += "<li data-path='" + attach.uploadPath 
						+ "' data-uuid='" + attach.uuid 
						+ "' data-filename='" + attach.fileName 
						+ "' data-type='" + attach.fileType + "' ><div>";
						
						str += "<span>" + attach.fileName + "</span><br>";
						str += "<img src='${path}/resources/img/attach.png'>";
						str += "</div>";
						str += "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);	
			});
			
		})();
		
	});
	
	$(".uploadResult").on("click", "li", function(e) {
		console.log("view image");
		
		var liObj = $(this);
		
		console.log(liObj);
		console.log(liObj.data("filename"));
		
		var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
		
		if(liObj.data("type")) {
			showImage(path.replace(new RegExp(/\\/g), "/"));
		}else {
			self.location = "${path}/download?fileName=" + path;
		}
	});
	
	function showImage(fileCallPath) {
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='${path}/display?fileName=" + fileCallPath + "'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
	$(".bigPictureWrapper").on("click", function(e) {
		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
		setTimeout(function() {
			$(".bigPictureWrapper").hide();
		}, 1000);
	});
	
</script>