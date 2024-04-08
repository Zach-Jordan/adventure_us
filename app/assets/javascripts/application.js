$(document).ready(function () {
  $("#category-filter-form").submit(function (event) {
    event.preventDefault(); // Prevent form submission
    var categoryId = $("#category_id").val();
    $.ajax({
      url: "/pages/index", // Endpoint to fetch filtered products
      method: "get",
      data: { category_id: categoryId },
      success: function (response) {
        $("#products-list").html(response); // Replace products list with filtered products
      },
      error: function (xhr, status, error) {
        console.error(error);
      },
    });
  });
});
