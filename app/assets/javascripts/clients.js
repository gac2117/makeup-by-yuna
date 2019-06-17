$(function () {
  $(".table").on('load', function() {
    let id = $(this).data("id");
    $.get("/clients/" + id + ".json", function(data) {
      // Replace text of body-id div
      $("#app_date").html(getFullDateTime())
      $("#app_artist").html(data[])
      $("#body-" + id).html(data["description"]);
    });
  });
});

getFullDateTime(date) {
	let formatted_date = (date.getMonth() +1) + "-" + date.getDate() + "-" + date.getFullYear();
	return formatted_date;
}