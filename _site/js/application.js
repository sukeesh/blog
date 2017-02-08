var instagram = {
  client_id: 'b65e71d3b4c94bc29ff2172a7669f0ad',

  max_width: 150,
  width: 0,
  count: 0,
  img_width: 0,

  data: {},

  init: function(){
    this.setDimensions();
    this.fetch();
  },

  setDimensions: function(){
    this.width = $(window).width();
    this.count = Math.ceil(this.width / this.max_width);
    this.img_width = this.width / this.count;

    if(this.count < 2){
      this.img_width = this.width / 3;
      this.count = 3;
    }
  },

  fetch: function(){
    var that = this;
    $.ajax({
      url: 'https://api.instagram.com/v1/users/190481304/media/recent',
      method: 'GET',
      data: {
        client_id: this.client_id,
        count: this.count
      },
      dataType: 'jsonp',
      success: function(d){
        that.data = d;
        that.display();
      }
    })
  },

  display: function(){
    var d = this.data;
    if(d.data.length < this.count){
      return;
    }

    this.clear();

    for(var i = 0; i < this.count; i++){
      var item = d.data[i];
      var url = item.images.thumbnail.url;
      url = url.split('://');
      url = '//' + url[1];
      $('.ig').append('<a href="'+item.link+'" target="_blank"><img src="'+url+'" width='+this.img_width+' /></a>');
    }
  },

  clear: function(){
    $('.ig').html('');
  },

  handleResize: function(){
    this.setDimensions();

    if(this.count <= this.data.data.length){
      this.display();
    }
    else if(this.count > this.data.data.length){
      this.fetch();
    }
  }
}

if(typeof $ !== 'undefined'){
  $(document).ready(function(){
    instagram.init();
    $(window).resize(function(){
      instagram.handleResize();
    });
  })
}
