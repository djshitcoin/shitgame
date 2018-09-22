import Vue from 'vue'
import Puex from 'puex'

Vue.use(Puex)

const allEntities = []

export default new Puex({
  state: {
    hodler: null
  },
  mutations: {
    UPDATE_ENTITY(state, payload) {
      const entity = Object.create(Entity)
      Object.assign(entity, payload)
      state.hodler = entity
      
      window.hodler = state.hodler
    }
  },
  
})