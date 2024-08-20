<script setup>
import TreeItem from './TreeItem.vue'

defineProps({
  data: {
    type: Array,
    default: []
  }
})
</script>

<script>
export default {
  name: 'MyTree',
}
</script>

<template>
  <ul>
    <template v-for="item in data">
      <TreeItem :data="item.key" ></TreeItem>
      <MyTree :data="item.children" v-if="item.children"></MyTree>
    </template>
  </ul>
</template>

<style scoped lang="scss">
ul {
  padding-left: 15px;
}
</style>
