$(document).ready(function () {
  $("#category-filter-form").submit(function (event) {
    event.preventDefault();
    var categoryId = $("#category_id").val();
    $.ajax({
      url: "/pages/index",
      method: "get",
      data: { category_id: categoryId },
      success: function (response) {
        $("#products-list").html(response);
      },
      error: function (xhr, status, error) {
        console.error(error);
      },
    });
  });
});
