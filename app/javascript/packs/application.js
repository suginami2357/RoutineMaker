// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
//require("channels")

// jquery導入 config/webpack/environment.jsにも記載が必要
require('jquery')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

/* global $ */

$(function(){
  
  //loadイベント
  Resize();
  
  //turbolinksが機能するとloadイベントが発火しないのでturbolinks:loadイベントで発火する。
  window.addEventListener('turbolinks:load', Resize);
  
  //画面リサイズイベント
  window.addEventListener('resize', Resize);
});

  // ヘッダーの高さ分だけコンテンツを下げる
  const Resize = () => {
    var height = $("header").height();
    $(".body-content").css("margin-top", height + 10);//10pxだけ余裕をもたせる
  }