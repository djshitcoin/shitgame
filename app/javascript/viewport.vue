<template>
  <div v-if="$store.state.hodler">
    <div class="health_bar">
      <div class="filling" :style="{width: $store.state.hodler.hp_percentage() + '%'}"></div>
      <div class="health">{{ Math.ceil($store.state.hodler.hp()) }} / {{ $store.state.hodler.max_hp() }}</div>
    </div>
  </div>
  <div v-else>Loading...</div>
</template>

<script>
export default {
  mounted() {
    const update = () => {
      this.$forceUpdate()
      requestAnimationFrame(update)
    }
    requestAnimationFrame(update)
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
</style>
