/* global $ */
/* global location */

$(function() {
  $('tr').click(function() {
    
    // ヘッダー選択時は何もしない
    if (this.dataset.id == null) {
      return;
    }
    
    location.href = '/routines/' + this.dataset.id;
  });
});