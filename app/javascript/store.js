import Vue from 'vue'
import Puex from 'puex'

Vue.use(Puex)

export default new Puex({
  state: {},
  mutations: {
    ENTITY_UPDATED(state, payload) {
      console.log("woot")
    }
  },
  
})