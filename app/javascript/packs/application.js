/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import Viewport from '../viewport.vue'
import store from '../store'

document.addEventListener('DOMContentLoaded', () => {
  const viewport = new Vue({
    store,
    el: document.getElementById('viewport'),
    render: h => h(Viewport)
  })
})

// Create one channel for events only for me.
App.events = App.cable.subscriptions.create({channel: "EventsChannel", subject: 'me'}, {
  connected: function() {
    this.perform('retrieve_entity', {id: window.played_entity_id})
    this.perform('retrieve_all_entities')
  },
  received: function(data) {
    store.commit(data[0], data[1])
  }
});
// Create one channel for events visible to all
App.cable.subscriptions.create({channel: "EventsChannel", subject: 'entities'}, {
  received: function(data) {
    store.commit(data[0], data[1])
  }
});


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
