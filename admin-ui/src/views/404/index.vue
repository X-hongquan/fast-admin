<script setup>
import {useRouter} from 'vue-router';

let $router = useRouter();
const goHome = () => {
  $router.push('/home')
}
</script>


<template>
  <div class="box">
     <div>
     </div>
  </div>

</template>


<style scoped lang="scss">
.box {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  div {
    width: 1014px;
    height: 556px;
    background-image: url("@/assets/images/error_images/404.png");
  }
}
</style>
