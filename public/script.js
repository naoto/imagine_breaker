new Vue({
  el: '#main',

  created: function(){
    var vm = this;
    
    superagent.get('/images', function(response){
      vm.images = response.body;
      vm.images.forEach(function(name){
        vm.imagesurl.push({url: name['url']});
      });
    });
  },
  methods: {
    search: function(){
      var vm = this;
      var keywords = this.searchImage.split(' ')
    },
    register: function(){
      var vm = this;

      superagent.post('/images')
                .send({url: this.url, tags: this.tags})
                .end(function(err, response){
        vm.images.push(response.body);
        vm.imagesurl.push({url: response.body['url']});
        this.url = '';
        this.tags = '';
      });
    }
  },
  data: {
    images: [],
    imagesurl: [],
    url: '',
    tags: '',
    searcchImage: ''
  }
});
