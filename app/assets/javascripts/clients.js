$(".table").load(function() {
  let id = $(this).data("id");
  $.get("/clients/" + id + ".json", function(data) {
    $("#app_date").html(data["date_time"]);
    $("#app_artist").html(data["client"]["name"]);
    $("#app_details").html(data["comments"]);
  });
});

getFullDateTime(date){
	let formatted_date = (date.getMonth() +1) + "-" + date.getDate() + "-" + date.getFullYear();
	return formatted_date;
};