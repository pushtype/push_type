import Vue from 'vue';
import moment from 'moment';

export default Vue.component('node-form', {

  props: {
    node: {
      coerce: (val) => JSON.parse(val)
    }
  },

  computed: {
    humanizedType: function() {
      return this.node.type.replace( /([A-Z])/g, (m) => ` ${ m.toLowerCase() }` ).trim();
    },

    isPublished: function() {
      return this.node.status === 'published';
    },

    saveButtonText: function() {
      switch(this.node.status) {
        case 'draft':
          if (this.node['new_record?'] || !this.node.published_at) {
            return 'Save draft';
          } else {
            return `Unpublish ${ this.humanizedType }`;
          }
        case 'published':
          if (this.node['new_record?'] || !this.node.published_at) {
            return this.publishedAtMoment.toDate() > new Date() ? 'Publish later' : 'Publish now';
          } else {
            return `Save ${ this.humanizedType }`;
          }
      }
    },

    publishedAtMoment: function() {
      return this.node.published_at ? moment(this.node.published_at) : moment();
    },

    publishedDates: function() {
      switch(this.node.status) {
        case 'draft':
          return 'N/A';
        case 'published':
          if (this.node['new_record?'] || !this.node.published_at) {
            return this.publishedAtMoment.toDate() > new Date() ? this.publishedAtMoment.format('Do MMM YYYY, h:mma') : 'Immediately';
          } else {
            return this.publishedAtMoment.format('Do MMM YYYY, h:mma');
          }
      }
    }
  },

  methods: {
    setSlug: function() {
      if (this.node['new_record?']) {
        this.node.slug = this.node.title.toLowerCase();
        this.node.slug = this.node.slug.replace(/[ÀÁÂÃÄÅ]/g,"A");
        this.node.slug = this.node.slug.replace(/[àáâãäå]/g,"a");
        this.node.slug = this.node.slug.replace(/[ÉÈÊËĘĖĒ]/g,"E");
        this.node.slug = this.node.slug.replace(/[éèêëęėē]/g,"e");
        this.node.slug = this.node.slug.replace(/[ÝŸ]/g,"Y");
        this.node.slug = this.node.slug.replace(/[ýÿ]/g,"y");
        this.node.slug = this.node.slug.replace(/[ÚÛÜÙŪ]/g,"U");
        this.node.slug = this.node.slug.replace(/[úûüùū]/g,"u");
        this.node.slug = this.node.slug.replace(/[ÍÎÏÌĮĪ]/g,"I");
        this.node.slug = this.node.slug.replace(/[íîïìįī]/g,"i");
        this.node.slug = this.node.slug.replace(/[ÓÖÔÒÕØŌ]/g,"O");
        this.node.slug = this.node.slug.replace(/[óöôòõøō]/g,"o");
        this.node.slug = this.node.slug.replace(/[Ð]/g,"D");
        this.node.slug = this.node.slug.replace(/[ð]/g,"d");
        this.node.slug = this.node.slug.replace(/[Æ]/g,"AE");
        this.node.slug = this.node.slug.replace(/[æ]/g,"ae");
        this.node.slug = this.node.slug.replace(/[Þ]/g,"TH");
        this.node.slug = this.node.slug.replace(/[þ]/g,"th");

        this.node.slug = this.node.slug.replace(/[\s\_]/g, '-').replace(/[^\w\-]/g, '');
      }
    }
  }

})
