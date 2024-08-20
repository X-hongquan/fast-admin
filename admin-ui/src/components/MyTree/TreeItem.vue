<script setup>
defineProps({
  data: {
    type: String,
    default: ''
  },
})
</script>

<template>
  <li >{{ data }}</li>
</template>

<style scoped lang="scss">
li {
  margin: 10px;
  font-size: 16px;
  line-height: 1.5;
  cursor: pointer;

  &:hover {
    background-color: #f0f0f0;
  }
}
</style>
