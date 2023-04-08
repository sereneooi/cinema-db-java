
function closeWin() {
    infor_modal.style.display = "none";
    document.getElementById('searchEmail').value = ''
    document.getElementById('paymentSearchInput').value = ''
}

function showTicketOrderSelection(){
    var show_model = document.getElementById('ticketOrderSelection');

    if(show_model.style.display === "none"){
        show_model.style.display = "block";
    }else{
        show_model.style.display = "none";
    }
}

function getValue(input){
    var checkedCheckbox = document.querySelectorAll("input[class='getValue']:checked")
    var values = "";

    //append values of each checkbox into a variable (seperated by commas)
    for(var i=0;i<checkedCheckbox.length;i++){
      values += checkedCheckbox[i].value + " + "  
    }

    //remove last comma
    values = values.slice(0,values.length-1)
    document.getElementById("displaySelectedValue").value = values;
}

