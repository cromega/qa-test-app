var onChangeCategoryDropdown = function() {
  var select = document.querySelectorAll("form #category_dropdown")[0];
  if (select) {
    var newCategoryContainer = document.querySelector("form #new_category");
    var newCategoryField = document.querySelector("form #new_category input");

    if (select.options[select.selectedIndex].text == "New Category") {
      newCategoryField.disabled = false;
      newCategoryContainer.style.display = "block";
    } else {
      newCategoryField.disabled = true;
      newCategoryContainer.style.display = "none";
    }
  }
}

