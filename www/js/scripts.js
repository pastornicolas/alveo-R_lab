 $(document).on('click', '#capture_screen', function() {
    html2canvas(document.body, {
      backgroundColor: null,
      useCORS: true,
      onclone: function(clonedDocument) {
          $(clonedDocument).find('.center-action-btn').each(function() {
              var id = this.id;
              var original = document.getElementById(id);
                if (original) {
                      var text = $(original).text().trim();
                      $(this).html('<i class=\"fa fa-expand\"></i> ' + text);
                      $(this).css({
                          'display': 'inline-flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'color': '#000',
                          'opacity': '1',
                          'visibility': 'visible'
                      });
                }
          });
      }
      }).then(function(canvas) {
          var link = document.createElement('a');
          link.download = 'Alveolata_TP8_grupos.png';
          link.href = canvas.toDataURL('image/png');
          link.click();
      });
   
 });
          
$(document).on('shiny:value', function(event) {
$('.morph-label').draggable({
  helper: 'original',
  zIndex: 99999
});
  
});