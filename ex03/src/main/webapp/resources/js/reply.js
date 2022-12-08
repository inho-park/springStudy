console.log("Reply Module");

var replyService = (function() {

	function add(reply, callback, error) {
		console.log("reply.js : add reply....");
		
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
	
	return {
		add : add
	};
})();

