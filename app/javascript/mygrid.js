// id picker
//new response
//assessment grid
document.querySelectorAll('tr.assessment-tr-mygrid').forEach(function(el){
    el.addEventListener('click', function() {
        for (let row of this.closest('tr').parentNode.rows) 
          {
            row.classList.remove("tr-clicked");
          }
        this.closest('tr').classList.remove("tr-clicked");
        // add highlight to the parent tr of the clicked td
        this.closest('tr').classList.add("tr-clicked");
        if (document.getElementById("assessment_id") != null) { document.getElementById("assessment_id").value = this.closest('tr').cells[0].textContent; }
        if (document.getElementById("assessment_name") != null) { document.getElementById("assessment_name").value = this.closest('tr').cells[2].textContent; }
    });
  });
  //new user
  //user grid
  document.querySelectorAll('tr.user-tr-mygrid').forEach(function(el){
    el.addEventListener('click', function() {
        for (let row of this.closest('tr').parentNode.rows) 
        {
          row.classList.remove("tr-clicked");
        }
      this.closest('tr').classList.remove("tr-clicked");
      // add highlight to the parent tr of the clicked td
      this.closest('tr').classList.add("tr-clicked");
      if (document.getElementById("user_id") != null) { document.getElementById("user_id").value = this.closest('tr').cells[0].textContent; }
      if (document.getElementById("user_name") != null) { document.getElementById("user_name").value = this.closest('tr').cells[2].textContent; }
    });
  });