console.log("Reply Module");

var replyService = (function() {
	
	// 댓글 작성 시 데이터베이스에 추가하기 위한 함수
	function add(reply, callback, error) {
		console.log("reply.js : add()..............");
		
		$.ajax({
			type : 'post',
			url : '/reply/new',
			data : JSON.stringify(reply),
			// contentType 이 json 형태
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr) {
				// callback 을 함수로 받음
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				// error 를 함수로 받음
				if (error) {
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error) {
		console.log("reply.js : getList()............");
		
		var bno = param.bno;
		
		var page = param.page || 1;
		
		$.getJSON("/reply/pages/" + bno + "/" + page + ".json",
			function(data){
				if (callback) {
					callback(data);
				}
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	return {
		add : add,
		getList : getList
	};
})();

