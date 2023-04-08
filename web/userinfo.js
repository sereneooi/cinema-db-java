//search function
function filter(){
    var FilterValue, input, ul, li, i;
    input = document.getElementById('search');
    FilterValue = input.value.toUpperCase();
    ul = document.getElementById('search-list');
    li = ul.getElementsByTagName('li');
    // if the input is empty hide the list
    if(FilterValue.trim().length < 1) {
        ul.style.display = "none";
        return false;
    } else {
        ul.style.display = "block";
    }
       for (i = 0; i < li.length; i++) {
        var a = li[i].getElementsByTagName('a')[0];
        if (a.innerHTML.toUpperCase().indexOf(FilterValue) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}
