<script setup>
import setting from "../../../setting.js";

</script>

<template>
  <div class="logo-main">
    <img src="../../assets/vue.svg" >
    <span >{{ setting.logoTitle}}</span>
  </div>

</template>

<style scoped lang="scss">
.logo-main {
  display: flex;
  align-items: center;
  height: 100%;
  width: 100%;
  img {
    margin: 0 10px;
    height: 40px;
    width: 40px;
  }
  span {
    font-size: 18px;
    color: white;
  }
}

</style>
