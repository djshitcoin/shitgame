import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
window.allEntities = {}
export default new Vuex.Store({
  state: {
    controlledEntityId: window.played_entity_id,
    allEntities: window.allEntities
  },
  getters: {
    // returning a function instead of value to circumvent vuex' caching. maybe shouldnt use vue for this. switch to real game engine instead vue?
    controlledEntity: state => () => state.allEntities[state.controlledEntityId]
  },
  mutations: {
    UPDATE_ENTITY(state, payload) {
      if (payload.destroyed) {
        delete state.allEntities[payload.id]
        return
      }
      let entity = state.allEntities[payload.id];
      if (!entity) {
        entity = state.allEntities[payload.id] = Object.create(EntityProto);
      }
      Object.assign(entity, payload)
    }
  },
  actions: {
    attack({state}, target) {
      App.events.perform('attack', {
        target_id: target.id,
        attacker_id: state.controlledEntityId
      })
    }
  }
  
})