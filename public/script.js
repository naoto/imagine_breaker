new Vue({
  el: '#main',

  created: function(){
    var vm = this;
    
    superagent.get('/images', function(response){
      vm.images = response.body;
      vm.images.forEach(function(name){
        vm.imagesurl.push({url: name['url'], imagestag: name['tags'], dl: name['url'], cp: name['url']});
      });
    });
  },
  methods: {
    search: function(){
      var vm = this;
      var tags = this.searchImage.replace(/\s?,\s?/, '/');
      vm.imagesurl = [];
      superagent.get('/images/' + tags, function(response){
        vm.images = response.body;
        vm.images.forEach(function(name){
          vm.imagesurl.push({url: name['url'], imagestag: name['tags'], dl: name['url'], cp: name['url']});
        });
      });
      
    },
    register: function(){
      var vm = this;

      superagent.post('/images')
                .send({url: this.url, tags: this.tags})
                .end(function(err, response){
        vm.images.push(response.body);
        vm.imagesurl.push({url: response.body['url'], imagestag: response.body['tags']});
        this.url = '';
        this.tags = '';
      });
    },
    tagsearch: function(e){
      var vm = this;
      var tag = e.target.innerText;
      vm.searchImage = tag;
      vm.imagesurl = [];
      superagent.get('/images/' + tag, function(response){
        vm.images = response.body;
        vm.images.forEach(function(name){
          vm.imagesurl.push({url: name['url'], imagestag: name['tags'], dl: name['url'], cp: name['url']});
        });
      });
    }
  },
  data: {
    images: [],
    imagesurl: [],
    url: '',
    dl: '',
    cp: '',
    tags: '',
    searcchImage: ''
  }
});
