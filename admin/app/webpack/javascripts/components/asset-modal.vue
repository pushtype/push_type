<template>
  <div class="asset-field-modal">
    <ul class="tabs" data-tab>
      <li class="tab-title active"><a href="#media" data-success><i class="fi-thumbnails"></i> Media</a></li>
      <li class="tab-title"><a href="#upload"><i class="fi-upload"></i> Upload</a></li>
    </ul>
    <div class="tabs-content">
      <div id="media" class="content active">
        <div class="empty-default" v-show="!hasAssets()">
          <h2>No uploads</h2>
          <p>No media has been uploaded yet.</p>
        </div>
        <ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4" v-show="hasAssets()">
          <li v-for="asset in assets">
            <article class="asset-list-item">
              <a v-on:click.prevent="selectAsset(asset)">
                <div class="preview">
                  <img v-bind:src="asset.preview_thumb_url" v-bind:alt="asset.file_name">
                </div>
                <div class="title">{{ asset.description_or_file_name }}</div>
              </a>
            </article>
          </li>
        </ul>
        <div class="pagination-centered" v-simple-pagination="meta" v-show="hasAssets()"></div>
      </div>
      <div id="upload" class="content">
        <div class="asset-upload">
          <div class="dropzone" v-asset-upload maxfiles="10">
            <div class="prompt">Drag files to quickly upload them&hellip;</div>
            <div class="icon"><i class="fi-upload-cloud"></i></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import $ from 'jquery';

export default {
  props: ['revealId'],

  data: function() {
    return {
      assets: [],
      meta: {}
    }
  },

  ready: function() {
    this.$modal.on('open.fndtn.reveal', () => this.loadAssets());
  },

  computed: {
    indexPath: function() {
      return `${ PushType.Routes.adminPath }/media`;
    },

    $modal: function() {
      return $(`#${ this.revealId }`);
    }
  },

  methods: {
    hasAssets: function() {
      return this.assets.length;
    },

    loadAssets: function(page) {
      let config = {
        params: { page: page || 1 }
      };
      this.$http.get(this.indexPath, config).then(function(r) {
        this.assets = r.data.assets;
        this.meta = r.data.meta;
      })
    },

    afterUpload: function() {
      this.loadAssets();
      $(this.$el).find('.tab-title a[data-success]').trigger('click');
    },

    selectAsset: function(asset) {
      this.$parent.selectAsset(asset);
      this.$modal.foundation('reveal', 'close');
    }
  }
}
</script>

