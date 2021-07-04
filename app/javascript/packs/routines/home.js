/* global $ */

//現在時刻をyy:MM:ssの形式で表示する
const Clock = () => {
  const date = new Date();
  const hh = ("0" + date.getHours()).slice(-2);
  const mm = ("0" + date.getMinutes()).slice(-2);
  const ss = ("0" + date.getSeconds()).slice(-2);
  document.getElementById('clock').innerText = hh + ":" + mm + ":" + ss;

  // let current_time = '' + mm + ss;
  // var elements = document.getElementsByClassName('end_time');
  // if (elements.filter(e => e.value > current_time).any() {
  
}
  
$().ready(Clock());
setInterval(Clock, 1000);