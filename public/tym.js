(function($){
	$.ajax({ url: '/api/i8n/lib', success: function(data){
		$('[data-text]').each(function(){
			$(this).text(data[$(this).data('text')]);
		});
	}});
})(jQuery)

