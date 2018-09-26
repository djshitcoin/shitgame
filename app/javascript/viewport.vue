<template>
  <div class="viewport">
    <div v-if="$store.getters.controlledEntity()">
      <div class="name">{{ $store.getters.controlledEntity().name }}</div>
      <div class="level">Level {{ $store.getters.controlledEntity().level() }}</div>
      <div class="stat_bar health_bar">
        <div class="filling" :style="{width: $store.getters.controlledEntity().hp_percentage() + '%'}"></div>
        <div class="health" v-if="$store.getters.controlledEntity().hp() > 0">
          {{ Math.ceil($store.getters.controlledEntity().hp()) }} / {{ $store.getters.controlledEntity().max_hp() }}
        </div>
        <div class="health" v-else>
          Fainted. Wait {{ Math.ceil($store.getters.controlledEntity().remaining_downtime()) }}s
        </div>
      </div>
      <div class="stat_bar exp_bar">
        <div class="filling" :style="{width: $store.getters.controlledEntity().level_up_percentage() + '%'}"></div>
        <div class="exp">
          {{ Math.ceil($store.getters.controlledEntity().exp_on_level()) }} / {{ $store.getters.controlledEntity().level_up_at_relative() }}
        </div>
      </div>
    </div>
    <div class="world">
      <h1>Shitcoin Kingdom</h1>
      <p>Oh no! These Fudsters are attacking the castle!</p>
      <div class="entity" v-if="id != $store.state.controlledEntityId" v-for="(entity, id) in $store.state.allEntities" :key="id">
        <div class="name">{{ entity.name }}</div>
        <div class="level">Level {{ entity.level() }}</div>
        <div class="stat_bar health_bar">
          <div class="filling" :style="{width: entity.hp_percentage() + '%'}"></div>
          <div class="health">{{ Math.ceil(entity.hp()) }} / {{ entity.max_hp() }}</div>
        </div>
        <button @click="attack(entity)">Attack</button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  mounted() {
    const update = () => {
      this.$forceUpdate()
      requestAnimationFrame(update)
    }
    requestAnimationFrame(update)
  },
  methods: {
    ...mapActions(['attack'])
  }
}
</script>

<style lang="scss">
.health_bar {
  position: relative;
  width: 140px;
  height: 18px;
  border: 1px solid black;
  .filling {
    position: absolute;
    height: 100%;
    background: red;
  }
  .health {
    position: absolute;
    text-align: center;
    width: 100%;
    font-weight: bold;
  }
}
.entity {
  margin: 12px;
}
.exp_bar {
  position: relative;
  width: 140px;
  height: 18px;
  border: 1px solid black;
  .filling {
    position: absolute;
    height: 100%;
    background: green;
  }
  .exp {
    position: absolute;
    text-align: center;
    width: 100%;
    font-weight: bold;
  }
}
</style>
